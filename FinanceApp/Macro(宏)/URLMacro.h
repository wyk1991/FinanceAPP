//
//  URLMacro.h
//  FinanceApp
//
//  Created by SX on 2018/3/13.
//  Copyright © 2018年 wyk. All rights reserved.
//

#ifndef URLMacro_h
#define URLMacro_h

#if DEBUG
    #define Base_IP @"http://118.31.43.148/"

    #define Base_URL @"http://118.31.43.148/"
#else
    #define Base_IP @"http://118.31.43.148/"

    #define Base_URL @"http://118.31.43.148/"
#endif

/** ***          LOGIN AND REGISTER      **********/




/** ***          HOME NEWS               **********/
/** 标签 */
#define tag_list @"category"
/** 幻灯片 */
#define head_line @"headlines"
/** 获取news 数据列表 */
#define newsList @"news"
/** 获取固定头条 */
#define middleAd @"jiliankuaixun"
/** 获取搜索热词 */
#define hotWrod  @"hotsearches"
/** 搜索文章内容 */
#define search_Artical @"search"


/** ***          NEWFLASH               **********/
/**  快讯内容list */
#define newFlashList @"kuaixun"

#define flash_tag @"kuaixun_category"


/**            SITUATION COIN  **************/
#define situation_tag @"coin/popular_coins"

#define situation_coinAllInfo @"coin/allinfo"

#define situation_listCoin @"coin/listcoins"
#define situation_listCoinName @"coin/usercoin_marketlist"

#define situation_optin_list @"coin/usercoin_simple_details"
#define situation_search @"coin/search"

/** 删除自选的选项 */
#define situation_optionDelet @"coin/usercoin_deletecoin"

/** 添加自选交易所选项 */
#define situation_AddOptionList @"coin/usercoin_setcoin"

// 图表货币详情
#define situation_coinDetail(obj)  [NSString stringWithFormat:@"coin/details?coin_name=%@", obj]


/**  -----------  login and register  --------   */
#define myColleciton @"me/collections"

#define verifyTelCode @"me/verify"
#define userRegister @"me/register"

#define user_info @"me/userinfo"

#define userLogin @"me/login"
#define userLoginOut @"me/logout"
/** 修改密码 */
#define update_user_password @"me/update_password"
#define post_user_feedBack @"me/feedbacks"
#define get_feedBack_history @"me/history_feedbacks"
// 修改个人信息
#define modify_user  @"me/update_info"
// 上传用户头像
#define upload_useravator @"me/update_avatar"
// 二维码图片地址
#define jilian_QRurl @"resources/qrcode/qrcode.png"
// 获取个人积分列表
#define get_scoreList @"points/get_list"
// 绑定手机号码
#define binding_userTel @"me/link_phone"

// 获取文章html内容片断
#define new_article_content @"constants/new_article"


#endif /* URLMacro_h */
