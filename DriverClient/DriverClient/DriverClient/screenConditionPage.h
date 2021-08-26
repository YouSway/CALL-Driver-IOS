//
//  screenConditionPage.h
//  driver
//
//  Created by 倪志鹏 on 16/3/29.
//  Copyright © 2016年 倪志鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZHPickView.h"

@interface screenConditionPage : UIViewController<ZHPickViewDelegate,UITextFieldDelegate>{
    
}

@property(nonatomic,strong)ZHPickView *pickview;


@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UILabel *chooseLocation;
@property (strong, nonatomic) IBOutlet UILabel *chooseRange;

@end
