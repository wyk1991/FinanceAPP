//
//  NodataView.m
//  SXErp
//
//  Created by 关宇琼 on 2017/11/15.
//  Copyright © 2017年 SXJT. All rights reserved.
//

#import "NodataView.h"

@interface NodataView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *topLabel;
@property (nonatomic,strong) UILabel *bottomLabel;

@end

@implementation NodataView

#pragma mark - 构造方法

- (instancetype) init {
    if (self = [super init]) {
        // UI搭建
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI搭建
/** UI搭建 */
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    
    //------- 图片 -------//
    self.imageView = [[UIImageView alloc]init];
    [self addSubview:self.imageView];
    
    //------- 内容描述 -------//
    self.topLabel = [[UILabel alloc]init];
    [self addSubview:self.topLabel];
    self.topLabel.textAlignment = NSTextAlignmentCenter;
    self.topLabel.font = [UIFont systemFontOfSize:15];
    self.topLabel.textColor = k_black_color;
    
    //------- 提示点击重新加载 -------//
    self.bottomLabel = [[UILabel alloc]init];
    [self addSubview:self.bottomLabel];
    self.bottomLabel.textAlignment = NSTextAlignmentCenter;
    self.bottomLabel.font = [UIFont systemFontOfSize:15];
    self.bottomLabel.textColor = k_main_color;
    
    //------- 建立约束 -------//
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_offset(-CalculateHeight(80));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(280), CalculateHeight(180)));
    }];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(10);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(20);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLabel.mas_bottom).mas_offset(5);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(20);
    }];
    
}

#pragma mark - 根据传入的值创建相应的UI
/** 根据传入的值创建相应的UI */

- (void)setOp:(NoContentType)type {
    self.type = type;
    if (type == NoContentTypeSearch) {
        [self setImage:@"icon_search_empty" topLabelText:[NSString stringWithFormat:@"没有找到 %@ 相关结果", _searchContent] bottomLabelText:@"要不换个关键词试试?"];
    } else {
        [self setImage:[NSString stringWithFormat:@"introduction_of_%@", type] topLabelText:@"" bottomLabelText:@""];
    }
}

#pragma mark - 设置图片和文字
/** 设置图片和文字 */
- (void)setImage:(NSString *)imageName topLabelText:(NSString *)topLabelText bottomLabelText:(NSString *)bottomLabelText{
    self.imageView.image = [UIImage imageNamed:imageName];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.topLabel.text = topLabelText;
    self.bottomLabel.text = bottomLabelText;
}

@end
