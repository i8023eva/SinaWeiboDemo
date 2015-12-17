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
    
    CGFloat originalH = 0;
    if (status.pic_urls.count) { // 有配图
        CGFloat photoWH = 100;
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + 10;
        self.photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
        
        originalH = CGRectGetMaxY(self.photoViewF) + 10;
    } else { // 没配图
        originalH = CGRectGetMaxY(self.contentLabelF) + 10;
    }
    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = kWidth;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    
    if (status.retweeted_status) {
        
        Status *retweeted_status = status.retweeted_status;
        User *retweeted_status_user = retweeted_status.user;
        
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status_user.name, retweeted_status.text];
        CGSize retweetContentSize = [retweetContent sizeOfLinesWithFont:kStatusCellRetweetContentFont maxW:maxW];
        self.retweetContentLabelF = (CGRect){{10 , 10}, retweetContentSize};
        
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) { // 转发微博有配图
            CGFloat retweetPhotoWH = 100;
            CGFloat retweetPhotoX = 10;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + 10;
            self.retweetPhotoViewF = CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotoWH, retweetPhotoWH);
            
            retweetH = CGRectGetMaxY(self.retweetPhotoViewF) + 10;
        } else { // 转发微博没有配图
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + 10;
        }
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = kWidth;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        self.cellHeight = CGRectGetMaxY(self.retweetViewF);
    } else {
        self.cellHeight = CGRectGetMaxY(self.originalViewF);
    }
}
@end
