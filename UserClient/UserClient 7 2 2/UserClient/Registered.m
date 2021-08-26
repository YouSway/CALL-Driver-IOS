//
//  Registered.m
//  DriverClient
//
//  Created by YouSway on 2016/7/1.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "Registered.h"
#import "UIDefine.h"
#import "CustomView.h"
#import "Provision.h"
#import "Verification.h"

@interface Registered ()

@end

@implementation Registered

- (void)viewDidLoad {
    
    self.title = @"會員註冊";
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    [self Register];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Register{
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    
    self.navigationController.navigationBar.barTintColor = greenWord;
    self.view.backgroundColor = backColor;
    
    
    
    CustomView *inf = [[CustomView alloc]initWithFrame:CGRectMake(width*0.1, 100 , width*0.8, height*0.4)];
    inf.backgroundColor = [UIColor whiteColor];
    inf.layer.cornerRadius = 10;
    [self.view addSubview:inf];
    
    
    
    UILabel *infname = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*0, inf.frame.size.width/3+10,inf.frame.size.height/5)];
    infname.backgroundColor = [UIColor clearColor];
    infname.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infname.text = @"姓    幹：";
    infname.textColor = greenWord;
    [inf addSubview:infname];
    
    
    UILabel *infid = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*1, inf.frame.size.width/3+10,inf.frame.size.height/5)];
    infid.backgroundColor = [UIColor clearColor];
    infid.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infid.text = @"身幹證字號：";
    infid.textColor = greenWord;
    [inf addSubview:infid];
    
    
    UILabel *infphone = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*2, inf.frame.size.width/3+10,inf.frame.size.height/5)];
    infphone.backgroundColor = [UIColor clearColor];
    infphone.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infphone.text = @"手 機 號 幹：";
    infphone.textColor = greenWord;
    [inf addSubview:infphone];
    
    
    UILabel *infpasswd = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*3, inf.frame.size.width/3+10,inf.frame.size.height/5)];
    infpasswd.backgroundColor = [UIColor clearColor];
    infpasswd.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infpasswd.text = @"登 入 幹 幹：";
    infpasswd.textColor = greenWord;
    [inf addSubview:infpasswd];
    
    UILabel *infpasswd2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*4, inf.frame.size.width/3+10,inf.frame.size.height/5)];
    infpasswd2.backgroundColor = [UIColor clearColor];
    infpasswd2.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infpasswd2.text = @"幹 幹 確 認：";
    infpasswd2.textColor = greenWord;
    [inf addSubview:infpasswd2];
    
    
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(inf.frame.size.width/3+15, inf.frame.size.height/5*0, inf.frame.size.width/2.2,inf.frame.size.height/5)];
    nameField.keyboardType = UIKeyboardTypeDefault;
    [nameField setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    nameField.layer.cornerRadius = 5;
    nameField.backgroundColor = [UIColor clearColor];
    nameField.delegate = self;
    nameField.returnKeyType = UIReturnKeyDone;
    nameField.leftViewMode = UITextFieldViewModeAlways;
    nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [inf addSubview:nameField];
    
    idField = [[UITextField alloc] initWithFrame:CGRectMake(inf.frame.size.width/3+15, inf.frame.size.height/5*1, inf.frame.size.width/2.2,inf.frame.size.height/5)];
    idField.keyboardType = UIKeyboardTypeDefault;
    idField.secureTextEntry = YES;
    [idField setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    idField.layer.cornerRadius = 5;
    idField.backgroundColor = [UIColor clearColor];
    idField.delegate = self;
    idField.returnKeyType = UIReturnKeyDone;
    idField.leftViewMode = UITextFieldViewModeAlways;
    idField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [inf addSubview:idField];
    
    phoneField = [[UITextField alloc] initWithFrame:CGRectMake(inf.frame.size.width/3+15, inf.frame.size.height/5*2, inf.frame.size.width/2.2,inf.frame.size.height/5)];
    phoneField.keyboardType = UIKeyboardTypeDefault;
    [phoneField setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    phoneField.layer.cornerRadius = 5;
    phoneField.backgroundColor = [UIColor clearColor];
    phoneField.delegate = self;
    phoneField.returnKeyType = UIReturnKeyDone;
    phoneField.leftViewMode = UITextFieldViewModeAlways;
    phoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [inf addSubview:phoneField];
    
    passwdField = [[UITextField alloc] initWithFrame:CGRectMake(inf.frame.size.width/3+15, inf.frame.size.height/5*3, inf.frame.size.width/2.2,inf.frame.size.height/5)];
    passwdField.keyboardType = UIKeyboardTypeDefault;
    [passwdField setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    passwdField.layer.cornerRadius = 5;
    passwdField.backgroundColor = [UIColor clearColor];
    passwdField.delegate = self;
    passwdField.returnKeyType = UIReturnKeyDone;
    passwdField.leftViewMode = UITextFieldViewModeAlways;
    passwdField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [inf addSubview:passwdField];
    
    
    passwd2Field = [[UITextField alloc] initWithFrame:CGRectMake(inf.frame.size.width/3+15, inf.frame.size.height/5*4, inf.frame.size.width/2.2,inf.frame.size.height/5)];
    passwd2Field.keyboardType = UIKeyboardTypeDefault;
    [passwd2Field setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    passwd2Field.layer.cornerRadius = 5;
    passwd2Field.backgroundColor = [UIColor clearColor];
    passwd2Field.delegate = self;
    passwd2Field.returnKeyType = UIReturnKeyDone;
    passwd2Field.leftViewMode = UITextFieldViewModeAlways;
    passwd2Field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [inf addSubview:passwd2Field];
    
    
    UIButton *agree = [UIButton buttonWithType:UIButtonTypeCustom];
    [agree setFrame:CGRectMake(inf.frame.origin.x+width*0.05,inf.frame.origin.y+inf.frame.size.height+20,20,20)];
    [agree setImage:[UIImage imageNamed:@"select_off"]
              forState:UIControlStateNormal];
    [agree setImage:[UIImage imageNamed:@"select_on"]
              forState:UIControlStateSelected];
    [agree addTarget:self
                 action:@selector(agree:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:agree];
    
    UILabel *agreetext1 = [[UILabel alloc] initWithFrame:CGRectMake(agree.frame.origin.x+agree.frame.size.width+5,agree.frame.origin.y,45,20)];
    agreetext1.backgroundColor = [UIColor clearColor];
    agreetext1.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    agreetext1.text = @"我同意";
    agreetext1.textColor = greenWord;
    [self.view addSubview:agreetext1];

    
    UIButton *agreetext2 = [UIButton buttonWithType:UIButtonTypeCustom];
    agreetext2.frame = CGRectMake(agreetext1.frame.origin.x+agreetext1.frame.size.width,agreetext1.frame.origin.y,155,agreetext1.frame.size.height);
    agreetext2.backgroundColor = [UIColor clearColor];
    [agreetext2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [agreetext2 setTitleColor:grayWord forState:UIControlStateNormal];
    [agreetext2 setTitle:@"隱私權政策和會員規則" forState:UIControlStateNormal];
    [agreetext2 addTarget:self action:@selector(rule) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:agreetext2];
    
    
    UIButton *diliverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    diliverBtn.frame = CGRectMake(inf.frame.origin.x, agree.frame.origin.y+agree.frame.size.height+20, inf.frame.size.width, inf.frame.size.height/5);
    diliverBtn.layer.cornerRadius = 5;
    diliverBtn.backgroundColor = greenButton;
    [diliverBtn setTitle:@"傳送驗證碼" forState:UIControlStateNormal];
    [diliverBtn addTarget:self action:@selector(diliver) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:diliverBtn];
    
    
}


- (void)agree:(id)sender {
    // If checked, uncheck and visa versa
    [(UIButton *)sender setSelected:![(UIButton *)sender isSelected]];
    NSLog(@"同意");
}

-(void)rule{
    
    Provision *nVR = [[Provision alloc]init];
    //nVC.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:nVR animated:YES];
    
}

-(void)diliver{
    
    Verification *nVV = [[Verification alloc]init];
    //nVC.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:nVV animated:YES];
}

@end
