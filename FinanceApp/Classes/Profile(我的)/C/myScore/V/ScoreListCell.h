//
//  ScoreListCell.h
//  FinanceApp
//
//  Created by SX on 2018/5/14.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseCell.h"

@class ScoreListModel;
static NSString *scoreListIdentifier = @"scoreListIdentifier";
@interface ScoreListCell : BaseCell

@property (nonatomic, strong) ScoreListModel *model;
@end
