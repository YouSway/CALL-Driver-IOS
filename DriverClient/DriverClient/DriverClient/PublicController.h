//
//  PublicController.h
//  userClient
//
//  Created by 胡陞銘 on 2016/4/21.
//  Copyright (c) 2016年 倪志鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PublicController : NSObject

//pssword
+(NSString *)md5:(NSString *)str;


//idcheck
+(NSString *)idcheck:(NSString *)str;

//phonecheck
+(NSString *)phonecheck:(NSString *)str;


#pragma base64
+(NSString *)encodeToBase64String:(UIImage *)image;
+(UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;

@end
