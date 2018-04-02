//
//  MJYUtils.h
//  MJY_Utils
//
//  Created by typc on 15/10/11.
//  Copyright © 2015年 tianyuanshihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MJYUtils : NSObject

#pragma mark - UI无关的方法
//*******************************************
//和UI无关的方法
//*******************************************

/**
 中文转拼音

 @param chinese 中文字
 @return 拼音
 */
+ (NSString *)transform:(NSString *)chinese;

/**
 *	@brief	判断应用运行在什么系统版本上
 *
 *	@return	返回系统版本 ：7.0     6.0     6.1等
 */
+ (CGFloat)mjy_checkSystemVersion;

/**
 *	@brief	判断应用的版本号
 *
 *	@return	返回版本号
 */
+ (NSString *)mjy_checkAPPVersion;

/**
 *	@brief	处理null字符串
 * */
+ (NSString*)mjy_fuckNULL:(NSObject*)obj;

/**
 *  单个文件的大小
 *
 *  @param filePath 文件路径
 *
 *  @return 大小bit
 */
+ (long long)mjy_fileSizeAtPath:(NSString*) filePath;

/**
 *  整个文件夹的大小
 *
 *  @param folderPath 文件路径
 *
 *  @return 大小M
 */
+ (float )mjy_folderSizeAtPath:(NSString*) folderPath;


/**
 *  消息推送是否开启
 *
 *  @return 是否开启
 */
+ (BOOL)mjy_isAllowedNotification;

/**
 *  根据车牌号获取管局的信息
 *
 *  @param lsnum 车牌号
 *
 *  @return 管局的字符串信息
 */
+ (NSString *)mjy_getCarorgWithLsnum:(NSString *)lsnum;


/**
 *  检测用户名格式
 *
 *  @return bool
 */
+ (BOOL)mjy_checkQQ:(NSString *)qq;
//QQ
+ (BOOL)mjy_checkTel:(NSString *)tel;
//座机
+ (BOOL)mjy_checkTellandline:(NSString *)telland;
//邮箱
+ (BOOL)mjy_checkEmail:(NSString *)email;
//验证码
+ (BOOL)mjy_checkVerifyCode:(NSString *)code;
//用户名
+ (BOOL)mjy_checkUserName:(NSString *)username;
//密码
+ (BOOL)mjy_checkPassWord:(NSString *)password;
//用户输入
+ (BOOL)mjy_checkUserInput:(NSString *)input;
//身份证号
+ (BOOL)mjy_checkPersonID:(NSString *)personID;


/**
 *  将tel替换为****
 *
 *  @param tel 电话号码
 *
 *  @return 替换完的tel
 */
+ (NSString *)mjy_telForStartWithTelNum:(NSString *)tel;

/**
 *  产生一个随机数
 *
 *  @param from 开始
 *  @param to   结束
 *
 *  @return 随机数
 */
+ (NSInteger)mjy_getRandomNumberFrom:(NSInteger)from to:(NSInteger)to;


/**
 *  获取uuid
 */
+ (NSString*) mjy_uuid;

/**
 *  读取JSON信息列表
 */
+ (NSMutableArray *) mjy_JSONAddressInfos;




#pragma mark - UI相关的方法
//*******************************************
//UI相关的工具方法
//*******************************************

/**
 *  利用webView实现拨打电话的功能
 *
 *  @param phoneNumber 电话号码
 *  @param view        父视图
 */
+ (void)mjy_callPhone:(NSString *)phoneNumber withSuperView:(UIView *)view;


/**
 *	@brief	隐藏tableivew中多余的cell
 */
+ (void)mjy_hiddleExtendCellForTableView:(UITableView *)tableView;

/**
 *  设置整个应用统一的返回按钮
 *
 *  @param image 返回按钮的图片
 */
+ (void)mjy_settingBackButtonImageWithImage:(UIImage *)image;

/**
 *  指定的tableView 滑动到最后一行
 *
 *  @param tableView tableView
 *  @param animated  是否动画显示
 */
+ (void)mjy_scrollToFootWithTableView:(UITableView *)tableView isAnimated:(BOOL)animated;


/**
 *
 *  @param image     要缩放的image
 *
 *  @return 缩放后的图片
 */
+ (UIImage *)mjy_scaleImage:(UIImage *)image withScale:(float)scale;


/**
 *  自动计算label的高度(宽度可以传)
 */
+(CGFloat)mjy_heightForLabel:(UILabel *)label
                WithText:(NSString *)text
                fontName:(NSString *)fontName
                fontSize:(CGFloat)fontSize
                   width:(CGFloat)width;

+ (NSMutableAttributedString *)attributeStr:(NSString *)all changePartStr:(NSArray < NSString *> *)partStr withFont:(NSInteger)font andColor:(UIColor *)color;

+ (NSString *)mjy_timeChangeWith:(NSString *)time;//时间戳字符串转时间字符串

+ (NSString *)mjy_getSysTime;
+ (NSString *)mjy_getSysWeekDay;


+ (NSString *)mjy_getInterval;

+ (NSString *)updateTimeForRow:(NSString *)createTimeString;

+ (void)saveToUserDefaultWithKey:(NSString *)key withValue:(id)data;

//取
+ (id)getFromUserDefaultWithKey:(NSString *)key;

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

+ (NSString *)timeStrChangetoinv:(NSString *)timeStr;//字符串转时间戳字符串

+ (NSInteger )timeDifferenceBetween:(NSString *)start and:(NSString *)end;
//比较大小
+ (BOOL)compareDate:(NSString*)aDate withDate:(NSString*)bDate;
+ (NSString *)mjy_changedata:(NSData *)date;

+ (NSDate *)mjy_changedataStr:(NSString *)dateStr;

+ (NSString *)stringFamatWithCapital:(NSString *)money;//金额大写转换
+ (NSArray *)imageFromSdcacheWith:(NSArray *)pics; //取缓存照片
+ (NSArray *)filePathFromSdcacheWith:(NSArray *)pics;//取出文件路径



/**
 获取最上层控制器
 */
+ (UIViewController *)topViewController;
@end
