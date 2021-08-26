//
//  ForgetPasswd.m
//  DriverClient
//
//  Created by YouSway on 2016/7/1.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "ForgetPasswd.h"
#import "UIDefine.h"

@interface ForgetPasswd ()

@end

@implementation ForgetPasswd

- (void)viewDidLoad {
    
    self.title = @"忘記密碼";
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    [self Forget];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Forget{
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    self.navigationController.navigationBar.barTintColor = greenWord;
    self.view.backgroundColor = backColor;
    
    
    UILabel *nonsense = [[UILabel alloc] initWithFrame:CGRectMake(width*0.25, 60, width*0.5, height-height*0.9)];
    nonsense.backgroundColor = [UIColor clearColor];
    nonsense.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    nonsense.textAlignment = UITextAlignmentCenter;
    nonsense.text = @"以簡訊傳送新密碼";
    nonsense.textColor = grayWord;
    [self.view addSubview:nonsense];
    
    
    
    UILabel *inf = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, nonsense.frame.origin.y+nonsense.frame.size.height+10 , width-width*0.2, height-height*0.8)];
    [inf setBackgroundColor:[UIColor whiteColor]];
    inf.layer.cornerRadius = 5;
    [self.view addSubview:inf];
    
    
    UILabel *infphone = [[UILabel alloc] initWithFrame:CGRectMake(inf.frame.origin.x+20, inf.frame.origin.y+15 , inf.frame.size.width/4+25,inf.frame.size.height/4)];
    infphone.backgroundColor = [UIColor clearColor];
    infphone.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infphone.text = @"手         機：";
    infphone.textColor = greenWord;
    [self.view addSubview:infphone];
    
    
    UILabel *infpasswd = [[UILabel alloc] initWithFrame:CGRectMake(inf.frame.origin.x+20, inf.frame.origin.y+inf.frame.size.height-50 , inf.frame.size.width/4+25,inf.frame.size.height/4)];
    infpasswd.backgroundColor = [UIColor clearColor];
    infpasswd.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infpasswd.text = @"身   份   證：";
    infpasswd.textColor = greenWord;
    [self.view addSubview:infpasswd];
    
    
    phoneField = [[UITextField alloc] initWithFrame:CGRectMake(infphone.frame.origin.x+infphone.frame.size.width-5, infphone.frame.origin.y, inf.frame.size.width*0.6, inf.frame.size.height/4)];
    phoneField.keyboardType = UIKeyboardTypeDefault;
    [phoneField setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    phoneField.layer.cornerRadius = 5;
    phoneField.backgroundColor = [UIColor clearColor];
    phoneField.delegate = self;
    phoneField.returnKeyType = UIReturnKeyDone;
    phoneField.leftViewMode = UITextFieldViewModeAlways;
    phoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:phoneField];
    
    
    idField = [[UITextField alloc] initWithFrame:CGRectMake(infpasswd.frame.origin.x+infpasswd.frame.size.width-5, infpasswd.frame.origin.y, inf.frame.size.width*0.6, inf.frame.size.height/4)];
    idField.keyboardType = UIKeyboardTypeDefault;
    idField.secureTextEntry = YES;
    [idField setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    idField.layer.cornerRadius = 5;
    idField.backgroundColor = [UIColor clearColor];
    idField.delegate = self;
    idField.returnKeyType = UIReturnKeyDone;
    idField.leftViewMode = UITextFieldViewModeAlways;
    idField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:idField];
    
    
    UIButton *diliverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    diliverBtn.frame = CGRectMake(inf.frame.origin.x, inf.frame.origin.y+inf.frame.size.height+20, inf.frame.size.width, inf.frame.size.height/3);
    diliverBtn.layer.cornerRadius = 5;
    diliverBtn.backgroundColor = greenButton;
    [diliverBtn setTitle:@"傳送新密碼" forState:UIControlStateNormal];
    [diliverBtn addTarget:self action:@selector(diliver) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:diliverBtn];
    
    
}

-(void)diliver{
}

@end

