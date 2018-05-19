//
//  ShareClipViewController.m
//  FinanceApp
//
//  Created by SX on 2018/5/16.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "ShareClipViewController.h"
#import "ShareBottomView.h"
#import "EarthBackView.h"
#import "ClipBackView.h"

@interface ShareClipViewController ()<ShareBtnClickDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) ShareBottomView  *bottomView;
@property (nonatomic, strong) EarthBackView *earthView;
@property (nonatomic, strong) ClipBackView *clipView;

@property (nonatomic, assign) CGFloat clipHeight;
@property (nonatomic, strong) UIImage *clipImg;
@end

@implementation ShareClipViewController

- (EarthBackView *)earthView {
    if (!_earthView) {
        _earthView = [[EarthBackView alloc] init];
        _earthView.backgroundColor = [UIColor clearColor];
    }
    return _earthView;
}

- (ClipBackView *)clipView {
    if (!_clipView) {
        _clipView = [[ClipBackView alloc] init];
        _clipView.backgroundColor = RGB(31, 45, 79);
        _clipView.clipImg = self.clipImg;
    }
    return _clipView;
}

- (ShareBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[ShareBottomView alloc] init];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CalculateHeight(200)+_clipHeight)];
        _scrollView.scrollEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = true;
        _scrollView.showsHorizontalScrollIndicator = false;
        
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(42, 60, 89);
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.bottomView];
    [self.scrollView addSubview:self.earthView];
    [self.scrollView addSubview:self.clipView];
    
    [self addMasnory];
    
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, CalculateHeight(200)+_clipHeight);
}

- (instancetype)initWithClipImage:(UIImage *)image Height:(CGFloat)height {
    if (self = [super init]) {
        _clipHeight = height;
        self.clipImg = image;
    }
    return self;
}

- (void)addMasnory {
    [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.right.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, CalculateHeight(50)));
    }];
    [_earthView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, CalculateHeight(250)));
    }];
    [_clipView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(10));
        make.right.offset(-CalculateWidth(10));
        make.top.equalTo(_earthView.mas_bottom).offset(-CalculateHeight(70));
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
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
    CGSize size = CGSizeMake(kScreenWidth, CalculateHeight(200)+self.clipHeight);
    // 设置截屏大小
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [[self.scrollView layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsGetCurrentContext();
    
    ALAssetsLibrary * library = [ALAssetsLibrary new];
    
    NSData * data = UIImageJPEGRepresentation(viewImage, 1.0);
    
    [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
