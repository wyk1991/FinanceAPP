//
//  BasePageViewController.m
//  FinaceApp
//
//  Created by SX on 2018/3/4.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import "BasePageViewController.h"

@interface BasePageViewController ()<UIScrollViewDelegate>
{
    //用中间变量 来 接受点击后的控件
    UIView * _temp_view;
    UIButton * _temp_bt;
    
}


@end

@implementation BasePageViewController


- (instancetype)init {
    if ([super init]) {
        
    }
    return self;
}

#pragma mark - lazy Method
- (NSMutableArray *)button_arr {
    if (!_button_arr) {
        _button_arr = @[].mutableCopy;
    }
    return _button_arr;
}


- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(kScreenWidth - CalculateWidth(80), 0, CalculateWidth(80), CalculateHeight(50));
        [_addBtn setImage:[UIImage imageNamed:@"icon_tianjia"] forState:UIControlStateNormal];
        [_addBtn setImage:[UIImage imageNamed:@"icon_tianjia_you"] forState:UIControlStateHighlighted];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"bg_gradient"] forState:UIControlStateNormal];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"bg_gradient"] forState:UIControlStateHighlighted];
        [_addBtn setImageEdgeInsets:UIEdgeInsetsMake(CalculateWidth(17), CalculateWidth(50), CalculateWidth(17), CalculateWidth(15))];
        [_addBtn addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}


- (UIScrollView *)categoryScroll {
    if (!_categoryScroll) {
        
        float sum_x = 12;
        _categoryScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - CalculateWidth(10), CalculateHeight(50))];
        _categoryScroll.backgroundColor = k_white_color;
        
        NSArray *titleArr = @[@"头条", @"资本市场", @"百科", @"专访", @"学院", @"分析师说", @"深度", @"技术", @"数字货币", @"以太坊", @"9:30", @"试听", @"讲堂", @"政策", @"商业", @"试听", @"     "];
        
        for (int i =0; i< titleArr.count; i++) {
            CGSize size = [titleArr[i] sizeWithFont:k_text_font_args(17) maxW:kScreenWidth];
            
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(sum_x, 0, size.width, CalculateHeight(50))];
            v.backgroundColor = k_white_color;
            v.userInteractionEnabled = YES;
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, v.frame.size.width, CalculateHeight(50))];
            btn.titleLabel.font = k_text_font_args(17);
            [btn setTitleColor:k_black_color forState:UIControlStateNormal];
            [btn setTitleColor:k_black_color forState:UIControlStateSelected];
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(changeControlView:) forControlEvents:UIControlEventTouchDown];
            btn.tag = 100+i;
            
            [self.button_arr addObject:btn];
            if (i == 0) {
                
                [btn setTitleColor:k_red_color forState:UIControlStateNormal];
                _temp_view = v;
                _temp_bt = btn;
            }
            [v addSubview:btn];
            
            sum_x = sum_x + size.width + 18;
            
            [_categoryScroll addSubview:v];
        }
        _categoryScroll.contentSize = CGSizeMake(sum_x, CalculateHeight(50));
        _categoryScroll.contentOffset = CGPointMake(0, 0);
        _categoryScroll.showsHorizontalScrollIndicator = false;
        
    }
    return _categoryScroll;
}

- (UIScrollView *)controllerScroll {
    if (!_controllerScroll) {
        _controllerScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CalculateHeight(50), kScreenWidth, kScreenHeight - CalculateHeight(50))];
        
        _controllerScroll.delegate = self;
        
        
        
        _controllerScroll.pagingEnabled = YES;
        _controllerScroll.contentOffset = CGPointZero;
        _controllerScroll.showsHorizontalScrollIndicator = NO;
    }
    return _controllerScroll;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.categoryScroll];
    [self.view addSubview:self.controllerScroll];
    [self.view addSubview:self.addBtn];
    
}


- (void)changeControlView:(UIButton *)btn {
    if (_temp_bt == btn) {
        return;
    }
    
    [btn setTitleColor:k_red_color forState:UIControlStateNormal];
    [_temp_bt setTitleColor:k_black_color forState:UIControlStateNormal];
    _temp_bt = btn;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.controllerScroll.contentOffset = CGPointMake(kScreenWidth * (btn.tag - 100), 0);
        
        if (btn.tag > 102) {
            self.categoryScroll.contentOffset = CGPointMake(CalculateWidth(45)*(btn.tag - 100), 0);
        } else {
            self.categoryScroll.contentOffset = CGPointZero;
        }
    }];
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / kScreenWidth;
    
    UIButton *btn  = (UIButton *)self.button_arr[page];
    
    if (_temp_bt == btn) {
        return;
    }
    
    [btn setTitleColor:k_red_color forState:UIControlStateNormal];
    [_temp_bt setTitleColor:k_black_color forState:UIControlStateNormal];
    _temp_bt = btn;
    
    [UIView animateWithDuration:1 animations:^{
        
        if (page > 2) {
            self.categoryScroll.contentOffset = CGPointMake(CalculateWidth(45) * page, 0);
        }else{
            self.categoryScroll.contentOffset = CGPointMake(0, 0);
        }
    } completion:^(BOOL finished) {
        
    }];
}

- (void)clickAdd {
    NSArray *titleArr = @[@"头条", @"资本市场", @"百科", @"专访", @"学院", @"分析师说", @"深度", @"技术", @"数字货币", @"以太坊", @"9:30", @"试听", @"讲堂", @"政策", @"商业", @"试听", @"     "];
    NSArray *titleArr1 = @[@"头条", @"资本市场", @"百科", @"专访", @"     "];
//    [[XLChannelControl shareControl] showChannelViewWithInUseTitles:titleArr unUseTitles:titleArr1 finish:^(NSArray *inUseTitles, NSArray *unUseTitles) {
//        
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
