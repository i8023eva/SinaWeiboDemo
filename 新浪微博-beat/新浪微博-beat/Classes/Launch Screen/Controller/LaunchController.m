//
//  LaunchController.m
//  新浪微博-beat
//
//  Created by lyh on 15/10/21.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "LaunchController.h"

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
    scrollView.showsHorizontalScrollIndicator = NO;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
