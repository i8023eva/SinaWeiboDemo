//
//  EVAAccountTool.m
//  新浪微博-beat
//
//  Created by lyh on 15/11/28.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "EVAAccountTool.h"
#import "AccountInfo.h"

#define kFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]
@implementation EVAAccountTool


+ (void)saveAccount:(AccountInfo *)account
{
    // 获得账号存储的时间（accessToken的产生时间）记录第一次返回时的时间, 不能改变, 否则不会过期, 而这个方法每次都会调用
//    account.created_time = [NSDate date];
    
    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:kFilePath];
}

/**
 *
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (AccountInfo *)account
{
    // 加载模型
    AccountInfo *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    
    /* 验证账号是否过期 */
    
    // 过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    // 获得过期时间
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    // 获得当前时间
    NSDate *now = [NSDate date];
    
    // 如果expiresTime <= now，过期
    /**
     NSOrderedAscending = -1L, 升序，右边 > 左边
     NSOrderedSame, 一样
     NSOrderedDescending 降序，右边 < 左边
     */
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) { // 过期
        return nil;
    }
    
    return account;
}

@end
