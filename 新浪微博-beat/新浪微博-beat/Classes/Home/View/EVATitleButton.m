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

/**
 *  重写setFrame:方法的目的：拦截设置按钮尺寸的过程
 *  如果想在系统设置完控件的尺寸后，再做修改，而且要保证修改成功，一般都是在setFrame:中设置
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.width += 5;    //在 super 前面设置
    [super setFrame:frame];
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

#pragma mark - 第二次加载时imageView.x 变化
-(void)layoutSubviews {  //只想改位置
    [super layoutSubviews];
    
//    self.titleLabel.x = self.imageView.x;
    
#warning 修改位置变换问题
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.width, 0, self.imageView.width);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.width + 5, 0, -self.titleLabel.width - 5);
    
//    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}

//-(CGRect)titleRectForContentRect:(CGRect)contentRect {}    修改位置还有大小
//-(CGRect)imageRectForContentRect:(CGRect)contentRect {}


@end
