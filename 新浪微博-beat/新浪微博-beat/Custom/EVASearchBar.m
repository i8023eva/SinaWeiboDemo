//
//  EVASearchBar.m
//  新浪微博-beat
//
//  Created by lyh on 15/10/18.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "EVASearchBar.h"

@implementation EVASearchBar

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.font = [UIFont systemFontOfSize:14];
        self.placeholder = @"搜索";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        /**
         UIImageView *imageV = [[UIImageView alloc]init];//这种肯定不会有尺寸的
         imageV.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
         */
        //而这种方式创建的 ImageView 默认尺寸是图片的大小
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        
        imageView.size = CGSizeMake(30 , 30);
        imageView.contentMode = UIViewContentModeCenter;// >>> 这个填充模式666
        self.leftView = imageView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+(instancetype) searchBar{
    
    return [[self alloc] init];
}
@end
