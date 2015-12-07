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

@interface HomeController ()<EVADropDownMenuDelegate>

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [self setNavigationItem];
    
    [self getUserInfo];
    
}

-(void) setNavigationItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self Action:@selector(didClickForFriendSearch:) image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self Action:@selector(didClickForPop:) image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted"];
    
    UIButton *titleButton = [[UIButton alloc]init];//这种创建方式等同于 style: Custom
    
    titleButton.size = CGSizeMake(150, 30);
    //    titleButton.backgroundColor = rgbColor(100, 100, 100);
    
    [titleButton setTitle:@"首页" forState: UIControlStateNormal];
    [titleButton setTitleColor:rgbColor(0, 0, 0) forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];//粗体
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    /**
     *  直接设置选中状态, 是否被选中来更换图片比填图片名要简单;
     */
    titleButton.selected = NO;
    
    //    titleButton.imageView.backgroundColor = [UIColor redColor];
    //    titleButton.titleLabel.backgroundColor = [UIColor blueColor];
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 80, 0, 0);//实现图片在右边    这个方法支持的是像素, 而 frame 都是点
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);///和所在 btn 的宽度有很大关系
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
        
        NSString *name = responseObject[@"name"];
        [titleBtn setTitle:name forState:UIControlStateNormal];
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@", error);
    }];

}


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
     *  显示时, 改变图片朝向
     */
    UIButton *btn = (UIButton *)self.navigationItem.titleView;
//    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


@end
