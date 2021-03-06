//
//  SituationColorViewController.m
//  FinanceApp
//
//  Created by wangyangke on 2018/4/15.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseSituationListViewController.h"
#import "SettingModel.h"
#import "NormalUserCell.h"
#import "PreviewCell.h"
#import "SituationSettingManager.h"
#import "TelBindingViewController.h"
#import "NewPasswordViewController.h"

@interface BaseSituationListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) NSIndexPath *currencySelected;
@property (nonatomic, strong) NSIndexPath *redColorSelected;

@end

@implementation BaseSituationListViewController
- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = @[].mutableCopy;
    }
    return _dataList;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.showsHorizontalScrollIndicator = false;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[NormalUserCell class] forCellReuseIdentifier:normalPersonCellIden];
        [_tableView registerClass:[PreviewCell class] forCellReuseIdentifier:previewCellID];
    }
    return _tableView;
}

- (void)initUI {
    [super initUI];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self loadDataWithType:self.setType];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isSwithOnChange) name:notificationswitchONNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.setType == 0) {
        [MJYUtils saveToUserDefaultWithKey:user_greenRed withValue:self.redColorSelected.row == 0 ? @"redReduce" : @"redRise"];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserChangePriceColorNotification object:nil];
    } else if (self.setType == 1) {
        [MJYUtils saveToUserDefaultWithKey:user_currency withValue:self.currencySelected.row == 0 ? @"cny" : @"usd"];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserChangeCurrencyNotification object:nil];
    }
}

- (void)addMasnory {
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}

- (void)isSwithOnChange {
    
    [kNSUserDefaults setValue:[[UIApplication sharedApplication] currentUserNotificationSettings].types != UIRemoteNotificationTypeNone ? @"1" : @"0" forKey:user_pushSwitch];
    [kNSUserDefaults synchronize];
    [self changeTheData:self.setType];
}

- (void)loadDataWithType:(SettingType)type {
    
    _currencySelected = [[kNSUserDefaults valueForKey:user_currency] isEqualToString:@"cny"] ? [NSIndexPath indexPathForRow:0 inSection:0] : [NSIndexPath indexPathForRow:1 inSection:0];
    _redColorSelected = [[kNSUserDefaults valueForKey:user_greenRed] isEqualToString:@"redRise"] ? [NSIndexPath indexPathForRow:1 inSection:0]  : [NSIndexPath indexPathForRow:0 inSection:0];
    if (iOs8 && type==settingPushType) {
        
        [self.dataList addObject:[SituationSettingManager getSettingModelWithType:type]];
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types != UIRemoteNotificationTypeNone) {
            [self.dataList addObject:[SettingModel mj_objectArrayWithKeyValuesArray: @[@{@"title": @"文章消息通知", @"isArrow":@"0",@"isSwitch": @"1",  @"isSelect": [[kNSUserDefaults valueForKey:user_article] isEqualToString:@"1"] ? @"1" : @"0"}]]];
        }else {
            if (self.dataList.count == 2) {
                
                [self.dataList removeLastObject];
            }
            
        }
    } else {
        
        self.dataList = [SituationSettingManager getSettingModelWithType:type];
    }
    
    [self.tableView reloadData];
}

