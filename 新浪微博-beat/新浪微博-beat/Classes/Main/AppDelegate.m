//
//  AppDelegate.m
//  新浪微博-beat
//
//  Created by lyh on 15/10/17.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "AppDelegate.h"
#import "RootController.h"
#import "LaunchController.h"
#import "OAuthViewController.h"
#import "AccountInfo.h"
#import "EVAAccountTool.h"
#import "SDWebImageManager.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    

    AccountInfo *account = [EVAAccountTool account];
    
    /**
     *  token 可能过期
     */
    
    /**
     *  检测本地是否存储用户信息    登陆过
     */
    if (account) {
        [self.window switchRootViewController];
    }else {
        self.window.rootViewController = [[OAuthViewController alloc] init];
    }
    
    UIUserNotificationSettings *settings =
    [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    [self.window makeKeyAndVisible];
    return YES;
}


#warning 这种方式还是太冗杂, applicationDelegate 只需要创建窗口和设置根视图, 根视图有多少子控制器不需要知道

/*
 - (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
 
 childVc.tabBarItem.title = title;
 childVc.tabBarItem.image = [UIImage imageNamed:image];
 childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: rgbColor(255, 109, 0)} forState:UIControlStateSelected];
 childVc.view.backgroundColor = randomColor;
 }
 */
/*
 -(void) text2{
 UITabBarController *tabBarCon = [[UITabBarController alloc]init];
 
 HomeController *home = [[HomeController alloc]init];
 MessageController *message = [[MessageController alloc]init];
 DiscoverController *discover = [[DiscoverController alloc]init];
 ProfileController *profile = [[ProfileController alloc]init];
 
 [self addChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
 [self addChildVc:message title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
 [self addChildVc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
 [self addChildVc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
 
 [tabBarCon addChildViewController:home];
 [tabBarCon addChildViewController:message];
 [tabBarCon addChildViewController:discover];
 [tabBarCon addChildViewController:profile];
 //    tabBarCon.viewControllers = @[vc1, vc2, vc3, vc4];
 }
 */

-(void) text{
    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.tabBarItem.title = @"首页";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    /**
     *  设置被选正时的图片, 会自动被系统渲染成蓝色
     */
    UIImage *home_selectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
    /**
     *  以原始状态的渲染方式返回一张新的图片
     */
    home_selectedImage = [home_selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc1.tabBarItem.selectedImage = home_selectedImage;
    /**
     *  字体颜色也需要设置
     */
    [vc1.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: rgbColor(255, 109, 0)} forState:UIControlStateSelected];
    vc1.view.backgroundColor = randomColor;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    /**
     *  app的状态
     *  1.死亡状态：没有打开app
     *  2.前台运行状态
     *  3.后台暂停状态：停止一切动画、定时器、多媒体、联网操作，很难再作其他操作
     *  4.后台运行状态
     */
    // 向操作系统申请后台运行的资格，能维持多久，是不确定的
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        // 当申请的后台运行时间已经结束（过期），就会调用这个block
        
        // 赶紧结束任务
        [application endBackgroundTask:task];
    }];
    
    // 在Info.plst中设置后台模式：Required background modes == App plays audio or streams audio/video using AirPlay
    // 搞一个0kb的MP3文件，没有声音    >>>>  模拟音频播放
    // 循环播放
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    
}

@end
