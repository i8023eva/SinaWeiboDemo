//
//  EVATabBar.h
//  新浪微博-beat
//
//  Created by lyh on 15/10/19.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EVATabBar;
@protocol EVATabBarDelegate <UITabBarDelegate>

@optional
-(void) tabBarDidClickPlusButton:(EVATabBar *) tabBar;

@end

@interface EVATabBar : UITabBar  
/**
 *  Auto property synthesis will not synthesize property 'delegate'; it will be implemented by its superclass, use @dynamic to acknowledge intention
 */
@property (nonatomic, weak) id<EVATabBarDelegate> delegate;
@end
