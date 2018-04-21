//
//  ProblemFeedbackViewController.m
//  SSS_MALL

#import "ProblemFeedbackViewController.h"
#import "ProblemFeedbackView.h"
#import "FeedBackCell.h"
#import "SituationSettingManager.h"

static NSString *feedBackIdentifier = @"feedBackIdentifier";
#define k_feedBackTitles @[@"反馈类型", @"反馈内容", @"联系方式"]

@interface ProblemFeedbackViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) UIButton *commitBtn;

@end

@implementation ProblemFeedbackViewController

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = @[].mutableCopy;
    }
    return _dataList;
}

- (UIButton *)commitBtn {
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitBtn.frame = CGRectMake(CalculateWidth(20), CalculateHeight(6), kScreenWidth - CalculateHeight(40), CalculateHeight(44));
        _commitBtn.layer.cornerRadius = 5.0f;
        _commitBtn.layer.masksToBounds = YES;
        [_commitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_commitBtn setBackgroundColor:[UIColor orangeColor]];
        [_commitBtn setTitleColor:k_white_color forState:UIControlStateNormal];
        
        [_commitBtn addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBtn;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView  =[UIView new];
        _tableView.tableHeaderView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[FeedBackCell class] forCellReuseIdentifier:feedBackIdentifier];
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


#pragma mark Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //监听当键将要退出时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

//当键盘出现
- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int height = keyboardRect.size.height;
    for (UITableViewCell *cell in self.tableView.subviews) {
        if ([cell isKindOfClass:[FeedBackCell class]]) {
            FeedBackCell *backcell = (FeedBackCell *)cell;
            if ([backcell.tv isFirstResponder]) {
                return;
            }
        }
    }
    self.tableView.contentOffset = CGPointMake(0, height - CalculateHeight(44));
}

//当键退出
- (void)keyboardWillHide:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    self.tableView.contentOffset = CGPointMake(0, 0);
}

#pragma mark Action
- (void)commitProblemButtonAction:(UIButton *)sender {
    [self.view endEditing:YES];
}
#pragma mark Data

#pragma mark UI
- (void)initUI {
    [super initUI];
    self.title = @"意见反馈";
    [self.view addSubview:self.tableView];
    
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self loadData];
}

- (void)loadData {
    self.dataList = [SituationSettingManager getFeedBackModel];
    
    [self.tableView reloadData];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
        
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        }
        
        cell.textLabel.text = k_feedBackTitles[indexPath.section];
        cell.textLabel.textAlignment = 0;
        cell.textLabel.font = k_text_font_args(CalculateHeight(15));
        return cell;
    }
    FeedBackCell *cell = [tableView dequeueReusableCellWithIdentifier:feedBackIdentifier];
    if (!cell) {
        cell = [[FeedBackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:feedBackIdentifier];
    }
    cell.model = self.dataList[indexPath.section];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return CalculateHeight(44);
    } else if (indexPath.row == 1 && indexPath.section == 1) {
        return CalculateHeight(250);
    } else if (indexPath.row == 1 && indexPath.section == 0) {
        return CalculateHeight(50);
    }
    return CalculateHeight(44);
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CalculateHeight(15/2);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CalculateHeight(15/2))];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CalculateHeight(50))];
        backView.backgroundColor = [UIColor clearColor];
        
        [backView addSubview:self.commitBtn];
        
        return backView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return CalculateHeight(50);
    }
    return CalculateHeight(0);
}

#pragma mark - commitBtnClick
- (void)commitBtnClick:(UIButton *)sender {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
