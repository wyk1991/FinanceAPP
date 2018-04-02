//
//  MJYUtils.m
//  MJY_Utils
//
//  Created by typc on 15/10/11.
//  Copyright © 2015年 tianyuanshihua. All rights reserved.
//

#import "MJYUtils.h"
//#import "AddressGroupJSONModel.h"
//#import "AddressJSONModel.h"

@implementation MJYUtils
+ (NSString *)transform:(NSString *)chinese{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    NSLog(@"%@", pinyin);
    
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    
    //1. 去掉首尾空格和换行符
    NSString *str = (NSString *)pinyin;
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //2. 去掉所有空格和换行符
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""]; 
    
    //返回最近结果
    return str;
    
}


+ (CGFloat)mjy_checkSystemVersion
{
    static dispatch_once_t onceToken;
    __block float systemVersion = 0;
    dispatch_once(&onceToken, ^{
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    return systemVersion;
}

+ (NSString *)mjy_checkAPPVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    return appVersion;
}

+ (NSString*)mjy_fuckNULL:(NSObject*)obj
{
    if (obj == nil || [obj isKindOfClass:[NSNull class]])
    {
        return @"";
        
    }else if ([obj isKindOfClass:[NSNumber class]])
    {
        return [NSString stringWithFormat:@"%@",obj];
        
    }else if(![obj isKindOfClass:[NSString class]])
    {
        return @"";
    }else if ([obj isKindOfClass:[NSString class]])
    {
        if ([(NSString *)obj isEqualToString:@"<null>"])
        {
            return @"";
            
        }else if ([(NSString *)obj isEqualToString:@"null"])
        {
            return @"";
        }else
        {
            return [NSString stringWithFormat:@"%@",obj];
        }
        
    }else
    {
        return @"";
    }
}

//单个文件的大小
+ (long long)mjy_fileSizeAtPath:(NSString*) filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath])
    {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}


//遍历文件夹获得文件夹大小，返回多少M
+ (float )mjy_folderSizeAtPath:(NSString*) folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil)
    {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self mjy_fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

//消息推送是否开启
+ (BOOL)mjy_isAllowedNotification
{
    //iOS8 check if user allow notification
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)
    {// system is iOS8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types)
        {
            return YES;
        }
    }
    return NO;
}

/**
 *  根据车牌号获取管局的信息
 *
 *  @param lsnum 车牌号
 *
 *  @return 管局的字符串信息
 */
+(NSString *)mjy_getCarorgWithLsnum:(NSString *)lsnum
{
    NSString *city;//城市
    NSString *carorg;//管局
    
    if(lsnum && lsnum.length>=1)
    {
        city = [lsnum substringToIndex:1];
        if ([@"沪" isEqualToString:city])
        {
            carorg = @"shanghai";
        }else if ([@"渝" isEqualToString:city])
        {
            carorg = @"chongqing";
        }else if ([@"渝" isEqualToString:city])
        {
            carorg = @"chongqing";
        }else if ([@"冀" isEqualToString:city])
        {
            carorg = @"hebei";
        }else if ([@"晋" isEqualToString:city])
        {
            carorg = @"shanxi";
        }else if ([@"辽" isEqualToString:city])
        {
            carorg = @"liaoning";
        }else if ([@"吉" isEqualToString:city])
        {
            carorg = @"jilin";
        }else if ([@"黑" isEqualToString:city])
        {
            carorg = @"heilongjiang";
        }else if ([@"浙" isEqualToString:city])
        {
            carorg = @"zhejiang";
        }else if ([@"皖" isEqualToString:city])
        {
            carorg = @"anhui";
        }else if ([@"鲁" isEqualToString:city])
        {
            carorg = @"shandong";
        }else if ([@"豫" isEqualToString:city])
        {
            carorg = @"henan";
        }else if ([@"鄂" isEqualToString:city])
        {
            carorg = @"hubei";
        }else if ([@"湘" isEqualToString:city])
        {
            carorg = @"hunan";
        }else if ([@"粤" isEqualToString:city])
        {
            carorg = @"guangdong";
        }else if ([@"琼" isEqualToString:city])
        {
            carorg = @"hainan";
        }else if ([@"川" isEqualToString:city])
        {
            carorg = @"sichuan";
        }else if ([@"贵" isEqualToString:city])
        {
            carorg = @"guizhou";
        }else if ([@"云" isEqualToString:city])
        {
            carorg = @"yunnan";
        }else if ([@"陕" isEqualToString:city])
        {
            carorg = @"shanxi";
        }else if ([@"甘" isEqualToString:city])
        {
            carorg = @"gansu";
        }else if ([@"青" isEqualToString:city])
        {
            carorg = @"qinghai";
        }else if ([@"内" isEqualToString:city])
        {
            carorg = @"neimenggu";
        }else if ([@"藏" isEqualToString:city])
        {
            carorg = @"xizang";
        }else if ([@"宁" isEqualToString:city])
        {
            carorg = @"ningxia";
        }else if ([@"新" isEqualToString:city])
        {
            carorg = @"xijiang";
        }
        return carorg;
    }else
    {
        return @"";
    }
}

