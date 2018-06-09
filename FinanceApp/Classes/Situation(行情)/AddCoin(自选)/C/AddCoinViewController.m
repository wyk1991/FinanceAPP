//
//  AddCoinViewController.m
//  FinanceApp
//
//  Created by SX on 2018/4/18.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "AddCoinViewController.h"
#import "ZXCategorySliderBar.h"
#import "ZXPageCollectionView.h"
#import "UpdateCoinListModel.h"
#import "CoinListView.h"

#import "SituationHelper.h"

@interface AddCoinViewController ()<ZXCategorySliderBarDelegate, ZXPageCollectionViewDelegate, ZXPageCollectionViewDataSource>
@property (nonatomic, strong) ZXPageCollectionView *pageVC;
@property (nonatomic, strong) ZXCategorySliderBar *sliderBar;


@property (nonatomic, strong) NSMutableArray *updateArr;

@property (nonatomic, strong) SituationHelper *helper;
@end

@implementation AddCoinViewController

- (SituationHelper *)helper {
    if (!_helper) {
        _helper = [SituationHelper shareHelper];
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

- (NSMutableArray *)updateArr {
    if (!_updateArr) {
        _updateArr = @[].mutableCopy;
    }
    return _updateArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加自选";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(sureBtnClick:)];
    
    [self.view addSubview:self.sliderBar];
    [self.view addSubview:self.pageVC];
    
    self.sliderBar.originIndex = 0;
    self.sliderBar.itemArray = self.itemArr;
    self.sliderBar.moniterScrollView = self.pageVC.mainScrollView;
}

- (void)setItemArr:(NSMutableArray *)itemArr {
    if (_itemArr != itemArr) {
        _itemArr = itemArr;
    }
    for (int i =0; i<itemArr.count; i++) {
        UpdateCoinListModel *model = [[UpdateCoinListModel alloc] init];
        NSDictionary *dic = @{self.itemArr[i]: model};
        [self.updateArr addObject:dic];
    }
    
}


#pragma mark - ZXCategorySliderBarDelegate
- (void)ZXPageViewWillBeginDragging:(ZXPageCollectionView *)pageView
{
    NSLog(@"%@", pageView.subviews);
    self.sliderBar.isMoniteScroll = NO;
    self.sliderBar.scrollViewLastContentOffset = pageView.mainScrollView.contentOffset.x;
}

- (NSInteger)numberOfItemsInZXPageCollectionView:(ZXPageCollectionView *)ZXPageCollectionView{
    return self.itemArr.count;
}

- (void)ZXPageViewDidScroll:(UIScrollView *)scrollView direction:(NSString *)direction{
    
    [self.sliderBar adjustIndicateViewX:scrollView direction:direction];
}


// 设置viewController数据源
- (UIView *)ZXPageCollectionView:(ZXPageCollectionView *)ZXPageCollectionView viewForItemAtIndex:(NSInteger)index {
    NSString *reuseIdentifier = [NSString stringWithFormat:@"childView%ld", (long)index];
    CoinListView *childView1 = (CoinListView *)[ZXPageCollectionView dequeueReuseViewWithReuseIdentifier:reuseIdentifier forIndex:index];
    if (!childView1) {
        childView1 = [[CoinListView alloc] initWithFrame:CGRectMake(0, 0, ZXPageCollectionView.frame.size.width, ZXPageCollectionView.frame.size.height) withCoinDic:self.updateArr[index]];
        childView1.reuseIdentifier = reuseIdentifier;
    }
    return childView1;
}

- (void)didSelectedIndex:(NSInteger)index{
    [self.pageVC moveToIndex:index animation:NO];
}

- (void)sureBtnClick:(UIButton *)btn {
    [SVProgressHUD showInfoWithStatus:@"正在提交数据"];
    NSMutableDictionary *muDics = @{}.mutableCopy;
    [muDics addEntriesFromDictionary:@{@"session_id": kApplicationDelegate.userHelper.userInfo.token}];
    for (int i =0; i<self.itemArr.count; i++) {
        for (NSDictionary *dic in self.updateArr) {
            UpdateCoinListModel *model = dic[_itemArr[i]];
            if (model != nil) {
                if (model.markets != nil && model.markets.count) {
                    NSMutableArray *muArr = @[].mutableCopy;
                    NSMutableArray *coinArr = @[].mutableCopy;
                    for (NSDictionary *dic in model.markets) {
                        [coinArr addObject:dic[@"name"]];
                    }
                    NSDictionary *dic = @{@"markets": coinArr, @"coin_name": model.coin_name};
//                    [muArr addObject:[NSDictionary dictionaryWithObject:coinArr forKey:@"markets"]];
//                    [muArr addObject:[NSDictionary dictionaryWithObject:model.coin_name forKey:@"coin_name"]];
                    [muArr addObject:dic];
//                    [muArr setValue:coinArr forKey:@"markets"];
//                    [muArr setValue:model.coin_name forKey:@"coin_name"];
                    
                    [muDics addEntriesFromDictionary:@{@"updates": muArr}];
                }
            }
        }
    }
    
    if (!muDics.count) {
        [SVProgressHUD showInfoWithStatus:@"请选择选项"];
        return;
    }
    NSString *str = [JYJSON JSONStringWithDictionaryOrArray:muDics];
    NSLog(@"%@", str);
    
    [self.helper helpAddOptionItemWithPath:situation_AddOptionList params:str callback:^(id obj, NSError *error) {
        if ([obj[@"status"] integerValue] == 100) {
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
            [LDToast showToastWith:@"添加成功"];
        }
    }];

}

- (void)ZXPageViewDidEndChangeIndex:(ZXPageCollectionView *)pageView currentView:(UIView *)view{
    NSLog(@"=====%s=====", __func__);
    [self.sliderBar setSelectIndex:pageView.currentIndex];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
