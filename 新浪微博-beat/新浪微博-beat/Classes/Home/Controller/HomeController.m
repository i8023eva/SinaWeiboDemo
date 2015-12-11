//
//  HomeController.m
//  新浪微博-beat
//
//  Created by lyh on 15/10/18.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "HomeController.h"
#import "EVADropDownMenu.h"
#import "HomeDropDownMenuController.h"
#import "AFNetworking.h"
#import "EVAAccountTool.h"
#import "AccountInfo.h"
#import "EVATitleButton.h"
#import "Status.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "LoadMoreFooterView.h"

@interface HomeController ()<EVADropDownMenuDelegate>
/**
 *  微博数组（里面放的都是Status模型，一个HWStatus对象就代表一条微博）
 */
@property (nonatomic, strong) NSMutableArray *statuses;
@end

@implementation HomeController

- (NSMutableArray *)statuses
{
    if (!_statuses) {
        self.statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [self setNavigationItem];
    
    [self getUserInfo];
    
    [self setupHeadRefresh];
    
    [self setupFooterRefresh];
}

#pragma mark - 设置 NavigationBar
-(void) setNavigationItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self Action:@selector(didClickForFriendSearch:) image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self Action:@selector(didClickForPop:) image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted"];
    
    EVATitleButton *titleButton = [[EVATitleButton alloc]init];//这种创建方式等同于 style: Custom
    
    NSString *name = [EVAAccountTool account].name;
    [titleButton setTitle:name? name: @"首页" forState: UIControlStateNormal];

    /**
     *  直接设置选中状态, 是否被选中来更换图片比填图片名要简单;
     */
//    titleButton.selected = NO;
    
//    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 80, 0, 0);//实现图片在右边    这个方法支持的是像素, 而 frame 都是点
//    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);///和所在 btn 的宽度有很大关系
    /**
     *   CGImageCreateWithImageInRect(CGImageRef  _Nullable image, CGRect rect)
     
     *  @param CGRect 这个方法中的 rect 也是像素值
     */
    /**  >>> 备用方法    自定义 Button
     *  - (CGRect)titleRectForContentRect:(CGRect)contentRect;
     *  - (CGRect)imageRectForContentRect:(CGRect)contentRect;
     */
    [titleButton addTarget:self action:@selector(didClickForTitle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

#pragma mark - 获取用户信息
-(void) getUserInfo {
    /**
     *  https://api.weibo.com/2/users/show.json     根据用户ID获取用户信息
     
     > access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     > uid	false	int64	需要查询的用户ID。
     
     ----参数uid与screen_name二者必选其一，且只能选其一；
     ----接口升级后，对未授权本应用的uid，将无法获取其个人简介、认证原因、粉丝数、关注数、微博数及最近一条微博内容。
     */
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // AFN的AFJSONResponseSerializer默认不接受text/plain这种类型     acceptableContentTypes
    //"Request failed: unacceptable content-type: text/plain"
    
    AccountInfo *info = [EVAAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = info.access_token;
    params[@"uid"] = info.uid;
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        
        User *user = [User mj_objectWithKeyValues:responseObject];
        [titleBtn setTitle:user.name forState:UIControlStateNormal];
        
        // 存储昵称到沙盒中
        info.name = user.name;
        [EVAAccountTool saveAccount:info];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"userinfo请求失败-%@", error);
    }];

}

#pragma mark - 下拉刷新
- (void) setupHeadRefresh
{
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    //马上进入刷新状态(仅仅是显示刷新状态，并不会触发UIControlEventValueChanged事件)
    [control beginRefreshing];
    
    //马上加载数据
    [self refreshStateChange:control];
}

-(void) refreshStateChange:(UIRefreshControl *)sender {
    
    //https://api.weibo.com/2/statuses/friends_timeline.json  >>获取当前登录用户及其所关注（授权）用户的最新微博
    
    /**
     >  access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     
     >  max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
     >  count	false	int	单页返回的记录条数，最大不超过100，默认为20。
     */
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    AccountInfo *account = [EVAAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最前面的微博（最新的微博，ID最大的微博）
    Status *firstStatus = [self.statuses firstObject];
    
    if (firstStatus) {   //>>>>>是否有数据
        
//        >  since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
        params[@"since_id"] = firstStatus.idstr;
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [Status mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        //
        [self.statuses insertObjects:newStatuses atIndexes:set];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新刷新
        [sender endRefreshing];
        
        // 显示最新微博的数量
        [self showNewStatusCount:newStatuses.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@", error);
        
        // 结束刷新刷新
        [sender endRefreshing];
    }];
}

/**
 *  显示最新微博数量
 *
 *  @param label 动画
 */
-(void) showNewStatusCount:(NSUInteger) count {
    
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = kWidth;
    label.height = 44;
    label.y = 20;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    
    if (count == 0) {
        label.text = @"没有新的微博数据，稍后再试";
    }else {
        label.text = [NSString stringWithFormat:@"共有%lu条新的微博数据", count];
    }
    //导航栏下面, tableView 上面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:1.f animations:^{
        
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.f delay:1.f options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
            [label removeFromSuperview];
        }];
    }];
    
}

