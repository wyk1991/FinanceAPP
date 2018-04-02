//
//  SituationCell.m
//  FinanceApp
//
//  Created by SX on 2018/3/14.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "SituationCell.h"

@interface SituationCell()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *titleArr;

@property (nonatomic, assign) CGFloat labelWidth;

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *numLb;
@end

@implementation SituationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithArr:(NSMutableArray *)arr type:(LeftCellType )type{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _leftType = type;
        self.backgroundColor = k_white_color;
        self.titleArr = arr;
        [self initUI];
    }
    return self;
}

- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[].mutableCopy;
    }
    return _titleArr;
}

- (UIImageView *)augurImg {
    if (!_augurImg) {
        _augurImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_xiaoxi"]];
        
    }
    return _augurImg;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
    }
    return _iconImg;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] initWithText:@"111" textColor:k_black_color textFont:k_text_font_args(14) textAlignment:0];
    }
    return _nameLb;
}

- (UILabel *)categoryLb {
    if (!_categoryLb) {
        _categoryLb = [[UILabel alloc] initWithText:@"22" textColor:k_black_color textFont:k_text_font_args(14) textAlignment:0];
    }
    return _categoryLb;
}

- (UILabel *)numLb {
    if (!_numLb) {
        _numLb = [[UILabel alloc] initWithText:@"1" textColor:k_text_color textFont:k_text_font_args(14) textAlignment:0];
    }
    return _numLb;
}

- (UIScrollView *)rightScrollView {
    if (!_rightScrollView) {
        _rightScrollView = [[UIScrollView alloc] init];
        _rightScrollView.backgroundColor = k_back_color;
        _rightScrollView.showsVerticalScrollIndicator = false;
        _rightScrollView.showsHorizontalScrollIndicator = false;
        
        _rightScrollView.delegate = self;
        
    }
    return _rightScrollView;
}

- (void)initUI {
    switch (self.leftType) {
        case 0: {
            [self.contentView addSubview:self.augurImg];
            [self.contentView addSubview:self.nameLb];
            [self.contentView addSubview:self.categoryLb];
        }
            break;
        case 1: {
            [self.contentView addSubview:self.numLb];
            [self.contentView addSubview:self.iconImg];
            [self.contentView addSubview:self.nameLb];
        }
            break;
        case 2: {
            [self.contentView addSubview:self.augurImg];
            [self.contentView addSubview:self.categoryLb];
        }
            break;
        default:
            break;
    }
    
    CGFloat labelW = (kScreenWidth / 2 - CalculateWidth(50));
    [self.titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *lb = [[UILabel alloc] initWithText:@"111" textColor:[UIColor redColor] textFont:k_text_font_args(CalculateHeight(14)) textAlignment:0];
        lb.frame = CGRectMake(labelW*idx, 0, labelW, CalculateHeight(40));
        [self.rightScrollView addSubview:lb];
    }];
    
    self.rightScrollView.frame = CGRectMake(labelW, 0, (kScreenWidth - labelW)*(self.titleArr.count/2), CalculateHeight(40));
    self.rightScrollView.contentSize = CGSizeMake((kScreenWidth - labelW)*(self.titleArr.count/2), 0);
    
    [self.contentView addSubview:self.rightScrollView];
    
    // 对scrollView添加手势
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.rightScrollView addGestureRecognizer:tapGes];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollMove:) name:tapCellScrollNotification object:nil];
    
    [self loadData];
}

- (void)loadData {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    switch (self.leftType) {
        case 0: {
            [_augurImg mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(k_leftMargin);
                make.centerY.offset(0);
                make.size.mas_equalTo(CGSizeMake(CalculateWidth(15), CalculateHeight(18)));
            }];
            [_nameLb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(CalculateHeight(5));
                make.left.equalTo(_augurImg.mas_right).offset(CalculateWidth(5));
                make.size.mas_equalTo(CGSizeMake(CalculateWidth(80), CalculateHeight(15)));
            }];
            [_categoryLb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_nameLb.mas_bottom).offset(CalculateHeight(5));
                make.left.equalTo(_nameLb);
                make.size.mas_equalTo(CGSizeMake(CalculateWidth(80), CalculateHeight(10)));
            }];
        }
            break;
        case 1: {
            [_numLb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(CalculateWidth(k_leftMargin));
                make.centerY.offset(0);
                make.size.mas_equalTo(CGSizeMake(CalculateWidth(20), CalculateHeight(20)));
            }];
            [_iconImg mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_numLb.mas_right).offset(CalculateWidth(30));
                make.centerY.offset(0);
                make.size.mas_equalTo(CGSizeMake(CalculateWidth(15), CalculateHeight(15)));
            }];
            [_nameLb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_iconImg.mas_right).offset(CalculateWidth(5));
                make.centerY.offset(0);
                make.size.mas_equalTo(CGSizeMake(CalculateWidth(60), CalculateHeight(15)));
            }];
        }
            break;
        case 2: {
            [_augurImg mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(k_leftMargin);
                make.centerY.offset(0);
                make.size.mas_equalTo(CGSizeMake(CalculateWidth(15), CalculateHeight(18)));
            }];
            [_categoryLb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_augurImg.mas_right).offset(CalculateWidth(5));
                make.centerY.offset(0);
                make.size.mas_equalTo(CGSizeMake(CalculateWidth(90), CalculateHeight(10)));
            }];
        }
            
        default:
            break;
    }
    
    
    
}

#pragma mark - UIScrollerDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isNotification = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!_isNotification) {
        [[NSNotificationCenter defaultCenter] postNotificationName:tapCellScrollNotification object:self userInfo:@{@"cellOffX":@(scrollView.contentOffset.x)}];
    }
    _isNotification = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 避开自己发的通知，只有手指拨动才会是自己的滚动
    if (!_isNotification) {
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:tapCellScrollNotification object:self userInfo:@{@"cellOffX":@(scrollView.contentOffset.x)}];
    }
    _isNotification = NO;
}

-(void)scrollMove:(NSNotification*)notification
{
    NSDictionary *noticeInfo = notification.userInfo;
    NSObject *obj = notification.object;
    float x = [noticeInfo[@"cellOffX"] floatValue];
    if (obj!=self) {
        _isNotification = YES;
        [_rightScrollView setContentOffset:CGPointMake(x, 0) animated:NO];
    }else{
        _isNotification = NO;
    }
    obj = nil;
}

#pragma mark - 点击事件
- (void)tapAction:(UITapGestureRecognizer *)gesture
{
    __weak typeof (self) weakSelf = self;
    if (self.tapCellClick) {
        NSIndexPath *indexPath = [weakSelf.tableView indexPathForCell:weakSelf];
        weakSelf.tapCellClick(indexPath);
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
