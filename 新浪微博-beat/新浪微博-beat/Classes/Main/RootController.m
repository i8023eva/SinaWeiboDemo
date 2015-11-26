//
//  RootController.m
//  新浪微博-beat
//
//  Created by lyh on 15/10/18.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "RootController.h"
#import "HomeController.h"
#import "DiscoverController.h"
#import "MessageController.h"
#import "ProfileController.h"
#import "EVANavigationController.h"
#import "EVATabBar.h"

@interface RootController ()<EVATabBarDelegate>

@end

@implementation RootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HomeController *home = [[HomeController alloc]init];
    MessageController *message = [[MessageController alloc]init];
    DiscoverController *discover = [[DiscoverController alloc]init];
    ProfileController *profile = [[ProfileController alloc]init];
    
    [self addChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    [self addChildVc:message title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    [self addChildVc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    [self addChildVc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
//    self.tabBar = [[EVATabBar alloc]init];
    /**
     *  tabBar 是系统只读的私有属性, 可以通过 KVC 去修改
     */
    EVATabBar *eva_tabBar = [[EVATabBar alloc]init];
//    eva_tabBar.delegate = self;     让超类去实现 delegate
    /**
     *   替换系统的属性时, 最好先设置好自己的,  >> self.tarBar = eva_tabBar;
     */
    [self setValue:eva_tabBar forKey:@"tabBar"];
//    eva_tabBar.delegate = self;   >>放这里会有异常
#warning KVC
    /*
     [self setValue:tabBar forKeyPath:@"tabBar"];相当于self.tabBar = tabBar;
     [self setValue:tabBar forKeyPath:@"tabBar"];这行代码过后，tabBar的delegate就是HWTabBarViewController
     说明，不用再设置tabBar.delegate = self;
     */
    
    /*
     1.如果tabBar设置完delegate后，再执行下面代码修改delegate，就会报错
     tabBar.delegate = self;
     
     2.如果再次修改tabBar的delegate属性，就会报下面的错误
     错误信息：Changing the delegate of a tab bar managed by a tab bar controller is not allowed.
     错误意思：不允许修改TabBar的delegate属性(这个TabBar是被TabBarViewController所管理的)
     */
    
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
//    childVc.tabBarItem.title = title;//tabbar的文字
//    childVc.navigationItem.title = title;//navigationbar的文字
#warning 这一句等同于上面两句
    childVc.title = title;
    
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: rgbColor(255, 109, 0)} forState:UIControlStateSelected];
#warning 不要随意调用 .view
//    childVc.view.backgroundColor = randomColor;//[1]在这里 .view >>> [MessageController viewDidLoad]
    /**
     *  这里设置的根视图控制器也是 push 进去的
     */
    EVANavigationController *nv = [[EVANavigationController alloc]initWithRootViewController:childVc];//[2]但是这时的主题设置并没有生效
    [self addChildViewController:nv];
    /**
     *  tabbarController 把子控制器加到 数组中, 所以切换页面时, 不会销毁
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - EVATabBarDelegate
-(void)tabBarDidClickPlusButton:(EVATabBar *)tabBar{
    
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor colorWithRed:0.755 green:0.885 blue:1.000 alpha:1.000];
    [self presentViewController:vc animated:YES completion:nil];
    
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
