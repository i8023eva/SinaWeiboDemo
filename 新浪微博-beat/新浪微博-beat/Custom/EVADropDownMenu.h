//
//  EVADropDownMenu.h
//  新浪微博-beat
//
//  Created by lyh on 15/10/19.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EVADropDownMenu;
@protocol EVADropDownMenuDelegate <NSObject>
/**
 *  设置一个代理监听当下拉消失时执行
 */
-(void) dropDownMenuDidDismiss: (EVADropDownMenu *)dropDownMenu;

-(void) dropDownMenuDidShow:(EVADropDownMenu *)dropDownMenu;
@end

@interface EVADropDownMenu : UIView

@property (nonatomic, weak) id<EVADropDownMenuDelegate> eva_delegate;

@property (nonatomic, strong) UIView *content;
/**
 *  发现内容只能放 view 是不够的, 有时可能需要放控制器
 */
@property (nonatomic, strong) UIViewController *contentController;

+(instancetype) dropDownMenu;

-(void) showFromView:(UIView *) view;
-(void) dismiss;
@end
