//
//  StatusFrame.m
//  新浪微博-beat
//
//  Created by lyh on 15/12/12.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "StatusFrame.h"

@implementation StatusFrame


-(void)setStatus:(Status *)status {
    
    _status = status;
    
    User *user = status.user;
    
    CGFloat iconX = 10;
    CGFloat iconW = 50;
    self.iconViewF = CGRectMake(iconX, iconX, iconW, iconW);
    
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + 10;
    CGSize nameSize = [user.name sizeOfLineWithFont:kStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX, iconX}, nameSize};
    
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + 10;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipViewF = CGRectMake(vipX, iconX, vipW, vipH);
    }
    
    CGFloat timeX = nameX;
    CGSize timeSize = [_status.created_at sizeOfLineWithFont:kStatusCellTimeFont];
    CGFloat timeY = CGRectGetMaxY(self.iconViewF) - timeSize.height;
    self.timeLabelF = (CGRect){{timeX, timeY}, timeSize};
    
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + 10;
    CGSize sourceSize = [status.source sizeOfLineWithFont:kStatusCellSourceFont];
    CGFloat sourceY = CGRectGetMaxY(self.iconViewF) - sourceSize.height;
    self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
    
    CGFloat contentX = iconX;
    CGFloat contentY = CGRectGetMaxY(self.iconViewF) + 10;
    CGFloat maxW = kWidth - 2 * contentX;
    CGSize contentSize = [status.text sizeOfLinesWithFont:kStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = kWidth;
    CGFloat originalH = CGRectGetMaxY(self.contentLabelF) + 10;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    
    
    self.cellHeight = CGRectGetMaxY(self.originalViewF);
}
@end
