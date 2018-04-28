//
//  PersonalViewController.m
//  FinaceApp
//
//  Created by SX on 2018/3/5.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import "PersonalViewController.h"
#import "SettingModel.h"
#import "NormalUserCell.h"
#import "QuickLoginViewController.h"
#import "ChangeNickViewController.h"

#import "BaseSituationListViewController.h"

@interface PersonalViewController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation PersonalViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionHeaderHeight = 0;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
        
    }
    return _tableView;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.view.backgroundColor = k_back_color;
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)loadData {
    if (self.dataArr.count) {
        [self.dataArr removeAllObjects];
    }
    NSArray *array = @[
                       @[@{@"title": @"昵称", @"content": @"", @"isArrow": @"1", @"isSwitch": @"0"}, @{@"title": @"性别", @"content": @"男", @"isArrow": @"1", @"isSwitch": @"0"}],
                       
                       @[@{@"title": @"账号与安全", @"isArrow": @"1", @"isSwitch": @"0"}]
                       ];
    self.dataArr = [SettingModel mj_objectArrayWithKeyValuesArray:array];
    [self.tableView reloadData];
}

- (void)initUI {
    [super initUI];
    [self.view addSubview:self.tableView];
}

- (void)addMasnory {
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NormalUserCell *cell = [tableView dequeueReusableCellWithIdentifier:normalPersonCellIden];
    
    if(!cell) {
        cell = [[NormalUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalPersonCellIden];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _dataArr[indexPath.section][indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CalculateHeight(90))];
        v.backgroundColor = k_white_color;
        
        UIImageView *avatorImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_defaut_avatar"]];
        avatorImg.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAvator)];
        [avatorImg addGestureRecognizer:tap];
        
        [v addSubview:avatorImg];
        
        [avatorImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(v);
            make.centerY.equalTo(v);
            make.size.mas_equalTo(CGSizeMake(CalculateWidth(60), CalculateHeight(60)));
        }];
        
        return v;
    } else {
        return [UIView new];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CalculateHeight(60);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CalculateHeight(100);
    } else {
        return CalculateHeight(10);
    }
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ChangeNickViewController *vc = [[ChangeNickViewController alloc] init];
            vc.title = @"修改昵称";
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 1) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *man = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 请求网络数据
                
            }];
            UIAlertAction *woman = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 请求网络数据
            }];
            [alert addAction:cancelAction];
            [alert addAction:man];
            [alert addAction:woman];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    if (indexPath.section == 1 && indexPath.row == 0 ) {
        BaseSituationListViewController *vc = [[BaseSituationListViewController alloc] init];
        vc.title = @"账号与安全";
        vc.setType = 4;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)clickAvator {
    NSLog(@"点击了头像");
    
    QuickLoginViewController *quickVc = [[QuickLoginViewController alloc] init];
    [self.navigationController pushViewController:quickVc animated:YES];
}

@end
