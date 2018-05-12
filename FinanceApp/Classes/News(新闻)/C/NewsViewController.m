//
//  NewsViewController.m
//  FinaceApp
//
//  Created by SX on 2018/3/2.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import "NewsViewController.h"
#import "HeadNewsViewController.h"
#import "NewsListViewController.h"
#import "SearchViewController.h"
#import "HomeHelper.h"

#import "DDChannelCell.h"
#import "DDChannelLabel.h"
#import "DDSortView.h"

static NSString * const reuseID  = @"DDChannelCell";

@interface NewsViewController ()<UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

/** 是否使用缓存
 */
@property (nonatomic, assign) BOOL *saveChange;

@property (nonatomic, strong) UIView *navBackView;

@property (nonatomic, strong) HomeHelper *homeHelper;
/** 频道数据模型 */
@property (nonatomic, strong) NSMutableArray *channelList;
/** 当前显示的频道 */
@property (nonatomic, strong) NSMutableArray *list_now;
/** 更多频道 */
@property (nonatomic, strong) NSMutableArray *moreList;

/** 频道列表 */
@property (nonatomic, strong) UIScrollView *smallScrollView;
/** 新闻视图 */
@property (nonatomic, strong) UICollectionView *bigCollectionView;

/** 分类排序界面 */
@property (nonatomic, strong) DDSortView *sortView;

@property (nonatomic, strong) UIImageView *imageView;

/** 旋转状态 */
@property (nonatomic, assign) BOOL flag;

@end
@implementation NewsViewController

#pragma mark - lazy
- (NSMutableArray *)channelList {
    if (!_channelList) {
        _channelList = @[].mutableCopy;
    }
    return _channelList;
}

- (UIScrollView *)smallScrollView
{
    if (_smallScrollView == nil) {
        _smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CalculateWidth(220), CalculateHeight(44))];
        _smallScrollView.backgroundColor = [UIColor clearColor];
        _smallScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _smallScrollView;
}

- (UIView *)navBackView {
    if (!_navBackView) {
        _navBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - CalculateWidth(80), CalculateHeight(44))];
        _navBackView.backgroundColor = [UIColor clearColor];
    }
    return _navBackView;
}

- (UICollectionView *)bigCollectionView
{
    if (_bigCollectionView == nil) {
        // 高度 = 屏幕高度 - 导航栏高度64 - 频道视图高度44
        CGFloat h = kScreenHeight;
        CGRect frame = CGRectMake(0, 0, kScreenWidth, h);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _bigCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _bigCollectionView.backgroundColor = [UIColor whiteColor];
        _bigCollectionView.delegate = self;
        _bigCollectionView.dataSource = self;
        [_bigCollectionView registerClass:[DDChannelCell class] forCellWithReuseIdentifier:reuseID];
        
        // 设置cell的大小和细节
        flowLayout.itemSize = _bigCollectionView.bounds.size;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        _bigCollectionView.pagingEnabled = YES;
        _bigCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _bigCollectionView;
}

- (DDSortView *)sortView {
    if (!_sortView) {
        _sortView = [[DDSortView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    return _sortView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self loadTagData];
        self.flag = YES;
    }
    return self;
}

- (void)initUI {
    [super initUI];
    [self.navigationController.navigationBar setBarTintColor:k_home_barColor];
    //设置右边按钮
    [self buildBarButtonItem];
    // 设置smallScrollview 为titleView
    [self.navBackView addSubview:self.smallScrollView];
    self.navigationItem.titleView = self.navBackView;
    
    [self.view addSubview:self.bigCollectionView];
    
  
}

- (void)buildBarButtonItem {
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add_icon"]];
    self.imageView.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    self.imageView.bounds=CGRectMake(CalculateWidth(8), CalculateHeight(8), CalculateWidth(18), CalculateHeight(18));
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CalculateWidth(8), CalculateHeight(8), CalculateWidth(18), CalculateHeight(18));
    [button addSubview:self.imageView];
    [button addTarget:self action:@selector(sortButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.imageView.center = button.center;
    //设置RightBarButtonItem
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barItem;
}

- (HomeHelper *)homeHelper {
    if (!_homeHelper) {
        _homeHelper = [[HomeHelper alloc] init];
    }
    return _homeHelper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置navigationItem 为自定义的频道滚动图
    
    
}
- (void)loadTagData {
    WS(weakSelf);
    [[HomeHelper shareHelper] helperGetTagDataFromPath:tag_list callBack:^(id obj, NSError *error) {
        if (!error) {
            self.channelList = self.homeHelper.tagList;
            // 设置频道
            _list_now = self.channelList.mutableCopy;
            // 设置频道数据
            [weakSelf setupChannelLabel];
            self.sortView.selectedArray = self.homeHelper.tagList;
            self.sortView.optionalArray = @[].mutableCopy;

            [self.bigCollectionView reloadData];
        }
    }];
}

/** 设置频道标题 */
- (void)setupChannelLabel
{
    CGFloat margin = CalculateWidth(15);
    CGFloat x = 8;
    CGFloat h = self.smallScrollView.bounds.size.height;
    int i = 0;
    for (NSString *str in self.list_now) {
        DDChannelLabel *label = [DDChannelLabel channelLabelWithTitle:str];
        label.frame = CGRectMake(x, 0, label.width + margin, h);
        label.textColor = k_tagUnselected;
        [self.smallScrollView addSubview:label];

        x += label.bounds.size.width;
        label.tag = i++;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
    }
    self.smallScrollView.contentSize = CGSizeMake(x + margin + CalculateWidth(30), 0);
    
    
    DDChannelLabel *firstLabel = [self getLabelArrayFromSubviews][0];
    firstLabel.textColor = k_tagSelected;
    firstLabel.font = k_text_font_args(CalculateHeight(20));
}

/** 排序按钮点击事件 */
- (void)sortButtonClick:(UIButton *)btn {
    
    if (self.flag) {
        self.sortView.y = -kScreenHeight;
        // 显示编辑菜单栏
        [self.view addSubview:self.sortView];
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45));
            
            self.tabBarController.tabBar.y += 60;
            
            [self.navigationItem.titleView setHidden:YES];
            self.sortView.y = 0;
        } completion:^(BOOL finished) {
            self.flag = NO;
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(0));
            
            [self.navigationItem.titleView setHidden:NO];
            // 隐藏编辑菜单栏
            self.sortView.y = -kScreenHeight;
            self.tabBarController.tabBar.y = kScreenHeight - 49;
        } completion:^(BOOL finished) {
            self.flag = YES;
            [self.sortView removeFromSuperview];
        }];
    }
    if (self.list_now.count != 0) {
        self.list_now = self.sortView.selectedArray;
        
        NSArray *arr = [self getLabelArrayFromSubviews];
        for (DDChannelLabel *label in arr) {
            [label removeFromSuperview];
        }
        // 重新设置
        [self setupChannelLabel];
        
        [self.bigCollectionView reloadData];
    }
    
    
}



