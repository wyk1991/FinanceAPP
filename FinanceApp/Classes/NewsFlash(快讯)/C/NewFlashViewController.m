//
//  NewFlashViewController.m
//  FinaceApp
//
//  Created by SX on 2018/3/2.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import "NewFlashViewController.h"
#import "FlashHelper.h"
#import "TagsModel.h"
#import "NewFlashListController.h"

@interface NewFlashViewController ()

@property (nonatomic, strong) FlashHelper *helper;

@end

@implementation NewFlashViewController

#pragma mark - lazy

- (FlashHelper *)helper {
    if (!_helper) {
        _helper = [FlashHelper shareHelper];
    }
    return _helper;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadTagData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_white_color;
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CalculateWidth(112), CalculateHeight(27))];
    img.image = [UIImage imageNamed:@"ic_logo"];
    self.navigationItem.titleView = img;
}

- (void)loadTagData {
    WS(weakSelf);
    [[FlashHelper shareHelper] helperGetFlashTagWithPath:flash_tag callback:^(id obj, NSError *error) {
        NSMutableArray *tmp = @[].mutableCopy;
        for (TagsModel *model in self.helper.flashTag) {
            [tmp addObject:model.name];
        }
        weakSelf.titlesArr = tmp;
        
        [self updateSuperTitleAry];
    }];
}

- (void)addChildViewController {
    for (int i = 0; i < self.titlesArr.count; i++) {
        NewFlashListController * vc = [[NewFlashListController alloc] init];
        vc.cateType = [MJYUtils transform:self.titlesArr[i]];
        vc.title  =  self.titlesArr[i];
        [self addChildViewController:vc];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
