//
//  EVATitleButton.m
//  新浪微博-beat
//
//  Created by lyh on 15/12/8.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "EVATitleButton.h"

@implementation EVATitleButton

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];//粗体
        [self setTitleColor:rgbColor(0, 0, 0) forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    
    // 只要修改了文字，就让按钮重新计算自己的尺寸
    [self sizeToFit];  //修身效果
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    
    [self sizeToFit];
}

-(void)layoutSubviews {  //只想改位置
    [super layoutSubviews];
    
    self.titleLabel.x = self.imageView.x;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}

//-(CGRect)titleRectForContentRect:(CGRect)contentRect {}    修改位置还有大小
//-(CGRect)imageRectForContentRect:(CGRect)contentRect {}


@end
