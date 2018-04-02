//
//  LDToast.h
//  LD
//
//  Created by 徐洋 on 2016/11/10.
//  Copyright © 2016年 Losdeoro24K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDToast : UIView

+ (void)showToastWith:(NSString *)msg;
+ (void)dismiss;

@end
