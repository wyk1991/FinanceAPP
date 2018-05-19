//
//  UIScrollView+UITouch.h
//  FinanceApp
//
//  Created by SX on 2018/5/15.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (UITouch)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
@end