#pragma mark 匹配账户合法性(3_16位_字母数字和下划线的组合)

//验证用户输入不能为空
+ (BOOL)mjy_checkUserInput:(NSString *)input
{
    if ([input length] == 0)
    {
        return NO;
    }
    
    int length = (int)[input stringByReplacingOccurrencesOfString:@" " withString:@""].length;
    
    if (length==0)
    {
        return NO;
    }
    
    return YES;
}

//验证用户名
+(BOOL)mjy_checkUserName:(NSString *)username
{
    if ([username length] == 0)
    {
        return NO;
    }
    
    NSString *regex = @"^[a-zA-Z][a-zA-Z0-9_]{3,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:username];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
}


//验证密码
+(BOOL)mjy_checkPassWord:(NSString *)password
{
    if ([password length] == 0)
    {
        return NO;
    }
    
    NSString *regex = @"^[a-zA-Z0-9_]{6,17}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:password];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
}


//验证验证码格式
+(BOOL)mjy_checkVerifyCode:(NSString *)code
{
    if ([code length] == 0)
    {
        return NO;
    }
    
    NSString *regex = @"[0-9]{6}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:code];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
    
}

//验证QQ
+ (BOOL)mjy_checkQQ:(NSString *)qq
{
    if ([qq length] == 0)
    {
        return NO;
    }
    
    NSString *regex = @"[0-9]{1,15}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:qq];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
}

//验证手机格式
+ (BOOL)mjy_checkTel:(NSString *)tel
{
    if ([tel length] == 0)
    {
        return NO;
    }
    
    NSString *regex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:tel];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
}

//验证座机格式
+ (BOOL)mjy_checkTellandline:(NSString *)telland
{
    if ([telland length] == 0)
    {
        return NO;
    }
    
    NSString *regex = @"\\d{2,5}-\\d{7,8}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:telland];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
}

//验证邮箱
+ (BOOL)mjy_checkEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 *
 *
 *  @param personID 身份证号
 *
 *  @return 是否匹配
 */
+ (BOOL)mjy_checkPersonID:(NSString *)personID
{
    NSString *personIDRegex = @"^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$";
    NSPredicate *personIDTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", personIDRegex];
    return [personIDTest evaluateWithObject:personID];
}



/**
 *  将tel替换为****
 *
 *  @param tel 电话号码
 *
 *  @return 替换完的tel
 */
+ (NSString *)mjy_telForStartWithTelNum:(NSString *)tel
{
    if (tel.length<11)
    {
        return @"格式错误";
    }
    
    return [tel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}

/**
 *  随机数
 *
 *  @param from 开始
 *  @param to   结束
 *
 *  @return 随机数
 */
+ (NSInteger)mjy_getRandomNumberFrom:(NSInteger)from to:(NSInteger)to
{
    return (long)(from + (arc4random() % (to -from + 1)));
}



/**
 *  UUID
 *
 *  @return
 */
+ (NSString*) mjy_uuid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}


/**
 *  读取JSON信息列表
 */
