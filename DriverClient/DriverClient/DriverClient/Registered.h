//
//  Registered.h
//  DriverClient
//
//  Created by YouSway on 2016/7/1.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Registered : UIViewController<UITextFieldDelegate>{
    UITextField *phoneField,*idField,*passwd2Field,*passwdField,*nameField;
    UIImageView *phone_error,*id_error,*passwd2_error;
    
}


@end
