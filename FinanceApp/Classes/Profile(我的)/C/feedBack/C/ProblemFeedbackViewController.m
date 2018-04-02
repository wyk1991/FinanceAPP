//
//  ProblemFeedbackViewController.m
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

#import "ProblemFeedbackViewController.h"
#import "ProblemFeedbackView.h"

@interface ProblemFeedbackViewController ()

@property (nonatomic, strong) ProblemFeedbackView *pf_view;

@property (nonatomic, strong) NSMutableArray <ZLPhotoAssets *>*assets;

@end

@implementation ProblemFeedbackViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _pf_view.textView.text =@"";
    _pf_view.phoneText.text =@"";
}

#pragma mark Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}
//- (NSMutableArray <ZLPhotoAssets *>*)assets{
//    if (!_assets) {
//        _assets = [NSMutableArray array];
//    }
//    return _assets;
//}
#pragma mark Action
//- (void)selectPhotoAction:(UITapGestureRecognizer *)tap {
//    [self.view endEditing:YES];
//    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
//    pickerVc.maxCount = 3;
//    pickerVc.status = PickerViewShowStatusCameraRoll;
//    pickerVc.photoStatus = PickerPhotoStatusPhotos;
//    pickerVc.topShowPhotoPicker = YES;
//    pickerVc.isShowCamera = YES;
//    WS(weakSelf);
//    pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
//        weakSelf.assets = status.mutableCopy;
//        weakSelf.pf_view.problem_img.image = [status.firstObject thumbImage];
//    };
//    [pickerVc showPickerVc:self];
//}
- (void)commitProblemButtonAction:(UIButton *)sender {
    [self.view endEditing:YES];
    NSString *problem = _pf_view.textView.text;
    NSString *phone = _pf_view.phoneText.text;
   
    if ([[NSString alloc]initWithString:[problem stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]].length == 0) {
        [LDToast showToastWith:@"说点什么吧~"];
        return;
    }
    if ([[NSString alloc]initWithString:[phone stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]].length != 0) {
        if (![MJYUtils mjy_checkTel:phone]) {
            [LDToast showToastWith:@"请填写正确的手机号码格式"];
            return;
        }
    }
    NSDictionary *dic = @{@"type":  _pf_view.problemType, @"content": _pf_view.textView.text, @"telephone": _pf_view.phoneText.text};
    
//    [GSHttpManager afnNetworkPostParameter:dic toPath:feedBack_post success:^(id result) {
//        if ([result[@"code"] longValue] == 200) {
//            // 提交成功
//            NSLog(@"%@\n%@image:%@", _pf_view.problemType, problem, self.assets.firstObject);
//            SuccessViewController *vc = [[SuccessViewController alloc] init];
//            vc.successType = SuccessTypeProblemFeedback;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    } orFail:^(NSError *error) {
//        [LDToast showToastWith:@"问题反馈失败"];
//    }];
}
#pragma mark Data

#pragma mark UI
- (void)initUI {
    [super initUI];
    self.title = @"问题反馈";
    [self.view addSubview:self.pf_view];
    [_pf_view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark Lazy Loading
- (ProblemFeedbackView *)pf_view {
    if (!_pf_view) {
        _pf_view = [[ProblemFeedbackView alloc] init];
//        [_pf_view.problem_img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhotoAction:)]];
        [_pf_view.commit_btn addTarget:self action:@selector(commitProblemButtonAction:) forControlEvents:64];
    }
    return _pf_view;
}

@end
