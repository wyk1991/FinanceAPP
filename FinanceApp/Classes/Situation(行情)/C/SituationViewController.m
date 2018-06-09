//
//  SituationViewController.m
//  FinaceApp
//
//  Created by SX on 2018/3/2.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import "SituationViewController.h"

#import "IconDetailViewController.h"
#import "AddCoinViewController.h"
#import "EarlyWarnViewController.h"
#import "SituationSearchViewController.h"
#import "ShareClipViewController.h"
#import "QuickLoginViewController.h"

#import "SituationHelper.h"
#import "NormalCoinHeadView.h"

@interface SituationViewController ()<ZXCategorySliderBarDelegate, ZXPageCollectionViewDelegate, ZXPageCollectionViewDataSource, WarnCellImgActionDelegate>

// 标题数组
@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, strong) ZXPageCollectionView *pageVC;
@property (nonatomic, strong) ZXCategorySliderBar *sliderBar;

/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) SituationHelper *helper;
@property (nonatomic, strong) NSMutableArray *addArr;
@end

@implementation SituationViewController

- (SituationHelper *)helper {
    if (!_helper) {
        _helper = [[SituationHelper alloc] init];
    }
    return _helper;
}

- (ZXCategorySliderBar *)sliderBar
{
    if (!_sliderBar) {
        _sliderBar = [[ZXCategorySliderBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, CalculateHeight(50))];
        
        _sliderBar.delegate = self;
    }
    return _sliderBar;
}

- (NSMutableArray *)addArr {
    if (!_addArr) {
        [self.helper.tagList removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
        _addArr = self.helper.tagList.copy;
    }
    return _addArr;
}

- (ZXPageCollectionView *)pageVC
{
    if (!_pageVC) {
        _pageVC = [[ZXPageCollectionView alloc]initWithFrame:CGRectMake(0, CalculateHeight(50), self.view.frame.size.width, self.view.frame.size.height)];
        _pageVC.dataSource = self;
        _pageVC.delegate = self;
        _pageVC.mainScrollView.bounces = NO;
    }
    return _pageVC;
}

- (void)loadTagData {
    [self.helper helperGetTagDataWithPath:situation_tag callback:^(id obj, NSError *error) {
       
        
        self.itemArray = [NSMutableArray arrayWithArray:self.helper.tagList];
        
        [self setupTagData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavItem];
    self.view.userInteractionEnabled = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadTagData];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.timer) {
        // 开启定时器
        self.timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(feachData) userInfo:nil repeats:YES];
        // 添加到runloop中，不要使用系统默认的mainRubloop，不然会阻塞主线程
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
//    IconDetailViewController *vc = (IconDetailViewController *)[self ZXPageCollectionView:self.pageVC viewForItemAtIndex:self.pageVC.currentIndex];
//    [vc addNotification];
    
    [self addNotification];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(feachData) name:kUserChangeCurrencyNotification object:nil];
    // 成功登录的回调通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(feachData) name:kUserLoginSuccessNotification object:nil];
    // 退出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(feachData) name:kUserLoginOutSuccessNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.timer invalidate];
}

- (void)setupNavItem {
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CalculateWidth(112), CalculateHeight(27))];
    img.image = [UIImage imageNamed:@"ic_logo"];
    self.navigationItem.titleView = img;
    
    UIBarButtonItem *rightShareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_share_market"] style:UIBarButtonItemStyleDone target:self action:@selector(shareBtnClick)];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_add_you"] style:UIBarButtonItemStyleDone target:self action:@selector(addClick)];
    NSArray *buttonArr = [[NSArray alloc] initWithObjects: addItem, rightShareItem, nil];
    self.navigationItem.rightBarButtonItems = buttonArr;
    
}

- (void)setupTagData {
    
    self.sliderBar.originIndex = 1;
    self.sliderBar.itemArray = self.itemArray;
    
    [self.view addSubview:self.sliderBar];
    [self.view addSubview:self.pageVC];
    
    self.sliderBar.moniterScrollView = self.pageVC.mainScrollView;
}

- (NSInteger)numberOfItemsInZXPageCollectionView:(ZXPageCollectionView *)ZXPageCollectionView{
    return self.itemArray.count;
}

- (void)ZXPageViewDidScroll:(UIScrollView *)scrollView direction:(NSString *)direction{
    
    self.pageVC.mainScrollView.scrollEnabled = self.pageVC.currentIndex == 0 ? NO: YES;
    
    [self.sliderBar adjustIndicateViewX:scrollView direction:direction];
}