+ (NSMutableArray *) mjy_JSONAddressInfos
{
    NSString *addressPath = [[NSBundle mainBundle] pathForResource:@"address_list.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:addressPath options:NSDataReadingUncached error:nil];
    NSDictionary *dicAddress = [JYJSON dictionaryOrArrayWithJSONSData:data];
    NSArray *arrAddress = dicAddress[@"citylist"];
    NSMutableArray *ma = [NSMutableArray array];
    for (NSDictionary *dic in arrAddress) {
        NSLog(@"%@", dic);
//        AddressGroupJSONModel *jsonInfo = [[AddressGroupJSONModel alloc] initWithDic:dic];
//        [ma addObject:jsonInfo];
    }
    return ma;
}



//--------------------------------UI
//隐藏tableView多余的分割线
+ (void)mjy_hiddleExtendCellForTableView:(UITableView *)tableView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

//拨打电话
+ (void)mjy_callPhone:(NSString *)phoneNumber withSuperView:(UIView *)view
{
    UIWebView *phoneWebView;
    for (UIView *subV in view.subviews){
        if ([subV isKindOfClass:[UIWebView class]]){
            phoneWebView = (UIWebView *)subV;
            break;
        }
    }
    if (!phoneWebView){
        //如果没有的话就添加一个webView
        phoneWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        [view addSubview:phoneWebView];
    }
    //否则就不用添加了,直接用已经存在的webView来加载就可以了
    NSURL *url = [NSURL URLWithString:[@"tel://" stringByAppendingString:phoneNumber]];
    [phoneWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

//统一返回按钮
+ (void)mjy_settingBackButtonImageWithImage:(UIImage *)image
{
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
}

//滑动到最后一行
+ (void)mjy_scrollToFootWithTableView:(UITableView *)tableView isAnimated:(BOOL)animated
{
    NSInteger s = [tableView numberOfSections];
    if (s<1) return;
    NSInteger r = [tableView numberOfRowsInSection:s-1];
    if (r<1) return;
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];
    
    [tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    
}


//等比缩放UIImage
+ (UIImage *)mjy_scaleImage:(UIImage *)image withScale:(float)scale
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scale, image.size.height * scale));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scale, image.size.height * scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


+(CGFloat)mjy_heightForLabel:(UILabel *)label
                    WithText:(NSString *)text
                    fontName:(NSString *)fontName
                    fontSize:(CGFloat)fontSize
                       width:(CGFloat)width
{
    if (!text)
    {
        return 0;
    }else
    {
        if (!fontName)
        {
            //系统默认的字体
            fontName = @"Helvetica";
        }
        
        //创建字体信息
        UIFont *textFont = [UIFont fontWithName:fontName size:fontSize];
        //字体字典信息
        NSDictionary *fontDict =[NSDictionary dictionaryWithObject:textFont forKey:NSFontAttributeName];
        
        //设置label的属性
        label.numberOfLines = 0 ;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label.backgroundColor = [UIColor clearColor];
        label.font = textFont;
        
        
        CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                      attributes:fontDict
                                         context:nil];
        
        return rect.size.height+10;
        
    }
    
}



/**
 *  可变字符串定义字号颜色
 */

+ (NSMutableAttributedString *)attributeStr:(NSString *)all changePartStr:(NSArray < NSString *> *)partStr withFont:(NSInteger)font andColor:(UIColor *)color {
    
    if (!partStr.count) {
        return nil;
    }
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:all];

    for (NSString *str  in partStr) {
        NSRange font_range = [all rangeOfString:str];
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:font_range];
        [mAttStri addAttribute:NSForegroundColorAttributeName value:color range:font_range];
    }
    
    return mAttStri;
}

+ (NSString *)mjy_timeChangeWith:(NSString *)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (time.length== 0) {
        [formatter setDateFormat:@"YYYY-MM-dd"];
    } else
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}


+ (NSString *)mjy_getSysTime {
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    return  [formatter stringFromDate:date];
}


+ (NSString *)mjy_getInterval {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    return timeString;
}

+ (NSString *)updateTimeForRow:(NSString *)createTimeString {
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = [createTimeString longLongValue]/1000;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    
    NSInteger sec = time/60;
    
    if (sec<5) {
        return [NSString stringWithFormat:@"刚刚"];
    }
    
    if (sec<60) {
        return [NSString stringWithFormat:@"%ld分钟前",sec];
    }
    
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",years];
}


