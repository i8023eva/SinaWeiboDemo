//
//  User.m
//  新浪微博-beat
//
//  Created by lyh on 15/12/9.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "User.h"

@implementation User

-(void)setMbtype:(int)mbtype {
    _mbtype = mbtype;
    
    self.vip = _mbtype > 2;
}

@end
