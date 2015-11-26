//
//  UIBarButtonItem+CustomView.m
//  新浪微博-beat
//
//  Created by lyh on 15/10/18.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "UIBarButtonItem+CustomView.h"

@implementation UIBarButtonItem (CustomView)

+(UIBarButtonItem *)barButtonItemWithTarget:(id)target Action:(SEL)action image:(NSString *)image highlightedImage:(NSString *)highlightedImage{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [btn setBackgroundImage:[UIImage imageNamed: image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed: highlightedImage] forState:UIControlStateHighlighted];
    
    btn.size = btn.currentBackgroundImage.size;
    /**
     *  使用自定义视图
     */
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end
