//
//  TaxiSpecialVIew.h
//  UserClient
//
//  Created by DSL on 2016/7/24.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TaxiSpecialVIew;
@protocol TaxiSpecialVIewDelegate <NSObject>

//some method

@end
@interface TaxiSpecialVIew : UIView

@property(nonatomic)id<TaxiSpecialVIewDelegate>DataSource;
-(void)setTaxiSpecialVIew;

@end
