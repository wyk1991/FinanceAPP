//
//  ShareFlashInfoViewController.m
//  FinanceApp
//
//  Created by SX on 2018/5/26.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "ShareFlashInfoViewController.h"
#import "FlashModel.h"
#import "ClipTopCell.h"
#import "ClipBottomCell.h"
#import "ShareBottomView.h"

static NSString *topCellIdentifier = @"topCellIdentifier";
static NSString *bottomCellIdentifier = @"bottomCellIdentifier";

@interface ShareFlashInfoViewController ()<UITableViewDelegate, UITableViewDataSource, ShareBtnClickDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ShareBottomView  *bottomView;
@property (nonatomic, assign) CGFloat contentHeight;
@end

@implementation ShareFlashInfoViewController

- (void)setModel:(FlashModel *)model {
    if (_model != model) {
        _model = model;
    }
    [self.tableView reloadData];
}

- (ShareBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[ShareBottomView alloc] init];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = 0;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = YES;
        
        [_tableView registerClass:[ClipTopCell class] forCellReuseIdentifier:topCellIdentifier];
        [_tableView registerClass:[ClipBottomCell class] forCellReuseIdentifier:bottomCellIdentifier];
        
        
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [self addMasonry];
}

- (void)addMasonry {
    [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.right.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, CalculateHeight(50)));
    }];
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.bottom.offset(CalculateHeight(50));
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CalculateHeight(220);
    }
    return  CalculateHeight(400);
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ClipTopCell *cell = [tableView dequeueReusableCellWithIdentifier:topCellIdentifier];
        
        if(!cell) {
            cell = [[ClipTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topCellIdentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else {
        ClipBottomCell *cell  = [tableView dequeueReusableCellWithIdentifier:bottomCellIdentifier];
        if (!cell) {
            cell = [[ClipBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bottomCellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        return cell;
    }
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - ShareBtnClickDelegate
- (void)clickTheBottomView:(ShareBottomView *)view withTag:(NSInteger)tag {
    switch (tag) {
        case 0:{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            
            break;
        case 1:{
            
        }
            break;
        case 2: {
            
        }
            break;
        case 3: {
            
        }
            break;
        case 4: {
            [self clipTheScreenImageToPhoto];
            [self dismissViewControllerAnimated:YES completion:nil];
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        }
            break;
        default:
            break;
    }
}
- (void)clipTheScreenImageToPhoto {
    // 设置截屏大小
    
    CGPoint saveContentOffset = self.tableView.contentOffset;
    CGRect saveFrame = self.tableView.frame;
    
    self.tableView.frame = CGRectMake(0, self.tableView.frame.origin.y,self.tableView.contentSize.width, self.tableView.contentSize.height);
    UIGraphicsBeginImageContextWithOptions(self.tableView.contentSize, YES, 0);
    [self.tableView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
//    UIGraphicsBeginImageContextWithOptions(self.tableView.contentSize, YES, 0);
//    [[self.tableView layer] renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsGetCurrentContext();
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    self.tableView.contentOffset = saveContentOffset;
    self.tableView.frame = saveFrame;
    
    ALAssetsLibrary * library = [ALAssetsLibrary new];
    
    NSData * data = UIImageJPEGRepresentation(viewImage, 1.0);
    
    [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:nil];
    
}
@end
