//
//  PJRSignatureView.h
//  DriverClient
//
//  Created by YouSway on 2016/7/26.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJRSignatureView : UIView
{
    UILabel *lblSignature;
    CAShapeLayer *shapeLayer;
}

- (UIImage *)getSignatureImage;
- (void)clearSignature;



@end