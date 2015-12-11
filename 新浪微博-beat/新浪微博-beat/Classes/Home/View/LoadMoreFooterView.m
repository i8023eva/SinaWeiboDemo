//
//  LoadMoreFooterView.m
//  新浪微博-beat
//
//  Created by lyh on 15/12/11.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "LoadMoreFooterView.h"

@implementation LoadMoreFooterView

+(instancetype) loadMoreFooterView {
    return [[NSBundle mainBundle] loadNibNamed:@"LoadMoreFooterView" owner:nil options:nil].firstObject;
}

@end
