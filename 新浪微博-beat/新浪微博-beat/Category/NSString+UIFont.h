//
//  NSString+UIFont.h
//  新浪微博-beat
//
//  Created by lyh on 15/12/15.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UIFont)

/** 多行 */
- (CGSize) sizeOfLinesWithFont:(UIFont *)font maxW:(CGFloat)maxW;
/** 单行 */
- (CGSize) sizeOfLineWithFont:(UIFont *)font;

@end
