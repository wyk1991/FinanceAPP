//
//  ProblemFeedbackView.h
//  SSS_MALL
//
//  Created by 徐洋 on 2017/8/3.
//  Copyright © 2017年 Losdeoro24K. All rights reserved.
//

#import "BaseView.h"

@interface ProblemFeedbackView : BaseView
/**
 上传的图片
 */
@property (nonatomic, strong) UIImageView *problem_img;
/**
 提交反馈
 */
@property (nonatomic, strong) UIButton *commit_btn;

/**
 1-订单问题 2-功能异常 3-体验问题 4-好建议 5-其他
 */
@property (nonatomic, copy) NSString *problemType;
/**
 详细问题描述
 */
@property (nonatomic, strong) UITextView *textView;
/**
 *   联系人号码
 */
@property (nonatomic, strong) UITextField *phoneText;

@end
