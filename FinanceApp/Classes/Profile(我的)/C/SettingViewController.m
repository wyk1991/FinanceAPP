//
//  PersonalViewController.m
//  FinaceApp
//
//  Created by SX on 2018/3/2.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import "SettingViewController.h"
#import "UserHeadView.h"
#import "SettingModel.h"
#import "NormalUserCell.h"
#import "DeleteButtonCell.h"
#import "PersonalViewController.h"

#import "SituationSetViewController.h"
#import "BaseSituationListViewController.h"
#import "ProblemFeedbackViewController.h"
#import "OboutUsViewController.h"
#import "MyHistoryViewController.h"

static NSString *backPersonCellIden = @"backPersonCellIden";

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource, UserHeaderDelegate>

@property (nonatomic, strong) UserHeadView *headerView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation SettingViewController

#pragma mark - lazy method
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        
        [_tableView registerClass:[NormalUserCell class] forCellReuseIdentifier:normalPersonCellIden];
        [_tableView registerClass:[DeleteButtonCell class] forCellReuseIdentifier:backPersonCellIden];
        
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
    self.view.backgroundColor = k_back_color;
    
    [self.view addSubview:self.tableView];
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:kUserLoginSuccessNotification object:nil];
}

- (void)addMasnory {
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateWidth(22));
        make.left.right.bottom.offset(0);
    }];
}

- (void)loadData {
    if (self.dataArr.count) {
        [self.dataArr removeAllObjects];
    }
    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    double displaysize = size/ 1000 / 1000;
    
    NSArray *arr = @[
                     @[
                         @{@"icon": @"icon_shoucang", @"title": @"积分", @"isArrow": @"1", @"isSwitch": @"0"}, @{@"icon": @"icon_shoucang", @"title": @"我的专栏", @"isArrow": @"1", @"isSwitch": @"0"}, @{@"icon": @"icon_shoucang", @"title": @"收藏", @"isArrow": @"1", @"isSwitch": @"0"}, @{@"icon": @"icon_lishi", @"title": @"历史", @"isArrow": @"1", @"isSwitch": @"0"}
                         ],
                     @[
                         @{@"icon": @"icon_my_hangqing", @"title": @"行情&预警", @"isArrow": @"1", @"isSwitch": @"0"}, @{@"icon": @"icon_push_manager", @"title": @"推送管理", @"isArrow": @"1", @"isSwitch": @"0"}, @{@"icon": @"icon_search_clean",@"title" : @"清理缓存", @"isArrow": @"1", @"content": [HttpTool cacheSize], @"isSwitch": @"0"}
                         ],
                     @[
                         @{@"icon": @"icon_share_app", @"title": @"推荐「极链财经」给好友", @"isArrow": @"1", @"isSwitch": @"0"}, @{@"icon": @"icon_good", @"title": @"给极链APP好评", @"isArrow": @"1", @"isSwitch": @"0"}, @{@"icon": @"icon_feedback", @"title" : @"意见反馈", @"isArrow": @"1", @"isSwitch": @"0"} ,@{@"icon": @"icon_about", @"title" : @"关于极链财经", @"isArrow": @"1", @"isSwitch": @"0"}
                         ],
                     ];
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:arr];
    if ([[kNSUserDefaults valueForKey:user_isLogin] isEqualToString:@"1"]) {
        [tmp addObject:
         @[@{@"icon": @"", @"title": @"退出", @"isArrow": @"0", @"isSwitch": @"0"}]];
    }

    self.dataArr = [SettingModel mj_objectArrayWithKeyValuesArray:tmp];
    [self.tableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)initUI {
    [super initUI];
    [self.view addSubview:self.tableView];
    [self loadData];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 3) {
        DeleteButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:backPersonCellIden];
        if (!cell) {
            cell = [[DeleteButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:backPersonCellIden];
        }
        
        return cell;
    } else {
    
        NormalUserCell *cell = [tableView dequeueReusableCellWithIdentifier:normalPersonCellIden];
        
        if(!cell) {
            cell = [[NormalUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalPersonCellIden];
        }
       
        cell.model = self.dataArr[indexPath.section][indexPath.row];
        
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UserHeadView *headView = [[UserHeadView alloc] init];
        headView.delegate = self;
        return headView;
    } else {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CalculateHeight(50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CalculateHeight(80);
    }else{
        return CalculateHeight(10);
    }
}


#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                // 点击积分
                
                break;
            case 1:
                // 点击我的专栏
                
                break;
            case 2:
                // 点击收藏
                
                
                break;
            case 3:
                // 点击历史
            {
                MyHistoryViewController *vc = [[MyHistoryViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                                               
            }
                break;
            
            default:
                break;
        }
    } else if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0: {
                // 点击行情
                SituationSetViewController *vc = [[SituationSetViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case 1:
                // 点击推送管理
            {
                BaseSituationListViewController *vc = [[BaseSituationListViewController alloc] init];
                vc.title = @"推送管理";
                vc.setType = 3;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                
                break;
            case 2: {
                // 点击清理缓存垃圾
                [LEEAlert alert].config
                .LeeTitle(@"是否清除缓存")         // 添加一个标题 (默认样式)
                .LeeContent([NSString stringWithFormat:@""])        // 添加一个标题 (默认样式)
                .LeeDestructiveAction(@"确定", ^{        //添加一个默认类型的Action (默认样式 字体颜色为蓝色)
//                    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
                    [HttpTool deleateCache];
                })
                .LeeCancelAction(@"取消", ^{    // 添加一个取消类型的Action (默认样式 alert中为粗体 actionsheet中为最下方独立)
                    
                })
                .LeeShow(); // 最后调用Show开始显示
            }
                break;
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                // 点击推荐分享
                break;
            case 1:
                // 给极链app store好评
                
                break;
            case 2:
                // 意见反馈
            {
                ProblemFeedbackViewController *vc = [[ProblemFeedbackViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                
                break;
            case 3:
                // 关于极链
            {
                OboutUsViewController *vc = [[OboutUsViewController alloc] init];
                vc.title = @"关于我们";
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 3) {
        // 点击登录退出
        [LEEAlert alert].config
        .LeeTitle(@"确定退出吗?")
        .LeeContent([NSString stringWithFormat:@""])
        .LeeCancelAction(@"取消", ^{
            
        })
        .LeeAction(@"确定", ^{
            [kUserInfoHelper logout:^(id obj, NSError *error) {
                if (!error) {
                    [MJYUtils saveToUserDefaultWithKey:user_isLogin withValue:@"0"];
                    [SVProgressHUD dismiss];
                    [self loadData];
                }
            }];
        })
        .LeeShow();
    }
    
}

- (void)userHeader:(UserHeadView *)headerView didClickWithUserInfo:(NSDictionary *)userInfo {
    PersonalViewController *vc = [[PersonalViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loginSuccess:(NSNotification *)noti {
    [MJYUtils saveToUserDefaultWithKey:user_isLogin withValue:@"1"];
    
    [self loadData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
