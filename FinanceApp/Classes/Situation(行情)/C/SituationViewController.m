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
    [vc fetchData];
}


- (void)ZXPageViewDidEndChangeIndex:(ZXPageCollectionView *)pageView currentView:(UIView *)view{
    [self.sliderBar setSelectIndex:pageView.currentIndex];
}

- (void)didSelectedIndex:(NSInteger)index{
    [self.pageVC moveToIndex:index animation:NO];
}

- (void)shareBtnClick {
    
}
- (void)addClick {
    AddCoinViewController *vc = [[AddCoinViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.itemArr = self.addArr;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)ZXPageViewWillBeginDragging:(ZXPageCollectionView *)pageView
{
    NSLog(@"%@", pageView.subviews);
    self.sliderBar.isMoniteScroll = NO;
    self.sliderBar.scrollViewLastContentOffset = pageView.mainScrollView.contentOffset.x;
}

#pragma mark - warnCellAction
- (void)didClickWarnImgWith:(IconDetailViewController *)subView withInfo:(PricesModel *)model coinName:(NSString *)coinName {
    EarlyWarnViewController *vc = [[EarlyWarnViewController alloc] init];
    vc.coinName = coinName;
    vc.model = model;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
