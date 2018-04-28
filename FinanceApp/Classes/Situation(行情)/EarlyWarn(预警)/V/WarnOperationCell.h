//
//  WarnOperationCell.h
//  FinanceApp
//
//  Created by SX on 2018/4/26.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *warnOperationCellIdentifier = @"warnOperationCellIdentifier";
@protocol  WarnPriceOperationDelegate <NSObject>

- (void)addWarnPriceWith:(NSString *)priceType currencyType:(NSString *)curType didClickWithContent:(NSString *)contentTf;

@end

@class PricesModel;
@interface WarnOperationCell : UITableViewCell

@property (nonatomic, strong) PricesModel *model;
@property (nonatomic, assign) id<WarnPriceOperationDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *maxBtn;
@property (weak, nonatomic) IBOutlet UIButton *minBtn;
@property (weak, nonatomic) IBOutlet UITextField *maxPriceTf;
@property (weak, nonatomic) IBOutlet UITextField *minPriceTf;
@property (weak, nonatomic) IBOutlet UIButton *cnyBtn;
@property (weak, nonatomic) IBOutlet UIButton *usdBtn;

@end
