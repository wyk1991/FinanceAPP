//
//  SituationViewController.m
//  FinaceApp
//
//  Created by SX on 2018/3/2.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import "SituationViewController.h"

#import "IconDetailViewController.h"
#import "optionalViewController.h"
#import "IconStorageViewController.h"

@interface SituationViewController ()<ZXCategorySliderBarDelegate, ZXPageCollectionViewDelegate, ZXPageCollectionViewDataSource>

// 标题数组
@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, strong) ZXPageCollectionView *pageVC;
@property (nonatomic, strong) ZXCategorySliderBar *sliderBar;

@end

@implementation SituationViewController

- (ZXCategorySliderBar *)sliderBar
{
    if (!_sliderBar) {
        _sliderBar = [[ZXCategorySliderBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, CalculateHeight(50))];
        
        _sliderBar.delegate = self;
    }
    return _sliderBar;
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"行情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.itemArray = @[@"自选", @"币库", @"AVC", @"BCD", @"EDF", @"EWW", @"WDS", @"FSDF", @"FSSD"];
    self.sliderBar.originIndex = 0;
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
//    if (index == 0) {
//        optionalViewController *vc = [[optionalViewController alloc] initWithFrame:CGRectMake(0, 0, ZXPageCollectionView.frame.size.width, ZXPageCollectionView.frame.size.height)];
//
//        return vc;
//    }  else {
        NSString *reuseIdentifier = [NSString stringWithFormat:@"childView%ld", (long)index];
        IconDetailViewController *childView1 = (IconDetailViewController *)[ZXPageCollectionView dequeueReuseViewWithReuseIdentifier:reuseIdentifier forIndex:index];
        if (!childView1) {
            childView1 = [[IconDetailViewController alloc] initWithFrame:CGRectMake(0, 0, ZXPageCollectionView.frame.size.width, ZXPageCollectionView.frame.size.height)];
            childView1.reuseIdentifier = reuseIdentifier;
//            childView1.index = index;
        }
        return childView1;
//        return nil;
//    }
}

- (void)ZXPageViewDidEndChangeIndex:(ZXPageCollectionView *)pageView currentView:(UIView *)view{
    NSLog(@"=====%s=====", __func__);
    //滚动结束后加载页面
    //    childVIew *cv = (childVIew *)view;
    //    if (cv.dataArray.count == 0) {
    //        [cv fetchData];
    //    }
    [self.sliderBar setSelectIndex:pageView.currentIndex];
}

- (void)didSelectedIndex:(NSInteger)index{
    [self.pageVC moveToIndex:index animation:NO];
}

- (void)ZXPageViewWillBeginDragging:(ZXPageCollectionView *)pageView
{
    self.sliderBar.isMoniteScroll = YES;
    self.sliderBar.scrollViewLastContentOffset = pageView.mainScrollView.contentOffset.x;
}



//- (void)initUI {
//    self.navTabBar.hasArrow = false;
//    self.navTabBar.leftFeatherImageView = nil;
//    self.navTabBar.rightFeatherImageView = nil;
//    NSMutableArray *viewControllers = @[].mutableCopy;
//    NSMutableArray *moreControllers = @[].mutableCopy;
//
//
//    NSArray *titleArr =
//
//    //    NSMutableArray *tmpArr = @[].mutableCopy;
//    for (int i = 0; i < titleArr.count - 1; i++) {
//
//
//
//
//
//        //        [self addChildViewController:vc];
//        if (i == 0) {
//            optionalViewController *vc1 = [[optionalViewController alloc] init];
//            [viewControllers insertObject:vc1 atIndex:0];
//            vc1.title = titleArr[0];
//        } else if (i == 1) {
//            IconStorageViewController *vc2 = [[IconStorageViewController alloc] init];
//            [viewControllers insertObject:vc2 atIndex:1];
//            vc2.title = titleArr[1];
//        } else {
//            NewsListViewController *vc = [[NewsListViewController alloc] init];
//            vc.view.backgroundColor = k_loginmain_color;
//            vc.title = titleArr[i];
//            [viewControllers addObject:vc];
//        }
//
//    }
//
//
//    self.viewControls = viewControllers;
//    self.moreViewControllers = moreControllers;
//    self.disabledCount = 1;
//
//    [self changeViewController:nil to:self.viewControls];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
