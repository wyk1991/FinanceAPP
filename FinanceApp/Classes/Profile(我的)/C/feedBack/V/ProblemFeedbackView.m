//
//  ProblemFeedbackView.m
//  SSS_MALL
//  迎面走来的是三只草泥马方队
//  ┏━┛ ┻━━━━━┻ ┗━┓         ┏━┛ ┻━━━━━┻ ┗━┓         ┏━┛ ┻━━━━━┻ ┗━┓
//  ┃ ||||||||||| ┃         ┃ ||||||||||| ┃         ┃ ||||||||||| ┃
//  ┃      ━      ┃         ┃      ━      ┃         ┃      ━      ┃
//  ┃  ┳┛     ┗┳  ┃         ┃  ┳┛     ┗┳  ┃         ┃  ┳┛     ┗┳  ┃
//  ┃             ┃         ┃             ┃         ┃             ┃
//  ┃      ┻      ┃         ┃      ┻      ┃         ┃      ┻      ┃
//  ┃             ┃         ┃             ┃         ┃             ┃
//  ┃             ┃         ┃             ┃         ┃             ┃
//  ┗━━━┓     ┏━━━┛         ┗━━━┓     ┏━━━┛         ┗━━━┓     ┏━━━┛
//      ┃     ┃                 ┃     ┃                 ┃     ┃
//      ┃     ┃                 ┃     ┃                 ┃     ┃
//      ┃     ┃                 ┃     ┃                 ┃     ┃
//      ┃     ┃                 ┃     ┃                 ┃     ┃
//      ┃     ┃                 ┃     ┃                 ┃     ┃
//      ┃     ┃                 ┃     ┃                 ┃     ┃
//      ┃     ┃                 ┃     ┃                 ┃     ┃
//      ┃     ┗━━━━━━━━┓        ┃     ┗━━━━━━━━┓        ┃     ┗━━━━━━━━┓
//      ┃              ┣━┓      ┃              ┣━┓      ┃              ┣━┓
//      ┃              ┃        ┃              ┃        ┃              ┃
//      ┃              ┃        ┃              ┃        ┃              ┃
//      ┗━┓┓┏━━━━━┓┓┏━━┛        ┗━┓┓┏━━━━━┓┓┏━━┛        ┗━┓┓┏━━━━━┓┓┏━━┛
//        ┃┫┫     ┃┫┫             ┃┫┫     ┃┫┫             ┃┫┫     ┃┫┫
//
//                                         ,s555SB@@&
//                                      :9H####@@@@@Xi
//                                     1@@@@@@@@@@@@@@8
//                                   ,8@@@@@@@@@B@@@@@@8
//                                  :B@@@@X3hi8Bs;B@@@@@Ah,
//             ,8i                  r@@@B:     1S ,M@@@@@@#8;
//            1AB35.i:               X@@8 .   SGhr ,A@@@@@@@@S
//            1@h31MX8                18Hhh3i .i3r ,A@@@@@@@@@5
//            ;@&i,58r5                 rGSS:     :B@@@@@@@@@@A
//             1#i  . 9i                 hX.  .: .5@@@@@@@@@@@1
//              sG1,  ,G53s.              9#Xi;hS5 3B@@@@@@@B1
//               .h8h.,A@@@MXSs,           #@H1:    3ssSSX@1
//               s ,@@@@@@@@@@@@Xhi,       r#@@X1s9M8    .GA981
//               ,. rS8H#@@@@@@@@@@#HG51;.  .h31i;9@r    .8@@@@BS;i;
//                .19AXXXAB@@@@@@@@@@@@@@#MHXG893hrX#XGGXM@@@@@@@@@@MS
//                s@@MM@@@hsX#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&,
//              :GB@#3G@@Brs ,1GM@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@B,
//            .hM@@@#@@#MX 51  r;iSGAM@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8
//          :3B@@@@@@@@@@@&9@h :Gs   .;sSXH@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
//      s&HA#@@@@@@@@@@@@@@M89A;.8S.       ,r3@@@@@@@@@@@@@@@@@@@@@@@@@@@r
//   ,13B@@@@@@@@@@@@@@@@@@@5 5B3 ;.         ;@@@@@@@@@@@@@@@@@@@@@@@@@@@i
//  5#@@#&@@@@@@@@@@@@@@@@@@9  .39:          ;@@@@@@@@@@@@@@@@@@@@@@@@@@@;
//  9@@@X:MM@@@@@@@@@@@@@@@#;    ;31.         H@@@@@@@@@@@@@@@@@@@@@@@@@@:
//   SH#@B9.rM@@@@@@@@@@@@@B       :.         3@@@@@@@@@@@@@@@@@@@@@@@@@@5
//     ,:.   9@@@@@@@@@@@#HB5                 .M@@@@@@@@@@@@@@@@@@@@@@@@@B
//           ,ssirhSM@&1;i19911i,.             s@@@@@@@@@@@@@@@@@@@@@@@@@@S
//              ,,,rHAri1h1rh&@#353Sh:          8@@@@@@@@@@@@@@@@@@@@@@@@@#:
//            .A3hH@#5S553&@@#h   i:i9S          #@@@@@@@@@@@@@@@@@@@@@@@@@A.
//
//    又看源码，看你妹妹呀！
//
//  Created by 徐洋 on 2017/8/3.
//  Copyright © 2017年 Losdeoro24K. All rights reserved.
//
//  洋爸爸 威武

#import "ProblemFeedbackView.h"

@interface ProblemFeedbackView ()

@property (nonatomic, strong) UIView *back_view;

@property (nonatomic, strong) UILabel *title_label;