//存NSUserDefault
+ (void)saveToUserDefaultWithKey:(NSString *)key withValue:(id)data
{
    [kNSUserDefaults setObject:data forKey:key];
    
    [kNSUserDefaults synchronize];
}
//取
+ (id)getFromUserDefaultWithKey:(NSString *)key
{
    id data = [kNSUserDefaults objectForKey:key];
    
    return data;
}


//对图片尺寸进行压缩--
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


+ (NSString *)mjy_getSysWeekDay {
    //1.获取当月的总天数
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    NSLog(@"%lu", (unsigned long)numberOfDaysInMonth);
    
    //2.获取当前年份, 月份, 号数
    unsigned unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    NSLog(@"%ld, %ld, %ld", (long)components.year, (long)components.month, (long)components.day);
    
    
    //3.获取当前日期星期几
    NSArray *weekdays = [NSArray arrayWithObjects:@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSDate *date = [NSDate date];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    NSLog(@"%@", [weekdays objectAtIndex:theComponents.weekday- 1]);
    return [weekdays objectAtIndex:theComponents.weekday-1];
}
+ (NSInteger )timeDifferenceBetween:(NSString *)start and:(NSString *)end {
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    df.dateFormat = start.length == 10 ? @"yyyy-MM-dd" : @"yyyy-MM-dd HH:mm";
    
    NSDate * date1 = [df dateFromString:start];
    NSDate * date2 = [df dateFromString:end];
    NSTimeInterval time = [date2 timeIntervalSinceDate:date1];
    
    return time/3600;
}

//比较两个日期的大小  日期格式为2016-08-14 08：46：20
+ (BOOL)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
   
    NSDate * date1 = [dateformater dateFromString:aDate];
    NSDate * date2 = [dateformater dateFromString:bDate];
    
    NSComparisonResult result = [date1 compare:date2];
    if (result=NSOrderedAscending)
    {
        return YES;
    }else {
        return NO;
    }
}

+ (NSString *)mjy_changedata:(NSData *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;

}


+ (NSString *)timeStrChangetoinv:(NSString *)timeStr {
  
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (timeStr.length == 7) {
        [formatter setDateFormat:@"YYYY-MM"];
    }
    else if (timeStr.length == 10) {
        [formatter setDateFormat:@"YYYY-MM-dd"];
    } else
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"]; // ----------设置你想要的格式,hh与      HH的区别:分别表示12小时制,24小时制
    
    NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    
    return  timeSp;
}


+ (NSDate *)mjy_changedataStr:(NSString *)dateStr {
    if (!dateStr.length) {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateStr.length == 10 ? @"YYYY-MM-dd": @"YYYY-MM-dd HH:mm"];
    NSDate* date = [formatter dateFromString:dateStr];
    return date;
}

#define SPDiv 10000
#define SPUnit @[@"分", @"角"]
#define SPLowScale @[@"",@"拾", @"佰", @"仟"]
#define SPLargeScale @[@"",@"万",@"亿",@"兆"]
#define SPBase @[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"]

+ (NSString *)stringFamatWithCapital:(NSString *)money
{
    if (money && [money doubleValue] > 0.0f) {
        NSMutableString *capital = [[NSMutableString alloc]init];
        NSString *formatString = [NSString stringWithFormat:@"%.2f",[money doubleValue]];
        NSString *par_int = [formatString substringToIndex:formatString.length - 3];
        NSString *par_dig = [formatString substringFromIndex:formatString.length - 2];
        
        BOOL isZero = ([par_int integerValue] == 0);
        capital = [self moneyInteger:par_int];
        [capital appendString:[self moneyDecimal:par_dig isZeroInt:isZero]];
        //    if ([capital isEqualToString:@"元整"]) {
        //        capital = [NSMutableString stringWithString:@"零元整"];
        //    }
        
        return capital;
    }
    else
        return @"零元整";
}


