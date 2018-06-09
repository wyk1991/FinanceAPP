//
//  PersonalViewController.m
//  FinaceApp
//
//  Created by SX on 2018/3/5.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import "PersonalViewController.h"
#import "SettingModel.h"
#import "NormalUserCell.h"
#import "QuickLoginViewController.h"
#import "ChangeNickViewController.h"

#import "BaseSituationListViewController.h"
#import "HttpTool.h"

@interface PersonalViewController()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UIImageView *userImg;
@end

@implementation PersonalViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionHeaderHeight = 0;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
        
    }
    return _tableView;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.view.backgroundColor = k_back_color;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)loadData {
    if (self.dataArr.count) {
        [self.dataArr removeAllObjects];
    }
    
    NSArray *array = @[
                       @[@{@"title": @"昵称", @"content": kApplicationDelegate.userHelper.userInfo.user.nickname, @"isArrow": @"1", @"isSwitch": @"0"}, @{@"title": @"性别", @"content": [kApplicationDelegate.userHelper.userInfo.user.sex isEqualToString:@"0"] ? @"男" : @"女", @"isArrow": @"1", @"isSwitch": @"0"}],
                       
                       @[@{@"title": @"账号与安全", @"isArrow": @"1", @"isSwitch": @"0"}]
                       ];
    self.dataArr = [SettingModel mj_objectArrayWithKeyValuesArray:array];
    [self.tableView reloadData];
}

- (void)initUI {
    [super initUI];
    [self.view addSubview:self.tableView];
}

- (void)addMasnory {
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NormalUserCell *cell = [tableView dequeueReusableCellWithIdentifier:normalPersonCellIden];
    
    if(!cell) {
        cell = [[NormalUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalPersonCellIden];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _dataArr[indexPath.section][indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CalculateHeight(90))];
        v.backgroundColor = k_white_color;
        
        UIImageView *avatorImg = [[UIImageView alloc] init];
        avatorImg.contentMode = UIViewContentModeScaleToFill;
        ViewBorderRadius(avatorImg, 30, 0, [UIColor clearColor]);
        avatorImg.clipsToBounds = YES;
        avatorImg.userInteractionEnabled = YES;
        [avatorImg sd_setImageWithURL:[NSURL URLWithString:kApplicationDelegate.userHelper.userInfo.user.avatar_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
        UIImageView *phImg = [[UIImageView alloc] init];
        phImg.contentMode = UIViewContentModeScaleToFill;
        phImg.userInteractionEnabled = YES;
        [phImg setImage:[UIImage imageNamed:@"__picker_ic_camera_n"]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAvator)];
        [avatorImg addGestureRecognizer:tap];
        
        [v addSubview:avatorImg];
        [v addSubview:phImg];
        
        [avatorImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(v);
            make.centerY.equalTo(v);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        [phImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(avatorImg.mas_right).offset(-CalculateWidth(25));
            make.top.equalTo(avatorImg.mas_bottom).offset(-CalculateHeight(25));
            make.size.mas_equalTo(CGSizeMake(CalculateWidth(25), CalculateHeight(25)));
        }];
        self.userImg = avatorImg;
        return v;
    } else {
        return [UIView new];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CalculateHeight(60);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CalculateHeight(100);
    } else {
        return CalculateHeight(10);
    }
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ChangeNickViewController *vc = [[ChangeNickViewController alloc] init];
            vc.title = @"修改昵称";
            vc.content = kApplicationDelegate.userHelper.userInfo.user.nickname;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 1) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *man = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                // 请求网络数据
                [HttpTool afnNetworkPostParameter:@{@"sex":@"0",@"session_id":kApplicationDelegate.userHelper.userInfo.token} toPath:modify_user success:^(id result) {
                    if ([result[@"status"] integerValue] == 100) {
                        kApplicationDelegate.userHelper.userInfo.user.sex = @"0";
                        NSData *modelData = [kNSUserDefaults valueForKey:kAppHasCompletedLoginUserInfo];
                        UserInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
                        model.user.sex = @"0";
                        
                        [kNSUserDefaults setObject:modelData forKey:kAppHasCompletedLoginUserInfo];
                        [kNSUserDefaults synchronize];
                        [self loadData];
                    }
                } orFail:^(NSError *error) {
                    [LDToast showToastWith:@"修改失败"];
                    
                }];
                
            }];
            UIAlertAction *woman = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
                // 请求网络数据
                [HttpTool afnNetworkPostParameter:@{@"sex":@"1", @"session_id":kApplicationDelegate.userHelper.userInfo.token} toPath:modify_user success:^(id result) {
                    if ([result[@"status"] integerValue] == 100) {
                        kApplicationDelegate.userHelper.userInfo.user.sex = @"1";
//                        [[kNSUserDefaults valueForKey:kAppHasCompletedLoginUserInfo] setValue:@"sex" forKey:@"1"];
                        NSData *modelData = [kNSUserDefaults valueForKey:kAppHasCompletedLoginUserInfo];
                        UserInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
                        model.user.sex = @"1";
                        
                        [kNSUserDefaults setObject:modelData forKey:kAppHasCompletedLoginUserInfo];
                        [kNSUserDefaults synchronize];
                        [self loadData];
                    }
                } orFail:^(NSError *error) {
                    
                }];
            }];
            [alert addAction:cancelAction];
            [alert addAction:man];
            [alert addAction:woman];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    if (indexPath.section == 1 && indexPath.row == 0 ) {
        BaseSituationListViewController *vc = [[BaseSituationListViewController alloc] init];
        vc.title = @"账号与安全";
        vc.setType = 4;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)clickAvator {
    NSLog(@"点击了头像");
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    /* 判断相册是否可以访问 */
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIAlertAction *picture = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
                
            }
            pickerImage.delegate = self;
            pickerImage.allowsEditing = NO;
            
            [self presentViewController:pickerImage animated:YES completion:nil];
        }];
        
        [alert addAction:picture];
    }
    
    /** 判断相机是否可以访问 */
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }];
        
        [alert addAction:camera];
    }
    
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self uploadImageWithImga:info[@"UIImagePickerControllerOriginalImage"] with:picker];
    
}

// 取消选取图片
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)uploadImageWithImga:(UIImage *)img with:(UIImagePickerController *)picker{
    if (!img) {
        return;
    }
    [img imageWithCorner:CGSizeMake(30, 30) completaion:^(UIImage *image) {
        [HttpTool startUploadImage:image toPath:upload_useravator with:@{} outParse:^(id retData, NSError *error) {
            
            NSLog(@"%@",kApplicationDelegate.userHelper.userInfo.user.avatar_url );
            
            kApplicationDelegate.userHelper.userInfo.user.avatar_url = retData;
            
            NSData *modelData = [kNSUserDefaults valueForKey:kAppHasCompletedLoginUserInfo];
            UserInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
            model.user.avatar_url = retData;
//            [kNSUserDefaults setObject:model forKey:kAppHasCompletedLoginUserInfo];
//            [kNSUserDefaults synchronize];
            
            [picker dismissViewControllerAnimated:YES completion:nil];
            [self.tableView reloadData];
        } callback:^(id obj, NSError *error) {
            
        }];
    }];
    
    
    
}
@end