// 设置viewController数据源
- (UIView *)ZXPageCollectionView:(ZXPageCollectionView *)ZXPageCollectionView viewForItemAtIndex:(NSInteger)index {
        NSString *reuseIdentifier = [NSString stringWithFormat:@"childView%ld", (long)index];
        IconDetailViewController *childView1 = (IconDetailViewController *)[ZXPageCollectionView dequeueReuseViewWithReuseIdentifier:reuseIdentifier forIndex:index];
        if (!childView1) {
            childView1 = [[IconDetailViewController alloc] initWithFrame:CGRectMake(0, 0, ZXPageCollectionView.frame.size.width, ZXPageCollectionView.frame.size.height) withShowType:index == 0 ? 0 : index == 1 ? 1 : 2 withIndex:index];
            childView1.delegate = self;
            childView1.reuseIdentifier = reuseIdentifier;
        }
        return childView1;
}

- (void)feachData {
    IconDetailViewController *vc = (IconDetailViewController *)[self ZXPageCollectionView:self.pageVC viewForItemAtIndex:self.pageVC.currentIndex];
    vc.selectedIndex = self.pageVC.currentIndex;
    if (vc.selectedIndex == 0) {
        return;
    }
    [vc fetchData];
}


- (void)ZXPageViewDidEndChangeIndex:(ZXPageCollectionView *)pageView currentView:(UIView *)view{
    [self.sliderBar setSelectIndex:pageView.currentIndex];
}

- (void)didSelectedIndex:(NSInteger)index{
    [self.pageVC moveToIndex:index animation:NO];
}


/**
 点击分享按钮
 */
