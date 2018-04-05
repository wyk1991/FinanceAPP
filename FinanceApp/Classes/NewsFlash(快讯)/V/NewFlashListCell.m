//
//  NewFlashListCell.m
//  FinanceApp
//
//  Created by wangyangke on 2018/3/31.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "NewFlashListCell.h"
#import "CardDetailView.h"
#import "GRStarsView.h"
#import "FlashViewModel.h"
#import "FlashModel.h"

#define bottomW  (kScreenWidth - CalculateWidth(24)*2) * 2/3
@interface NewFlashListCell()
@property (nonatomic, strong) UIImageView *circleImg;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) GRStarsView *starsView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *contentLb;

@property (nonatomic, strong) CardDetailView *detailView;

@property (nonatomic, strong) UIButton *publishBtn;
@property (nonatomic, strong) UILabel *surplusLb;
@property (nonatomic, strong) UIButton *shareBtn;

@end

@implementation NewFlashListCell

- (UIImageView *)circleImg {
    if (!_circleImg) {
        _circleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_circle"]];
        _circleImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _circleImg;
}

- (UILabel *)timeLb {
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] initWithText:@"" textColor:k_content_time textFont:k_text_font_args(CalculateHeight(12)) textAlignment:0];
    }
    return _timeLb;
}

- (GRStarsView *)starsView {
    if (!_starsView) {
        _starsView = [[GRStarsView alloc] initWithStarSize:CGSizeMake(12, 12) margin:CalculateWidth(3) numberOfStars:5];
        _starsView.allowSelect = NO;
        _starsView.score = [self.viewModel.model.hottness floatValue];
    }
    return _starsView;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = k_line;
    }
    return _line;
}

- (UILabel *)contentLb {
    if (!_contentLb) {
        _contentLb = [[UILabel alloc] initWithText:@"" textColor:k_content_text textFont:k_text_font_args(CalculateHeight(CalculateHeight(17))) textAlignment:0];
        _contentLb.numberOfLines = 0;
    }
    return _contentLb;
}

- (CardDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[CardDetailView alloc] init];
    }
    return _detailView;
}
- (UIButton *)publishBtn {
    if (!_publishBtn) {
        _publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publishBtn setImage:[UIImage imageNamed:@"ic_time"] forState:UIControlStateNormal];
        [_publishBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [_publishBtn setTitle:@"" forState:UIControlStateNormal];
        _publishBtn.userInteractionEnabled = NO;
        _publishBtn.titleLabel.font = k_text_font_args(CalculateHeight(12));
        [_publishBtn setTitleColor:k_currenty_text forState:UIControlStateNormal];
    }
    return _publishBtn;
}

- (UILabel *)surplusLb {
    if (!_surplusLb) {
        _surplusLb = [[UILabel alloc] initWithText:@"" textColor:k_currenty_text textFont:k_text_font_args(CalculateHeight(12)) textAlignment:0];
    }
    return _surplusLb;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"ic_share"] forState:UIControlStateNormal];
        [_shareBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [_shareBtn setTitle:@"" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:k_currenty_text forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = k_text_font_args(CalculateHeight(12));
        
        [_shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.circleImg];
    [self.contentView addSubview:self.timeLb];
    [self.contentView addSubview:self.starsView];
    [self.contentView addSubview:self.contentLb];
    [self.contentView addSubview:self.detailView];
    [self.contentView addSubview:self.publishBtn];
    [self.contentView addSubview:self.surplusLb];
    [self.contentView addSubview:self.shareBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(15));
        make.top.offset(CalculateHeight(0));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(0.5), _viewModel.cellHeight));
    }];
    [_circleImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_line);
        make.top.offset(CalculateHeight(24));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(10), CalculateHeight(10)));
    }];
    [_timeLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_line.mas_right).offset(CalculateWidth(15));
        make.top.equalTo(_circleImg);
    }];
    [_starsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_circleImg);
        make.left.equalTo(_timeLb.mas_right).offset(CalculateWidth(10));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(12), CalculateHeight(12)));
    }];
    [_contentLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLb);
        make.right.offset(-CalculateWidth(24));
        make.top.equalTo(_timeLb.mas_bottom).offset(CalculateHeight(20));
    }];
    [_detailView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLb.mas_bottom).offset(CalculateHeight(20));
        make.left.equalTo(_contentLb);
        make.right.equalTo(_contentLb);
        make.size.height.mas_equalTo(@0);
    }];
    [_shareBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CalculateWidth(24));
        make.bottom.offset(-CalculateHeight(15));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(80), CalculateHeight(12)));
    }];
    [_surplusLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_shareBtn.mas_left).offset(CalculateWidth(15));
        make.top.equalTo(_shareBtn);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(100), CalculateHeight(12)));
    }];
    [_publishBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_surplusLb.mas_left).offset(-CalculateWidth(15));
        make.top.equalTo(_shareBtn);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(120), CalculateHeight(12)));
    }];
    
}

- (void)setViewModel:(FlashViewModel *)viewModel {
    
    if (_viewModel != viewModel) {
        _viewModel = viewModel;
    }
    
    self.starsView.score = [viewModel.model.hottness floatValue];
    self.timeLb.text = [viewModel.model.publishedAt substringWithRange:NSMakeRange(11, 5)];
    self.contentLb.text = viewModel.model.desc;
    if (viewModel.model.ico_card) {
        [self.detailView setHidden:NO];
        self.detailView.cardModel = viewModel.model.ico_card;
    } else {
        [self.detailView setHidden:YES];
    }
    [self.publishBtn setTitle:viewModel.model.publishedAt forState:UIControlStateNormal];
    self.surplusLb.text = [NSString stringWithFormat:@"剩余数目  %@", viewModel.model.remain_coin];
    [self.shareBtn setTitle:@"12222" forState:UIControlStateNormal];
    
    [self layoutIfNeeded];
}


- (void)shareBtnClick:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(shareBtnClick:)]) {
        [_delegate shareBtnClick:self];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
