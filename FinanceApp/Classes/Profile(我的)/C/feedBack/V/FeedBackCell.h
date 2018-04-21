//
//  FeedBackCell.h
//  FinanceApp
//
//  Created by SX on 2018/4/17.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseCell.h"

@class FeedBackCell;
@protocol  ProblemTypeClickDelegate <NSObject>

- (void)probleTypeClickWithTag:(NSString *)tag cell:(FeedBackCell *)cell;

@end

@class FeedBackModel;
@interface FeedBackCell : BaseCell

@property (nonatomic, strong) FeedBackModel *model;
@property (nonatomic, strong) UITextView *tv;
@property (nonatomic, strong) UITextField *tf;

/**
 1-功能问题 2-体验异常 3-内容问题  4-其他
 */
@property (nonatomic, copy) NSString *problemType;

@property (nonatomic, weak) id<ProblemTypeClickDelegate> delegate;
@end
