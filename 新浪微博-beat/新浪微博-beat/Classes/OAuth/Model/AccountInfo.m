//
//  AccountInfo.m
//  新浪微博-beat
//
//  Created by lyh on 15/11/28.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "AccountInfo.h"

@implementation AccountInfo

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    AccountInfo *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    return account;
}


-(void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.created_time forKey:@"created_time"];
}

-(instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        [decoder decodeObjectForKey:@"access_token"];
        [decoder decodeObjectForKey:@"expires_in"];
        [decoder decodeObjectForKey:@"uid"];
        [decoder decodeObjectForKey:@"created_time"];
    }
    return self;
}

@end
