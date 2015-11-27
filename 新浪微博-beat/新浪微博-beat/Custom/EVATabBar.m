//
//  EVATabBar.m
//  新浪微博-beat
//
//  Created by lyh on 15/10/19.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "EVATabBar.h"



@interface EVATabBar ()

@property (nonatomic, weak) UIButton *plusBtn;
@end

@implementation EVATabBar
/**
 *  动态绑定
 */
@dynamic delegate;

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIButton *plusBtn = [[UIButton alloc]init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        [plusBtn addTarget:self action:@selector(didClickPlusBtn:) forControlEvents:UIControlEventTouchUpInside];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];//调用父类很有必要, 需要布置背景和顶部线条
    
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    
    CGFloat tabBarW = self.width / 5; //固定按钮数为5
    CGFloat tabBarIndex = 0;
    
    for (UIView *child in self.subviews) {
        
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = tabBarW;
            child.x = tabBarW * tabBarIndex;
            
            tabBarIndex++;
            if (tabBarIndex == 2) {
                tabBarIndex++;
            }
        }
    }
//    EVALog(@"%@", self.subviews);
}

-(void) didClickPlusBtn:(UIButton *) sender{
    
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        
        [self.delegate tabBarDidClickPlusButton:self];
    }
}




@end