- (void)shareBtnClick {
    UIImage *headImg = nil;
    IconDetailViewController *vc = (IconDetailViewController *)[self ZXPageCollectionView:self.pageVC viewForItemAtIndex:self.pageVC.currentIndex];
    for (UIView *view in vc.subviews) {
        NSLog(@"%@", vc);
        NSLog(@"%@", view.subviews);
        NSLog(@"%f", view.frame.size.height);
        CGRect rect = view.frame;
        if ([view isKindOfClass:[UIScrollView class]]) {
            rect.size = ((UIScrollView *)view).contentSize;
        }
        if ([view isKindOfClass:[UIButton class]]) {
            break;
        }
        UIGraphicsBeginImageContextWithOptions(rect.size, YES, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [view.layer renderInContext:context];
        headImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    
    NSLog(@"left heght: %f, right height: %f", vc.leftTableView.contentSize.height, vc.rightTableView.contentSize.height);
    
    UIImage *optionImg = nil;
    UIImage *leftImg = nil;
    UIImage *rightImg = nil;
    if (vc.optionTableView) {
        
        UIGraphicsBeginImageContextWithOptions(vc.optionTableView.contentSize, YES, [UIScreen mainScreen].scale);
        {
            CGPoint savedContentOffset = vc.optionTableView.contentOffset;
            CGRect saveFrame = vc.optionTableView.frame;
            vc.optionTableView.contentOffset = CGPointZero;
            vc.optionTableView.frame = CGRectMake(0, 0, vc.optionTableView.contentSize.width, vc.optionTableView.contentSize.height);
            [vc.optionTableView.layer renderInContext:UIGraphicsGetCurrentContext()];
            
            optionImg = UIGraphicsGetImageFromCurrentImageContext();
            vc.optionTableView.contentOffset = savedContentOffset;
            vc.optionTableView.frame = saveFrame;
        }
        UIGraphicsEndImageContext();
    }
    if (vc.leftTableView && vc.rightTableView) {
        UIGraphicsBeginImageContextWithOptions(vc.leftTableView.contentSize, YES, [UIScreen mainScreen].scale);
        {
            CGPoint savedContentOffset = vc.leftTableView.contentOffset;
            CGRect saveFrame = vc.leftTableView.frame;
            vc.leftTableView.contentOffset = CGPointZero;
            vc.leftTableView.frame = CGRectMake(0, 0, vc.leftTableView.contentSize.width, vc.leftTableView.contentSize.height);
            [vc.leftTableView.layer renderInContext:UIGraphicsGetCurrentContext()];
            
            leftImg = UIGraphicsGetImageFromCurrentImageContext();
            vc.leftTableView.contentOffset = savedContentOffset;
            vc.leftTableView.frame = saveFrame;
        }
        
        UIGraphicsBeginImageContextWithOptions(vc.rightTableView.contentSize, YES, [UIScreen mainScreen].scale);
        {
            CGPoint savedContentOffset = vc.rightTableView.contentOffset;
            CGRect saveFrame = vc.rightTableView.frame;
            vc.rightTableView.contentOffset = CGPointZero;
            vc.rightTableView.frame = CGRectMake(0, 0, vc.rightTableView.contentSize.width, vc.rightTableView.contentSize.height);
            [vc.rightTableView.layer renderInContext:UIGraphicsGetCurrentContext()];
            
            rightImg = UIGraphicsGetImageFromCurrentImageContext();
            vc.rightTableView.contentOffset = savedContentOffset;
            vc.rightTableView.frame = saveFrame;
        }
        UIGraphicsEndImageContext();
    }
    
    
    UIImage *resultImg = [self composeWithHeader:headImg leftTableView:leftImg rightTableView:rightImg footTable:optionImg];
    
    [self pushShareViewControllerWithImage:resultImg withInfo:resultImg.size];
    
}

- (UIImage *)composeWithHeader:(UIImage *)header leftTableView:(UIImage *)leftImg rightTableView:(UIImage *)rightImg footTable:(UIImage *)footImg {
    UIImage *topImg = nil;
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[ZXCategorySliderBar class]]) {
            CGRect rect = view.frame;
            
            UIGraphicsBeginImageContextWithOptions(rect.size, YES, [UIScreen mainScreen].scale);
            CGContextRef context = UIGraphicsGetCurrentContext();
            [view.layer renderInContext:context];
            topImg = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }
    
    CGSize size = CGSizeMake(kScreenWidth, topImg.size.height+ header.size.height + leftImg.size.height + footImg.size.height);
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [topImg drawInRect:CGRectMake(0, 0, topImg.size.width, topImg.size.height)];
    [header drawInRect:CGRectMake(0, topImg.size.height , header.size.width, header.size.height)];
    if (leftImg && rightImg) {
        [leftImg drawInRect:CGRectMake(0, header.size.height + topImg.size.height , leftImg.size.width, leftImg.size.height)];
        [rightImg drawInRect:CGRectMake(leftImg.size.width, header.size.height + topImg.size.height, rightImg.size.width, rightImg.size.height)];
    } else {
        [footImg drawInRect:CGRectMake(0, header.size.height+ topImg.size.height, footImg.size.width , footImg.size.height)];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



- (void)pushShareViewControllerWithImage:(UIImage *)viewImage withInfo:(CGSize)size {
    ShareClipViewController *vc = [[ShareClipViewController alloc] initWithClipImage:viewImage Height:size.height];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

/**
 点击添加自选的功能
 */
- (void)addClick {
    // 判断是否登录了
    if (![kNSUserDefaults valueForKey:kAppHasCompletedLoginToken]) {
        QuickLoginViewController *vc = [[QuickLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
    } else {
        AddCoinViewController *vc = [[AddCoinViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.itemArr = self.addArr;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)ZXPageViewWillBeginDragging:(ZXPageCollectionView *)pageView
{
    self.sliderBar.isMoniteScroll = NO;
    self.sliderBar.scrollViewLastContentOffset = pageView.mainScrollView.contentOffset.x;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 获取UITouch对象
    UITouch *touch = [touches anyObject];
    // 获取当前点的位置
    CGPoint curP = [touch locationInView:self.view];

    if (self.pageVC.currentIndex >=2) {
        
        BOOL isInner = CGRectContainsPoint(CGRectMake(0, 0, kScreenWidth, CalculateHeight(150)), curP);
        self.pageVC.mainScrollView.scrollEnabled = isInner ? NO : YES;
    }
    
}

#pragma mark - warnCellAction
- (void)didClickWarnImgWith:(IconDetailViewController *)subView withInfo:(PricesModel *)model coinName:(NSString *)coinName {
    EarlyWarnViewController *vc = [[EarlyWarnViewController alloc] init];
    vc.coinName = coinName;
    vc.model = model;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didClickToSeachCoin:(IconDetailViewController *)subView {
    SituationSearchViewController *vc = [[SituationSearchViewController alloc] init];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)didClickAddBtn:(IconDetailViewController *)subView {
    [self addClick];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