- (void)changeTheData:(NSInteger) type {
    
    SettingModel *model = self.dataList[0][0];
    if (iOs8) {
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types != UIRemoteNotificationTypeNone) {
            if (self.dataList.count >= 2) {
                return;
            }
            [self.dataList addObject:[SettingModel mj_objectArrayWithKeyValuesArray: @[@{@"title": @"文章消息通知", @"isArrow":@"0",@"isSwitch": @"1",  @"isSelect": [[kNSUserDefaults valueForKey:user_article] isEqualToString:@"1"] ? @"1" : @"0"}]]];
            
            model.isSelect = @"1";
        }else {
            if (self.dataList.count == 2) {
                [self.dataList removeLastObject];
                model.isSelect = @"0";
            }
        }
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.setType == 0 ? @"行情颜色" : (self.setType == 1 ? @"显示价格" : self.setType == 3 ? @"推送管理": (self.setType == 4?@"账号安全" : @"预警提醒"));
    self.view.backgroundColor = k_back_color;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.setType == 1 || self.setType == 4 ? 2 : (self.setType == 3 ? ([[kNSUserDefaults valueForKey:user_pushSwitch] isEqualToString:@"1"] ? 2 : 1) : 1) ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.setType == 1 && section == 1 ? 1 : (self.setType == 4 ? [self.dataList[section] count] : (self.setType == 3 ? [self.dataList[section] count] :[self.dataList count]));
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && self.setType == settingPriceType) {
        // 预览界面
        PreviewCell *cell = [tableView dequeueReusableCellWithIdentifier:previewCellID];
        
        if (!cell) {
            cell = [[PreviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:previewCellID];
        }
        cell.type = self.currencySelected;
        
        return cell;
    }
    
    NormalUserCell *cell = [tableView dequeueReusableCellWithIdentifier:normalPersonCellIden];
    
    if(!cell) {
        cell = [[NormalUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalPersonCellIden];
    }
    if (self.setType == 0 || self.setType == 1) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.tintColor = k_red_color;
    }
    
    cell.model = self.setType == 4 ? self.dataList[indexPath.section][indexPath.row] : (self.setType == 3 ? self.dataList[indexPath.section][indexPath.row] : self.dataList[indexPath.row]);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 10;
    }
    return CalculateHeight(0);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.setType == 0) {
         NormalUserCell *cell = [tableView cellForRowAtIndexPath:_redColorSelected];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        _redColorSelected = indexPath;
        NormalUserCell *cell1  = [tableView cellForRowAtIndexPath:indexPath];
        cell1.accessoryType = UITableViewCellAccessoryCheckmark;
    } else if (self.setType == 1) {
        NormalUserCell *cell = [tableView cellForRowAtIndexPath:_currencySelected];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        _currencySelected = indexPath;
        NormalUserCell *cell1  = [tableView cellForRowAtIndexPath:indexPath];
        cell1.accessoryType = UITableViewCellAccessoryCheckmark;
        
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    if (self.setType == 4) {
        if (indexPath.row == 0 && indexPath.section == 0) {
            // 点击跳转手机号
            TelBindingViewController *vc = [[TelBindingViewController alloc] init];
            vc.title = @"绑定手机号";
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.section == 1 && indexPath.row == 0) {
            if (![[kNSUserDefaults valueForKey:user_telephoneBinding] length]) {
                [SVProgressHUD showWithStatus:@"请先绑定手机号"];
                return;
            }
            
        }
        if (indexPath.row == 0 && indexPath.section == 1) {
            NewPasswordViewController *vc = [[NewPasswordViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.setType == 3 && section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - CalculateWidth(30), CalculateHeight(150))];
        view.backgroundColor = [UIColor clearColor];
        
        UILabel *lb = [[UILabel alloc] initWithText:@"请在iPhone的\"设置\"-\"通知\"-\"极链财经\"中进行设置是否接受新消息通知" textColor:k_textgray_color textFont:k_text_font_args(CalculateHeight(14)) textAlignment:0];
        lb.numberOfLines = 0;
        [view addSubview:lb];
        [lb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(CalculateHeight(30));
            make.left.offset(CalculateWidth(15));
            make.right.offset(-CalculateWidth(15));
        }];
        
        UILabel *lb1 = [[UILabel alloc] initWithText:@"开启通知后可进一步设置接受不同分类的消息" textColor:k_textgray_color textFont:k_text_font_args(CalculateHeight(14)) textAlignment:0];
        lb1.numberOfLines = 0;
        if ([[kNSUserDefaults valueForKey:user_pushSwitch] isEqualToString:@"0"]) {
            [view addSubview:lb1];
            [lb1 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lb.mas_bottom).offset(CalculateHeight(15));
                make.left.offset(CalculateWidth(15));
                make.right.offset(-CalculateWidth(15));
            }];
        }
        
        return view;
    }
    
    return [[UIView alloc] initWithFrame:CGRectZero];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.setType == 3 && [[kNSUserDefaults valueForKey:user_pushSwitch] isEqualToString:@"0"]) {
        return CalculateHeight(150);
    } else if([[kNSUserDefaults valueForKey:user_pushSwitch] isEqualToString:@"1"] && self.setType == 3){
        return CalculateHeight(70);
    }
    return 0;
}

- (void)setSetType:(SettingType)setType {
    if (_setType != setType) {
        _setType = setType;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && self.setType == settingPriceType) {
        return CalculateHeight(160);
    }
    return CalculateHeight(50);
}

//代理方法 设置分割线的间距
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, CalculateWidth(10), 0, CalculateWidth(10))];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, CalculateWidth(10), 0, CalculateWidth(10))];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
