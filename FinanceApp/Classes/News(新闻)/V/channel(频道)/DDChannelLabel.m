//
//  DDChannelLabel.m
//  DDNews
//
//  Created by Dvel on 16/4/7.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDChannelLabel.h"

@implementation DDChannelLabel

+ (instancetype)channelLabelWithTitle:(NSString *)title
{
	DDChannelLabel *label = [self new];
	label.text = title;
	label.textAlignment = NSTextAlignmentCenter;
	label.font = k_text_font_args(CalculateHeight(18));
	[label sizeToFit];
	label.userInteractionEnabled = YES;
	return label;
}

- (CGFloat)textWidth
{
	return [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].width + 8; // +8，要不太窄
}


- (void)setScale:(CGFloat)scale
{
	_scale = scale;

	self.textColor = k_white_color;
}



- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, self.text];
}

@end
