//
//  Status.h
//  新浪微博-beat
//
//  Created by lyh on 15/12/9.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"


@interface Status : NSObject
/**	string	字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;

/**	string	微博信息内容*/
@property (nonatomic, copy) NSString *text;

/**	object	微博作者的用户信息字段 详细*/
@property (nonatomic, strong) User *user;

/**	string	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/**	string	微博来源*/
@property (nonatomic, copy) NSString *source;

@end
