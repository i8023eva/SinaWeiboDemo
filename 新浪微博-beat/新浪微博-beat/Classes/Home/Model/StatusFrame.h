//
//  StatusFrame.h
//  新浪微博-beat
//
//  Created by lyh on 15/12/12.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Status;
@interface StatusFrame : NSObject

@property (nonatomic, strong) Status *status;

/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
