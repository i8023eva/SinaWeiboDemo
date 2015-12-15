//
//  NSString+UIFont.m
//  新浪微博-beat
//
//  Created by lyh on 15/12/15.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "NSString+UIFont.h"

@implementation NSString (UIFont)

- (CGSize) sizeOfLinesWithFont:(UIFont *)font maxW:(CGFloat)maxW;
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize) sizeOfLineWithFont:(UIFont *)font;
{
    return [self sizeOfLinesWithFont:font maxW:MAXFLOAT];
}
@end
