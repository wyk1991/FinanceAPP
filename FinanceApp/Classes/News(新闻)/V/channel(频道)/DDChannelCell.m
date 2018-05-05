//
//  DDChannelCell.m
//  DDNews
//
//  Created by Dvel on 16/4/7.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDChannelCell.h"
#import "NewsListViewController.h"

//#import "UIView+Extension.h"

@implementation DDChannelCell

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
//		NSLog(@"%s", __func__);
	}
	return self;
}



- (void)setPageType:(NSString *)pageType {
    _newsTVC = [[NewsListViewController alloc] init];
    _newsTVC.view.frame = self.bounds;
    _newsTVC.pageType = pageType;
    [self addSubview:_newsTVC.view];
    [self addSubview:_newsTVC.searchBackView];
}

@end
