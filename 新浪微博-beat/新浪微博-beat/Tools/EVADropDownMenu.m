//
//  EVADropDownMenu.m
//  新浪微博-beat
//
//  Created by lyh on 15/10/19.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "EVADropDownMenu.h"

@interface EVADropDownMenu ()
/**
 *  用来装载内容的容器
 */
@property (nonatomic, weak) UIImageView *containerView;

@end

@implementation EVADropDownMenu

+(instancetype) dropDownMenu{
    
    return [[self alloc] init];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

-(UIImageView *) containerView {
    if (_containerView == nil) {
        
        UIImageView *containerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"popover_background"]];
        containerView.userInteractionEnabled = YES;//用户交互
        
//        containerView.size = CGSizeMake(217, 300 );
        containerView.y = 64;
//        containerView.x = (375 - containerView.width) /2;
        
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

-(void)setContent:(UIView *)content{
    
    _content = content;
    
    content.x = 10;//图片的外边距 
    content.y = 20;
//    self.containerView.width = content.width + content.x;    发现改这个并不是很好, 平铺时的图片不能横向拉伸, 所以我们需要让宽度是固定的   ;;;;;;;后面又改成拉伸了
    
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    /**
     *  需要让容器去适应内容的高度和宽度
     */
    self.containerView.height = CGRectGetMaxY(content.frame) + 15;
    
    /**
     *  在容器中添加内容
     */
    [self.containerView addSubview:content];
}

-(void)setContentController:(UIViewController *)contentController{
    
    _contentController = contentController;
    
    self.content = contentController.view;
}

/**
 *  @param view 想要让被点击的控件显示下拉菜单
 */
-(void) showFromView:(UIView *) view{
    /**
     *  获取最上层窗口
     */
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self];
    
    self.frame = window.bounds;
    
    
    /**
     *  默认情况下, 视图的 frame 是以父控件的左上角为坐标原点
            >> 可以通过转换坐标系原点, 改变 frame 的参照点
     
            把这个 frame 从左边的坐标系转成右边的坐标系
     - (CGRect)convertRect:(CGRect)rect toView:  nil 为空就相当于 window;
     
     >> [view convertRect:view.bounds toView:window];
     >> [view.superview convertRect:view.frame toView:window];
     
     */
#warning convertRect
    CGRect coverRect = [view convertRect:view.bounds toView:window];
    
    self.containerView.centerX = CGRectGetMidX(coverRect);// 在控件中部显示
    self.containerView.y = CGRectGetMaxY(coverRect);
    
    if ([self.eva_delegate respondsToSelector:@selector(dropDownMenuDidShow:)]) {
        //当显示时通知代理
        [self.eva_delegate dropDownMenuDidShow:self];
    }
}

-(void)dismiss{
    
    [self removeFromSuperview];
    
    if ([self.eva_delegate respondsToSelector:@selector(dropDownMenuDidDismiss:)]) {
        
        [self.eva_delegate dropDownMenuDidDismiss:self];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismiss];
}

@end
