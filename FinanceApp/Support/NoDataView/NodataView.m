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

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *tipLb;
@property (nonatomic, strong) UILabel *contentLb;

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
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.hidden = YES;
    self.bottomView.backgroundColor = [UIColor clearColor];
    self.bottomView.layer.borderColor = k_textgray_color.CGColor;
    self.bottomView.layer.borderWidth = 0.5;
    [self addSubview:self.bottomView];
    
    self.tipLb = [[UILabel alloc ] initWithText:@"如何发表文章?" textColor:k_black_color textFont:k_textB_font_args(CalculateHeight(14)) textAlignment:0];
    [self.bottomView addSubview:self.tipLb];
    
    NSString *str = [NSString stringWithFormat:@"1.添加小极QQ:2313333完成认证/n 2.认证完成后登陆极链财经官网投稿/n 3.通过审核的稿件将显示在我的专栏中"];
    
    self.contentLb = [[UILabel alloc] initWithText:str textColor:k_textgray_color textFont:k_text_font_args(14) textAlignment:0];
    [self.bottomView addSubview:self.contentLb];
    
    
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
    [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(CalculateHeight(24));
        make.left.offset(CalculateWidth(14));
        make.right.offset(-CalculateWidth(14));
        make.size.height.mas_equalTo(CalculateHeight(200));
    }];
    [_tipLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(15));
        make.top.offset(CalculateHeight(18));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(150), CalculateHeight(20)));
    }];
    [_contentLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tipLb.mas_bottom).offset(CalculateHeight(17));
        make.left.equalTo(_tipLb);
        make.bottom.offset(CalculateHeight(18));
    }];
}

#pragma mark - 根据传入的值创建相应的UI
/** 根据传入的值创建相应的UI */

- (void)setType:(NoContentType)type {
    self.type = type;
    if (type == NoContentTypeSearch) {
        [self setImage:@"icon_search_empty" topLabelText:[NSString stringWithFormat:@"没有找到 %@ 相关结果", _searchContent] bottomLabelText:@"要不换个关键词试试?"];
        [self.bottomView setHidden:YES];
    } else if(type == NoContentTypeArticle){
        [self setImage:@"icon_empty_article" topLabelText:@"" bottomLabelText:@"还没有发布文章哟"];
        [self.bottomView setHidden:NO];
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
