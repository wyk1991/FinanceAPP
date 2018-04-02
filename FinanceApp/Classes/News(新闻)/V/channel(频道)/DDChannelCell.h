//
//  DDChannelCell.h
//  DDNews
//
//  Created by Dvel on 16/4/7.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsListViewController;

@interface DDChannelCell : UICollectionViewCell

@property (nonatomic, strong) NewsListViewController *newsTVC;

@property (nonatomic, strong) NSString *pageType;

@end
