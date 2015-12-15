//
//  EVAStatusCell.h
//  新浪微博-beat
//
//  Created by lyh on 15/12/12.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusFrame.h"

@interface EVAStatusCell : UITableViewCell

@property (nonatomic, strong) StatusFrame *statusFrame;

+(instancetype) cellWithTableView: (UITableView *)tableView;

@end
