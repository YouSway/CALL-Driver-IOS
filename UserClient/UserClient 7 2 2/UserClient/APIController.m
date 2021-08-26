//
//  APIController.m
//  userClient
//
//  Created by 胡陞銘 on 2016/4/21.
//  Copyright (c) 2016年 倪志鹏. All rights reserved.
//

//==================================================
//  1.authenticate = User身分認證
//  2.Register = User註冊 < customer/driver/dealer >
//  3.tokenConfirmed = SMS認證
//  4.select_driver_role = 選擇司機身分 < 1/2/3 >
//  5.upload_credentials = 上傳證件
//
//  6.order_list = 司機看單
//  7.get_order = 接單 < 有分people和item >
//  8.order_info = 乘客訂單詳細 < 有分people和item >
//  9.order_doing_list = 未完成訂單 < 有分people和item >
//  10.order_history = 訂單紀錄
//  11.order_done = 訂單處理-完成訂單 < 有分people和item >
//  12.order_cancel = 訂單處理-取消訂單 < 有分people和item >
//  13.upload_item_order_photo = 上傳貨單
//  14.change_price_confirm	= 修改價錢確認
//
//  15.list_people_authenticate = 載人特殊需求List
//  16.list_item_authenticate = 載貨特殊需求List
//  17.list_airport_authenticate = 機場列表
//  18.list_wharf_authenticate = 碼頭列表
//==================================================
//

#import "APIController.h"

//http://ubox.templar-develop.com/api
//http://udriver.templar-develop.com/api
#define PublicIP ("http://udriver.templar-develop.com/api") //ServerIP
#define NetworkError (@"網路連線錯誤")

@implementation APIController

//NSDictionary *dict = @{@"phone":@"0970330301",@"password":@"123456"};
+(NSDictionary *)Authenticate:(NSDictionary *)data{
    NSDictionary *returnDct;
    NSDictionary *dict = data;
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/authenticate",PublicIP]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": NetworkError};
        }
    }
    return returnDct;
}

//NSDictionary *dict = @{@"name":@"Hanks",@"NID":@"B122030303",@"phone":@"0970330301",@"password":@"123456",@"type":@"customer"};
+(NSDictionary *)Register:(NSDictionary *)data{
    NSDictionary *returnDct;
    NSDictionary *dict = data;
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/register",PublicIP]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": @"網路連線錯誤"};
        }
    }
    return returnDct;
}

//NSDictionary *dict = @{@"phone":@"0970330301",@"token":@"123456"};
+(NSDictionary *)TokenConfirmed:(NSDictionary *)data{
    NSDictionary *returnDct;
    NSDictionary *dict = data;
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/tokenConfirmed",PublicIP]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": @"網路連線錯誤"};
        }
    }
    return returnDct;
}

//NSDictionary *dict = @{@"user_id":@"使用者",@"role":@"1"};
+(NSDictionary *)Select_driver_role:(NSDictionary *)data{
    NSDictionary *returnDct;
    NSDictionary *dict = data;
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/select_driver_role",PublicIP]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": @"網路連線錯誤"};
        }
    }
    return returnDct;
}

//NSDictionary *dict = @{@"user_id":@"使用者",@"credentials_photo1":@"photo1",@"credentials_photo2":@"photo2",@"credentials_photo3":@"photo3",@"credentials_photo4":@"photo4",@"credentials_photo5":@"photo5"};
+(NSDictionary *)Upload_credentials:(NSDictionary *)data{
    NSDictionary *returnDct;
    NSDictionary *dict = data;
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/upload_credentials",PublicIP]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": @"網路連線錯誤"};
        }
    }
    return returnDct;
}

//NSDictionary *dict = @{@"user_id":@"1",@"lat":@"0970330301",@"long":@"123456",@"dist":@"公里",@"start_time":@"2015-12-16 10:18:14",@"end_time":@"2015-12-17 10:18:14",@"start_place":@"台中科技大學"};
+(NSDictionary *)Order_list:(NSDictionary *)data option:(NSString *)option{
    NSDictionary *returnDct;
    NSDictionary *dict = data;
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/order_list/%@",PublicIP,option]];
            NSLog(@"%@",url);
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": @"網路連線錯誤"};
        }
    }
    return returnDct;
}