#pragma mark - 上拉加载
-(void) setupFooterRefresh {
 
    LoadMoreFooterView *footer = [LoadMoreFooterView loadMoreFooterView];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.statuses.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatus];
    }
    
    /*
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */
}

- (void)loadMoreStatus
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    AccountInfo *account = [EVAAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    Status *lastStatus = [self.statuses lastObject];
    if (lastStatus) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatus.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [Status mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将更多的微博数据，添加到总数组的最后面
        [self.statuses addObjectsFromArray:newStatuses];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@", error);
        
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
}


#pragma mark - 标题按钮点击
-(void) didClickForTitle: (UIButton *)sender{
    
    EVADropDownMenu *dropDownMenu = [EVADropDownMenu dropDownMenu];
#warning 忘记遵守协议
    dropDownMenu.eva_delegate = self;
    
    HomeDropDownMenuController *homeCon = [[HomeDropDownMenuController alloc] init];
    homeCon.view.height = 44 * 3;
    homeCon.view.width = 150;
    dropDownMenu.contentController = homeCon;
    
    [dropDownMenu showFromView:sender];
}

#pragma mark - EVADropDownMenu
-(void)dropDownMenuDidDismiss:(EVADropDownMenu *)dropDownMenu{
    /**
     *  点击下拉菜单消失时, 图片朝向恢复
     */
    UIButton *btn = (UIButton *)self.navigationItem.titleView;
//    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    btn.selected = NO;
}

-(void)dropDownMenuDidShow:(EVADropDownMenu *)dropDownMenu{
    /**
     *  显示时, 改变图片朝向/
     */
    UIButton *btn = (UIButton *)self.navigationItem.titleView;
//    [btn setImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
    btn.selected = YES;
}



-(void) test{
    /**
     *  如果图片某个方向上不规则, 那这个方向就不能拉伸
     */
    UIImageView *dropDownMenu = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"popover_background"]];
    dropDownMenu.userInteractionEnabled = YES;//用户交互
    
    dropDownMenu.size = CGSizeMake(217, 300 );
    dropDownMenu.y = 64;
    dropDownMenu.x = (self.view.width - dropDownMenu.width) / 2;
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    /**
     *  添加蒙板    大小 self.view.bounds 遮不住 tabBar
     */
#warning window.bounds
    UIView *cover = [[UIView alloc]initWithFrame:window.bounds];
    cover.backgroundColor = [UIColor clearColor];
    [window addSubview:cover];
    
    
    /**
     *  添加在视图所在窗口, 就不会随 tableView 移动
     */
    [window addSubview:dropDownMenu];
    /**
     *    [UIApplication sharedApplication].keyWindow; 这个窗口会被键盘覆盖, 键盘也是一个窗口,
     >> 添加到windows这个数组中最后一个窗口, 基本就是在最上层, 但如果后点击键盘还是不行
     *
     *    [2]self.view.window  这种方式的window 可能不存在
     */
}

-(void) didClickForFriendSearch:(UIBarButtonItem *) sender{
    
}

-( void) didClickForPop:(UIBarButtonItem *) sender{
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    Status *status = self.statuses[indexPath.row];
    User *user = status.user;
    
    UIImage *placeholderImage = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:placeholderImage];
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = status.text;
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
