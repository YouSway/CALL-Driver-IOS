//
//  PublicController.m
//  userClient
//
//  Created by 胡陞銘 on 2016/4/21.
//  Copyright (c) 2016年 倪志鹏. All rights reserved.
//

#import "PublicController.h"
#import <CommonCrypto/CommonDigest.h>

@implementation PublicController


//ＭＤ5
+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

//驗證身Ｘ證字號
+(NSString *)idcheck:(NSString *)idstr
{
    NSString *check;
    const char *idc;
    char no[26]={10,11,12,13,14,15,16,17,0,18,19,20,21,22,0,23,24,25,26,27,28,29,32,30,31,33};
    int value[11];
    int y=0;
    int i;
    idc = [idstr UTF8String];
    
    value[0]=(no[idc[0]-65])/10;
    value[1]=(no[idc[0]-65])%10;
    for (i=1;i<10;i++)
    {
        value[i+1]=idc[i]-48;//ASCII->int
    }
    for (i=1;i<10;i++)
    {
        y += value[i]*(10-i);
    }
    
    y += (value[0]+value[10]);
    
    if (y%10==0)
    {
        if(strlen(idc)<10 || strlen(idc)>10){
            check = @"2";
        }else{
            check = @"1";
        }
        
    }
    else
    {
        check = @"2";
    }
    
    
    return check;
}


//驗證手機號碼
+(NSString *)phonecheck:(NSString *)phstr
{
    NSString *check;
    const char *phonec;
    phonec = [phstr UTF8String];
    
    
    if(strlen(phonec)<10 || strlen(phonec)>10){
        check = @"2";
    }else{
        
        if(phonec[0] == 48 && phonec[1] == 57){
            check = @"1";
        }else{
            check = @"2";
        }
    }
    
    
    return check;
}



//圖Ｘ轉換
#pragma base64
+(NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+(UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

@end
