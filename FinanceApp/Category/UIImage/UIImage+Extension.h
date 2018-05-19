//
//  UIImage+Extension.h
//  
//
//  Created by nacker on 15-3-9.
//  Copyright © 2016年 帶頭二哥 QQ:648959. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *)imageWithName:(NSString *)name;

+ (UIImage *)resizedImage:(NSString *)name;

+ (UIImage *)resizedImage:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

/* 裁剪圆形图片 */
+ (UIImage *)clipImage:(UIImage *)image;

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;
/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)createImageWithColor:(UIColor *)color;

/**
 将imageView裁剪为圆形

 @param cornerRadius 半径
 @return image
 */
- (void)imageWithCorner:(CGSize)size completaion:(void (^)(UIImage *))completion;
@end
