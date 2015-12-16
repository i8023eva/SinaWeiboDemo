//
//  Status.m
//  新浪微博-beat
//
//  Created by lyh on 15/12/9.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "Status.h"
#import "MJExtension.h"

@implementation Status

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"pic_urls" : [Photos class]};
}

@end
