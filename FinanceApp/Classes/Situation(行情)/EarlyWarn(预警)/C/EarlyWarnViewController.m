//
//  EarlyWarnViewController.m
//  FinanceApp
//
//  Created by SX on 2018/4/26.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "EarlyWarnViewController.h"
#import "ChartsDetailModel.h"
#import "WarnPriceCell.h"
#import "WarnOperationCell.h"

@interface EarlyWarnViewController ()<UITableViewDelegate, UITableViewDataSource, WarnPriceOperationDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *warnArr;
@end

@implementation EarlyWarnViewController

- (NSMutableArray *)warnArr {
    if (!_warnArr) {
        _warnArr = @[].mutableCopy;
    }
    return _warnArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView  =[UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
//        [_tableView registerClass:[WarnPriceCell class] forCellReuseIdentifier:warinPriceCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"WarnPriceCell" bundle:nil] forCellReuseIdentifier:warinPriceCellIdentifier];
//        [_tableView registerClass:[WarnOperationCell class] forCellReuseIdentifier:warnOperationCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"WarnOperationCell" bundle:nil] forCellReuseIdentifier:warnOperationCellIdentifier];
    }
    return _tableView;
}

- (void)initUI {
    [super initUI];
    [self.view addSubview:self.tableView];
    
    [self addMasnory];
}

- (void)addMasnory {
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(15/2));
        make.left.right.bottom.offset(0);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预警";
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.warnArr.count ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return indexPath.row == 2 ? CalculateHeight(150) : CalculateHeight(50);
    }
    
    return CalculateHeight(44);
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0 && indexPath.row == 2) {
//
//    } else if(indexPath.row == 0){
//        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
//
//        cell.textLabel.text = self.model.trading_market_name;
//    } else {
//
//    }
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
//            WarnPriceCell *warnCell = [[[WarnPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:warinPriceCellIdentifier];]
            WarnPriceCell *warnCell = (WarnPriceCell *)[tableView dequeueReusableCellWithIdentifier:warinPriceCellIdentifier];
            if (!warnCell) {
                warnCell = (WarnPriceCell *)[[[NSBundle mainBundle] loadNibNamed:@"WarnPriceCell" owner:self options:nil] lastObject];
            }
            warnCell.model = self.model;
            warnCell.selectionStyle =UITableViewCellSelectionStyleNone;
            return warnCell;
        } else if(indexPath.row == 2){
//            WarnOperationCell *operationCell = [[WarnOperationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:warnOperationCellIdentifier];
            WarnOperationCell *operationCell = (WarnOperationCell *)[tableView dequeueReusableCellWithIdentifier:warnOperationCellIdentifier];
            if (!operationCell) {
                operationCell = (WarnOperationCell *)[[[NSBundle mainBundle] loadNibNamed:@"WarnOperationCell" owner:self options:nil] lastObject];
            }
            operationCell.selectionStyle =UITableViewCellSelectionStyleNone;
            operationCell.model = self.model;
            operationCell.delegate = self;
            return operationCell;
        }
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    UILabel *lb = [[UILabel alloc] initWithText:self.coinName textColor:k_black_color textFont:k_text_font_args(17) textAlignment:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.contentView addSubview:lb];
    [lb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(20));
        make.centerY.offset(0);
    }];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setModel:(PricesModel *)model {
    if (_model != model) {
        _model = model;
    }
    [self.tableView reloadData];
}

- (void)setCoinName:(NSString *)coinName {
    if (_coinName != coinName) {
        _coinName = coinName;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

@end
