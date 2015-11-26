//
//  UIBarButtonItem+CustomView.h
//  新浪微博-beat
//
//  Created by lyh on 15/10/18.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CustomView)

+(UIBarButtonItem *) barButtonItemWithTarget: (id)target Action: (SEL)action image: (NSString *)image highlightedImage: (NSString *)highlightedImage;
@end
