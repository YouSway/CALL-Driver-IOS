//
//  APIController.h
//  userClient
//
//  Created by 胡陞銘 on 2016/4/21.
//  Copyright (c) 2016年 倪志鹏. All rights reserved.
//

//==================================================
//  1.login = User身分認證
//  2.Register = User註冊 < customer/driver/dealer >
//  3.tokenConfirmed = SMS認證
//  4.select_driver_role = 選擇司機身分 < 1/2/3 >
//  5.insertDriverInfo = 司機資訊
//  6.credentialsCheck = 確認開通
//  6.upload_credentials = 上傳證件
//  6.accountCheck = 司機帳號檢查
//  6.passwordChange = 司機變更密碼
//
//  7.order_list = 司機看單
//  8.get_order = 接單 < 有分people和item >
//  9.order_info = 乘客訂單詳細 < 有分people和item >
//  10.order_doing_list = 未完成訂單 < 有分people和item >
//  11.order_history = 訂單紀錄
//  12.order_done = 訂單處理-完成訂單 < 有分people和item >
//  13.order_cancel = 訂單處理-取消訂單 < 有分people和item >
//  14.upload_item_order_photo = 上傳貨單
//  15.change_price_confirm	= 修改價錢確認
//
//  16.list_people_authenticate = 載人特殊需求List
//  17.list_item_authenticate = 載貨特殊需求List
//  18.list_airport_authenticate = 機場列表
//  19.list_wharf_authenticate = 碼頭列表
//==================================================
//

#import <Foundation/Foundation.h>

@interface APIController : NSObject

+(NSDictionary *)Login:(NSDictionary *)data;
+(NSDictionary *)Register:(NSDictionary *)data;
+(NSDictionary *)TokenConfirmed:(NSDictionary *)data;
+(NSDictionary *)Select_driver_role:(NSDictionary *)data;
+(NSDictionary *)InsertDriverInfo:(NSDictionary *)data;
+(NSDictionary *)Upload_credentials:(NSDictionary *)data;
+(NSDictionary *)AccountCheck:(NSDictionary *)data;
+(NSDictionary *)PasswordChange:(NSDictionary *)data;
+(NSDictionary *)CredentialsCheck:(NSDictionary *)data;

+(NSDictionary *)Order_list:(NSDictionary *)data option:(NSString *)option;
+(NSDictionary *)Get_order:(NSDictionary *)data type:(NSString *)type order_id:(NSString *)order_id;
+(NSDictionary *)Order_info:(NSString *)type order_id:(NSString *)order_id;
+(NSDictionary *)Order_doing_list:(NSDictionary *)data;
+(NSDictionary *)Order_history:(NSDictionary *)data;
+(NSDictionary *)Order_done:(NSDictionary *)data;
+(NSDictionary *)Order_cancel:(NSDictionary *)data;
+(NSDictionary *)Upload_item_order_photo:(NSDictionary *)data;
+(NSDictionary *)Change_price_confirm:(NSDictionary *)data;

+(NSDictionary *)List_people_authenticate:(NSDictionary *)data;
+(NSDictionary *)List_item_authenticate:(NSDictionary *)data;
+(NSDictionary *)List_airport_authenticate:(NSDictionary *)data;
+(NSDictionary *)List_wharf_authenticate:(NSDictionary *)data;

@end