//NSDictionary *dict = @{@"user_id":@"使用者"};
+(NSDictionary *)Get_order:(NSDictionary *)data type:(NSString *)type order_id:(NSString *)order_id{
    NSDictionary *returnDct;
    NSDictionary *dict = data;
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/get_order/%@/%@",PublicIP,type,order_id]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": @"網路連線錯誤"};
        }
    }
    return returnDct;
}

//NSDictionary *dict = @{};
+(NSDictionary *)Order_info:(NSString *)type order_id:(NSString *)order_id{
    NSDictionary *returnDct;
    NSDictionary *dict = @{};
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/order_info/%@/%@",PublicIP,type,order_id]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": @"網路連線錯誤"};
        }
    }
    return returnDct;
}

//NSDictionary *dict = @{@"user_id":@"使用者"};
+(NSDictionary *)Order_doing_list:(NSDictionary *)data{
    NSDictionary *returnDct;
    NSDictionary *dict = data;
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/order_doing",PublicIP]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil && returnData.length>0) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": @"網路連線錯誤"};
        }
    }
    return returnDct;
}

//NSDictionary *dict = @{@"uid":@"使用者",@"date":@"2016-04-19"};
+(NSDictionary *)Order_history:(NSDictionary *)data{
    NSDictionary *returnDct;
    NSDictionary *dict = data;
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/order_history",PublicIP]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": @"網路連線錯誤"};
        }
    }
    return returnDct;
}

//NSDictionary *dict = @{};
+(NSDictionary *)Order_done:(NSDictionary *)data{
    NSDictionary *returnDct;
    NSDictionary *dict = data;
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/order_done/{type}/{order_id}",PublicIP]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": @"網路連線錯誤"};
        }
    }
    return returnDct;
}

//NSDictionary *dict = @{};
+(NSDictionary *)Order_cancel:(NSDictionary *)data{
    NSDictionary *returnDct;
    NSDictionary *dict = data;
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/order_cancel/{type}/{order_id}",PublicIP]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": @"網路連線錯誤"};
        }
    }
    return returnDct;
}

//NSDictionary *dict = @{@"item_photo3":@"photo3"};
+(NSDictionary *)Upload_item_order_photo:(NSDictionary *)data{
    NSDictionary *returnDct;
    NSDictionary *dict = data;
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/upload_item_order_photo/{order_id}",PublicIP]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": @"網路連線錯誤"};
        }
    }
    return returnDct;
}

//NSDictionary *dict = @{};
+(NSDictionary *)Change_price_confirm:(NSDictionary *)data{
    NSDictionary *returnDct;
    NSDictionary *dict = data;
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/change_price_confirm/{order_id}",PublicIP]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": @"網路連線錯誤"};
        }
    }
    return returnDct;
}

//NSDictionary *dict = @{};
+(NSDictionary *)List_people_authenticate:(NSDictionary *)data{
    NSDictionary *returnDct;
    NSDictionary *dict = data;
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/people_requirements",PublicIP]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": @"網路連線錯誤"};
        }
    }
    return returnDct;
}

//NSDictionary *dict = @{};
+(NSDictionary *)List_item_authenticate:(NSDictionary *)data{
    NSDictionary *returnDct;
    NSDictionary *dict = data;
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/item_requirements",PublicIP]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": @"網路連線錯誤"};
        }
    }
    return returnDct;
}

//NSDictionary *dict = @{};
+(NSDictionary *)List_airport_authenticate:(NSDictionary *)data{
    NSDictionary *returnDct;
    NSDictionary *dict = data;
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/airport_list",PublicIP]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": @"網路連線錯誤"};
        }
    }
    return returnDct;
}

//NSDictionary *dict = @{};
+(NSDictionary *)List_wharf_authenticate:(NSDictionary *)data{
    NSDictionary *returnDct;
    NSDictionary *dict = data;
    NSError *error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (json != nil && error == nil) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/wharf_list",PublicIP]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody: json];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if (error == nil) {
                returnDct = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
                return returnDct;
            }
            returnDct = @{@"status": @"fail",@"error_message": @"網路連線錯誤"};
        }
    }
    return returnDct;
}

@end
