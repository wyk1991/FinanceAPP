//
//  UIView+Badge.h
//  UTask
//
//  Created by 徐洋 on 2016/12/22.
//  Copyright © 2016年 GXPTW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Badge)

@property (nonatomic, assign) CGFloat badgeSize;
@property (nonatomic, assign) CGFloat offsetX;
@property (nonatomic, assign) CGFloat offsetY;

- (void)showBadge;
- (void)showBadgeWith:(NSUInteger)count;
- (void)removeBadge;

@end
