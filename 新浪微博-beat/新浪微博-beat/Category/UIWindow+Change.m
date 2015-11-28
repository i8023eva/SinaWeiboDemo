//
//  UIWindow+switch.m
//  新浪微博-beat
//
//  Created by lyh on 15/11/28.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "UIWindow+Change.h"
#import "RootController.h"
#import "LaunchController.h"

@implementation UIWindow (Change)

- (void)switchRootViewController {
    NSString *key = @"CFBundleVersion";
    // 上一次的使用版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    // 当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) { // 版本号相同：这次打开和上次打开的是同一个版本
        self.rootViewController = [[RootController alloc] init];
    } else { // 这次打开的版本和上一次不一样，显示新特性
        self.rootViewController = [[LaunchController alloc] init];
        
        // 将当前的版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
