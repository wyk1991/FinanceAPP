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



/**  -----------  login and register  --------   */
#define register @"register"
#define verify @"verify"

#define k_login_type @"login"
#define k_login_out @"logout"



#endif /* URLMacro_h */