//金额小数部分转换
+ (NSString *)moneyDecimal:(NSString *)par_dig isZeroInt:(BOOL)isZero
{
    NSMutableString *dec = [[NSMutableString alloc]init];
    NSInteger dig = [par_dig integerValue];
    if (dig == 0) {
        [dec appendString:@"元整"];
    }
    else {
        if (!isZero) {
            [dec appendString:@"元"];
        }
        //0.01 is 壹分
        NSString *temp = [NSString stringWithFormat:@"%li",(long)dig];
        if (dig % 10 != 0) {
            for (NSInteger i = 0; i < temp.length; i++) {
                [dec appendString:SPBase[[[temp substringWithRange:NSMakeRange(i, 1)]integerValue]]];
                [dec appendString:SPUnit[temp.length - 1 -i]];
            }
        }
        else {
            [dec appendString:SPBase[[[temp substringWithRange:NSMakeRange(0, 1)]integerValue]]];
            [dec appendString:SPUnit[1]];
        }
        
    }
    return dec;
}

+ (NSMutableString *)moneyInteger:(NSString *)par_int
{
    NSMutableString *capital = [[NSMutableString alloc]init];
    NSInteger count = -1;
    NSMutableArray *items = [NSMutableArray array];
    NSInteger lenth = par_int.length;
    long long int val_int = [par_int longLongValue];
    
    while (lenth > 0) {
        NSInteger tem = val_int % SPDiv;
        [items addObject:[NSString stringWithFormat:@"%li",(long)tem]];
        val_int = val_int / SPDiv;
        lenth -= 4;
        count ++;
    }
    //    NSLog(@"%@",items);
    for (NSInteger i = count; i >= 0; i --) {
        NSString *str = items[i];
        NSInteger zeroCount = 0;
        BOOL shouldZero = count > 0 && str.length < 4 && i < count;
        for (NSInteger j = 0; j < str.length; j ++) {
            NSInteger k = [[str substringWithRange:NSMakeRange(j, 1)]integerValue];
            if (k != 0) {
                if (zeroCount != 0 || shouldZero) {
                    [capital appendString:SPBase[0]];
                    zeroCount = 0;
                    shouldZero = NO;
                }
                [capital appendString:SPBase[k]];
                [capital appendString:SPLowScale[str.length - 1 - j]];
            }
            else {
                zeroCount ++;
            }
        }
        if ([str integerValue] != 0) {
            [capital appendString:SPLargeScale[i]];
        }
    }
    return capital;
}


+ (NSArray *)filePathFromSdcacheWith:(NSArray *)pics {
    
    NSMutableArray *imageArr = @[].mutableCopy;

    
    for (NSString *str  in pics) {
        if ([str containsString:@"png"] || [str containsString:@"jpg"] || [str containsString:@"jpeg"] || [str containsString:@"gif"] || [str containsString:@"bmp"]||[str hasSuffix:@"."]) {
           
        } else {
            [imageArr addObject:str];

        }
        
    }
    
    //此方法会先从memory中取。
    return imageArr;
}

+ (NSArray *)imageFromSdcacheWith:(NSArray *)pics {
    
    NSMutableArray *imageArr = @[].mutableCopy;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    SDImageCache* cache = [SDImageCache sharedImageCache];
    
    for (NSString *str  in pics) {
        if ([str containsString:@"png"] || [str containsString:@"jpg"] || [str containsString:@"jpeg"] || [str containsString:@"gif"] || [str containsString:@"bmp"]||[str hasSuffix:@"."]) {
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",Base_IP , str];
            NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:urlStr]];
            [imageArr addObject:[cache imageFromDiskCacheForKey:key]];
        }
        
    }
    
    //此方法会先从memory中取。
    return imageArr;
    
    
    //    [[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL URLWithString:imgUrl] completion:^(BOOL isInCache) {
    //        NSData*imageData =nil;
    //        if (isInCache) {
    //            NSString *cacheImageKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:imgUrl]];
    //
    //            if(cacheImageKey.length) {
    //
    //                NSString*cacheImagePath = [[SDImageCache sharedImageCache] defaultCachePathForKey:cacheImageKey];
    //
    //                if(cacheImagePath.length) {
    //
    //                    imageData = [NSData dataWithContentsOfFile:cacheImagePath];
    //
    //                }
    //
    //            }
    //        }
    //        if (!imageData) {
    //            imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
    //        }
    //        UIImage*image = [UIImage imageWithData:imageData];
    //
    //        block(image);
    //    }];
    
}


+ (UIViewController *)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}



@end