/** 点击label事件 */
- (void)labelClick:(UITapGestureRecognizer *)pan {
    DDChannelLabel *label = (DDChannelLabel *)pan.view;
    // 滚动bigCollection
    [_bigCollectionView setContentOffset:CGPointMake(label.tag * _bigCollectionView.frame.size.width, 0) animated:YES];
    // 重新调用一下滚定停止方法，让label的着色和下划线到正确的位置。
    [self scrollViewDidEndScrollingAnimation:self.bigCollectionView];
}

/** 手指滑动BigCollectionView，滑动结束后调用 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat value = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (value < 0) {return;} // 防止在最左侧的时候，再滑，下划线位置会偏移，颜色渐变会混乱。
    
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    if (rightIndex >= [self getLabelArrayFromSubviews].count) {  // 防止滑到最右，再滑，数组越界，从而崩溃
        rightIndex = [self getLabelArrayFromSubviews].count - 1;
    }
    
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft  = 1 - scaleRight;
    
    DDChannelLabel *labelLeft  = [self getLabelArrayFromSubviews][leftIndex];
    DDChannelLabel *labelRight = [self getLabelArrayFromSubviews][rightIndex];
    
    labelLeft.scale  = scaleLeft;
    labelRight.scale = scaleRight;
    
    // 点击label会调用此方法1次，会导致【scrollViewDidEndScrollingAnimation】方法中的动画失效，这时直接return。
    if (scaleLeft == 1 && scaleRight == 0) {
        return;
    }
}

/** 手指滑动BigCollectionView，滑动结束后调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.bigCollectionView]) {
        [self scrollViewDidEndScrollingAnimation:scrollView];
    }
}

/** 手指点击smallScrollView */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.bigCollectionView.width;
    // 滚动标题栏到中间位置
    DDChannelLabel *titleLable = [self getLabelArrayFromSubviews][index];
    CGFloat offsetx   =  titleLable.center.x - _smallScrollView.width * 0.5;
    CGFloat offsetMax = _smallScrollView.contentSize.width - _smallScrollView.width;
    // 在最左和最右时，标签没必要滚动到中间位置。
    if (offsetx < 0)         {offsetx = 0;}
    if (offsetx > offsetMax) {offsetx = offsetMax;}
    [_smallScrollView setContentOffset:CGPointMake(offsetx, 0) animated:YES];
    
    // 先把之前着色的去色：（快速滑动会导致有些文字颜色深浅不一，点击label会导致之前的标题不变回黑色）
    for (DDChannelLabel *label in [self getLabelArrayFromSubviews]) {
        label.textColor = k_tagUnselected;
        label.font = k_text_font_args(CalculateHeight(18));
    }
    // 下划线滚动并着色
    [UIView animateWithDuration:0.5 animations:^{
        titleLable.textColor = k_tagSelected;
        titleLable.font = k_text_font_args(CalculateHeight(20));
    }];
}

/** 获取smallScrollView中所有的DDChannelLabel，合成一个数组，因为smallScrollView.subViews中有其他非Label元素 */
- (NSArray *)getLabelArrayFromSubviews {
    NSMutableArray *arr = @[].mutableCopy;
    for (DDChannelLabel *label in _smallScrollView.subviews) {
        if ([label isKindOfClass:[DDChannelLabel class]]) {
            [arr addObject:label];
        }
    }
    return arr;
}

#pragma mark - UICollcetionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _list_now.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    NSString *indexName = self.list_now[indexPath.item];
//    if (indexPath.item == 0) {
//        // 设置头条新闻
//        cell.pageType = @"toutiao";
//    } else {
        // 其他类别的频道
//        for (NSString *str in self.list_now) {
//            if ([indexName isEqualToString:[MJYUtils transform:str]]) {
                cell.pageType = [MJYUtils transform:indexName];
//            }
//        }
//
//    }

    // 如果不加入响应者链，则无法利用NavController进行Push/Pop等操作。
    [self addChildViewController:(NewsListViewController *)cell.newsTVC];
    return cell;
}

@end
