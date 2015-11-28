//
//  AccountInfo.h
//  新浪微博-beat
//
//  Created by lyh on 15/11/28.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountInfo : NSObject<NSCoding>
/**字典>模型
 *  {
 "access_token" = "2.00Q3WT1E02WLlQ4ec27ca2d00bz254";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 3967093948;
 }
 */

/**　string	用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy) NSString *access_token;

/**　string	access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSNumber *expires_in;

/**　string	当前授权用户的UID。*/
@property (nonatomic, copy) NSString *uid;

/**	access token的创建时间 */
@property (nonatomic, strong) NSDate *created_time;


/** 根据返回的账户字典转模型 */
+ (instancetype)accountWithDict:(NSDictionary *)dict;


@end
