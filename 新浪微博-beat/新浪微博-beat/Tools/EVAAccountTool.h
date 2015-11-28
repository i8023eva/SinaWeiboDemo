//
//  EVAAccountTool.h
//  新浪微博-beat
//
//  Created by lyh on 15/11/28.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AccountInfo;
@interface EVAAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(AccountInfo *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (AccountInfo *)account;
@end
