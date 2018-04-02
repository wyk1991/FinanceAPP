//
//  TimeButton.h
//  LD
//
//  Created by 徐洋 on 2016/11/24.
//  Copyright © 2016年 Losdeoro24K. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimeClickDelegate <NSObject>

- (void)timeClickButtonAction;

@end

typedef void(^TimeClick)();

@interface TimeButton : UIView

@property (nonatomic, assign) TimeClick click;

@property (nonatomic, assign) id<TimeClickDelegate> delegate;

- (instancetype)initTimeButtonWithTime:(NSInteger)time;

- (void)start;
- (void)reset;

@end
