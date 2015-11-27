//
//  LaunchController.m
//  新浪微博-beat
//
//  Created by lyh on 15/10/21.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "LaunchController.h"
#import "RootController.h"

#define kNewFeature 4

@interface LaunchController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;
@end


@implementation LaunchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(scrollView.width * kNewFeature, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;//不创建滚动条
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i < kNewFeature; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * scrollW;
        imageView.image = [UIImage imageNamed: [NSString stringWithFormat: @"new_feature_%d", i + 1]];
        [scrollView addSubview:imageView];
        
        // 如果是最后一个imageView，就往里面添加按钮   >> 不要判断 scrollView.subViews,  scrollView存在其他子控件
        if (i == kNewFeature - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = kNewFeature;
    pageControl.backgroundColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = rgbColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = rgbColor(189, 189, 189);
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    // UIPageControl就算没有设置尺寸，里面的内容还是照常显示的, 只是使其不能点击
    //    pageControl.width = 100;
    //    pageControl.height = 50;
    //    pageControl.userInteractionEnabled = NO;
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    /**
     *  /page >> 零点几  >> 大于0.5的时候[超过一半] >> 就让 pageView 改变
     */
    double page = scrollView.contentOffset.x / scrollView.width;
    // [取整 ]计算出页码
    self.pageControl.currentPage = (int)(page + 0.5);
}

-(void) setupLastImageView: (UIImageView *)imageView {
    // 开启交互功能
    imageView.userInteractionEnabled = YES;
    
    // 1.分享给大家（checkbox）
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.width = 200;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.65;
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
    
    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    
//    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    // 2.开始微博
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.75;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
}

- (void)shareClick:(UIButton *)shareBtn {
    // 状态取反
    shareBtn.selected = !shareBtn.isSelected;
}

- (void)startClick
{
    // 切换到HWTabBarController
    /*
     切换控制器的手段
     1.push：依赖于UINavigationController，控制器的切换是可逆的，比如A切换到B，B又可以回到A
     2.modal：控制器的切换是可逆的，比如A切换到B，B又可以回到A
     3.切换window的rootViewController
     */
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[RootController alloc] init];
    
    // modal方式，不建议采取：新特性控制器不会销毁
    //    HWTabBarViewController *main = [[HWTabBarViewController alloc] init];
    //    [self presentViewController:main animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    NSLog(@"dealloc ---%s ---%d", __func__, __LINE__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