@property (nonatomic, strong) NSMutableArray <UIButton *>*buttons;

@end

@implementation ProblemFeedbackView

#pragma mark Action
- (void)problemFeedbackTypeButtonAction:(UIButton *)sender {
    [self endEditing:YES];
    if (sender.selected) return;
    [_buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.selected) {
            obj.selected = NO;
        }
    }];
    sender.selected = YES;
    _problemType = [NSString stringWithFormat:@"%ld", (long)sender.tag];
    NSLog(@"%@", sender.titleLabel.text);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

#pragma mark Lazy loading
- (NSMutableArray<UIButton *> *)buttons {
    if (!_buttons) {
        _buttons = @[].mutableCopy;
    }
    return _buttons;
}
#pragma mark UI
- (void)setupUI {
    _problemType = @"1";
    _back_view = [UIView new];
    _back_view.backgroundColor = k_white_color;
    _back_view.layer.cornerRadius = 5.f;
    [self addSubview:_back_view];
    
    _title_label = [[UILabel alloc] initWithText:@"反馈类型" textColor:k_text_color textFont:k_text_font_args(CalculateHeight(14))];
    [_back_view addSubview:_title_label];
    
    NSArray *titles = @[
                        @"功能建议",
                        @"体验建议",
                        @"内容建议",
                        @"其他"];
    CGFloat width = (kScreenWidth - CalculateWidth(66)) / 4.f;
    CGFloat height = CalculateHeight(38);
    for (NSInteger index = 0; index < 5; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom
                            ];
        button.layer.cornerRadius = 5.f;
        button.titleLabel.font = k_text_font_args(CalculateHeight(13));
        button.layer.borderColor = k_themeblue_color.CGColor;
        button.layer.borderWidth = CalculateWidth(1);
        [button setTitle:titles[index] forState:normal];
        [button setTitleColor:k_black_color forState:normal];
        [button setTitleColor:k_themeblue_color forState:UIControlStateSelected];
        [button addTarget:self action:@selector(problemFeedbackTypeButtonAction:) forControlEvents:64];
        button.tag = index+1;
        button.st_size = CGSizeMake(width, height);
        button.st_x = index == 4 ? CalculateHeight(10) : width * index + (index + 1) * CalculateWidth(10);
        button.st_y = index == 4 ? CalculateHeight(90) : CalculateHeight(38);
        button.selected = index == 0;
        [_back_view addSubview:button];
        [self.buttons addObject:button];
    }
    
    _textView = [UITextView new];
    _textView.layer.cornerRadius = 5.f;
    _textView.tintColor = k_themeblue_color;
    _textView.layer.borderWidth = CalculateWidth(1);
    _textView.layer.borderColor = k_themeblue_color.CGColor;
    _textView.placeholder = @"请详细填写以便我们能够快速帮您解决";
    [_back_view addSubview:_textView];
    
    _phoneText = [[UITextField alloc] init];
    _phoneText.keyboardType = UIKeyboardTypePhonePad;
    _phoneText.layer.cornerRadius = 5.0f;
    _phoneText.tintColor = k_themeblue_color;
    _phoneText.layer.borderWidth = CalculateWidth(1);
    _phoneText.layer.borderColor = k_themeblue_color.CGColor;
    NSString *holderStr = @"请输入联系号码";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderStr];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:14]
                        range:NSMakeRange(0, holderStr.length)];
    _phoneText.attributedPlaceholder = placeholder;
    [_back_view addSubview:_phoneText];
    
//    _problem_img = [UIImageView new];
//    _problem_img.image = [UIImage imageNamed:@"mall_problem_feedback_add"];
//    _problem_img.layer.cornerRadius = 5.f;
//    _problem_img.layer.masksToBounds = YES;
//    _problem_img.layer.borderColor = k_themeblue_color.CGColor;
//    _problem_img.layer.borderWidth = CalculateWidth(1);
//    _problem_img.userInteractionEnabled = YES;
//    _problem_img.contentMode = UIViewContentModeScaleAspectFill;
//    [_back_view addSubview:_problem_img];
    
    _commit_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_commit_btn setTitle:@"提交反馈" forState:normal];
    [_commit_btn setTitleColor:k_white_color forState:normal];
    _commit_btn.backgroundColor = k_themeblue_color;
    _commit_btn.layer.cornerRadius = CalculateHeight(22);
    _commit_btn.titleLabel.font = k_text_font_args(CalculateHeight(16));
    [_back_view addSubview:_commit_btn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_back_view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(CalculateHeight(8), CalculateWidth(8), CalculateHeight(8), CalculateWidth(8)));
    }];
    [_title_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(14));
        make.left.offset(CalculateWidth(10));
    }];
    UIButton *button = [self.buttons lastObject];
    [_textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(10));
        make.right.offset(-CalculateWidth(10));
        make.top.equalTo(button.mas_bottom).offset(CalculateHeight(10));
        make.height.mas_equalTo(CalculateHeight(160));
    }];
    [_phoneText mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textView.mas_bottom).offset(CalculateHeight(15));
        make.left.equalTo(_textView);
        make.right.equalTo(_textView);
        make.height.mas_equalTo(CalculateHeight(30));
    }];
//    [_problem_img mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_phoneText.mas_bottom).offset(CalculateHeight(15));
//        make.left.equalTo(_textView);
//        make.size.mas_equalTo(CGSizeMake(CalculateWidth(84), CalculateHeight(84)));
//    }];
    [_commit_btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(270), CalculateHeight(44)));
        make.centerX.offset(0);
        make.top.equalTo(_phoneText.mas_bottom).offset(CalculateHeight(57));
    }];
}

@end
