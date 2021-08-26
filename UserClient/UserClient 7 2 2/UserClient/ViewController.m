//
//  ViewController.m
//  UserClient
//
//  Created by user on 2016/7/18.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "ViewController.h"
#import "style.h"
#import "UIDefine.h"
#import "ForgetPasswd.h"
#import "funcChoosePage.h"
#import "Registered.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    [self signin];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)signin{
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    self.navigationController.navigationBar.barTintColor = greenWord;
    self.navigationController.navigationBar.topItem.title = @"登入帳號";
    self.view.backgroundColor = backColor;
    
    UILabel *inf = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, height*0.15 , width-width*0.2, height-height*0.8)];
    [inf setBackgroundColor:[UIColor whiteColor]];
    inf.layer.cornerRadius = 5;
    [self.view addSubview:inf];
    
    
    UILabel *infphone = [[UILabel alloc] initWithFrame:CGRectMake(inf.frame.origin.x+20, inf.frame.origin.y+15 , inf.frame.size.width/4+20,inf.frame.size.height/4)];
    infphone.backgroundColor = [UIColor clearColor];
    infphone.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infphone.text = @"手        機：";
    infphone.textColor = greenWord;
    [self.view addSubview:infphone];
    
    
    UILabel *infpasswd = [[UILabel alloc] initWithFrame:CGRectMake(inf.frame.origin.x+20, inf.frame.origin.y+inf.frame.size.height-50 , inf.frame.size.width/4+20,inf.frame.size.height/4)];
    infpasswd.backgroundColor = [UIColor clearColor];
    infpasswd.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infpasswd.text = @"密        碼：";
    infpasswd.textColor = greenWord;
    [self.view addSubview:infpasswd];
    
    
    phoneField = [[UITextField alloc] initWithFrame:CGRectMake(infphone.frame.origin.x+infphone.frame.size.width, infphone.frame.origin.y, inf.frame.size.width*0.6, inf.frame.size.height/4)];
    phoneField.keyboardType = UIKeyboardTypeDefault;
    [phoneField setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    phoneField.layer.cornerRadius = 5;
    phoneField.backgroundColor = [UIColor clearColor];
    phoneField.delegate = self;
    phoneField.returnKeyType = UIReturnKeyDone;
    phoneField.leftViewMode = UITextFieldViewModeAlways;
    phoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:phoneField];
    
    
    passwdField = [[UITextField alloc] initWithFrame:CGRectMake(infpasswd.frame.origin.x+infpasswd.frame.size.width, infpasswd.frame.origin.y, inf.frame.size.width*0.6, inf.frame.size.height/4)];
    passwdField.keyboardType = UIKeyboardTypeDefault;
    passwdField.secureTextEntry = YES;
    [passwdField setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    passwdField.layer.cornerRadius = 5;
    passwdField.backgroundColor = [UIColor clearColor];
    passwdField.delegate = self;
    passwdField.returnKeyType = UIReturnKeyDone;
    passwdField.leftViewMode = UITextFieldViewModeAlways;
    passwdField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:passwdField];
    
    
    UIButton *passwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    passwdBtn.frame = CGRectMake(infpasswd.frame.origin.x-20, infpasswd.frame.origin.y+55, infpasswd.frame.size.width, infpasswd.frame.size.height);
    passwdBtn.backgroundColor = [UIColor clearColor];
    [passwdBtn setFont:[UIFont fontWithName:@"Helvetica-Oblique" size:15]];
    [passwdBtn setTitleColor:grayWord forState:UIControlStateNormal];
    [passwdBtn setTitle:@"忘記密碼" forState:UIControlStateNormal];
    [passwdBtn addTarget:self action:@selector(passwdforget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:passwdBtn];
    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(inf.frame.origin.x, passwdBtn.frame.origin.y+50, inf.frame.size.width/2-10, inf.frame.size.height/3);
    loginBtn.layer.cornerRadius = 5;
    loginBtn.backgroundColor = greenButton;
    [loginBtn setTitle:@"登      入" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(checkLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(inf.frame.origin.x+loginBtn.frame.size.width+20, passwdBtn.frame.origin.y+50, inf.frame.size.width/2-10, inf.frame.size.height/3);
    registerBtn.layer.cornerRadius = 5;
    registerBtn.backgroundColor = greenButton;
    [registerBtn setTitle:@"註      冊" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(checkregister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
}

-(void)passwdforget{
    
    ForgetPasswd *nVF = [[ForgetPasswd alloc]init];
    //nVC.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:nVF animated:YES];
    
}

-(void)checkLogin{
    
    
    /*UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"登入失敗"
     message:@"抱歉！\n您輸入的手機號碼或密碼有誤。" // IMPORTANT
     delegate:nil
     cancelButtonTitle:NO
     otherButtonTitles:@"確    認", nil];
     
     
     // set place
     [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
     [prompt show];
     //[prompt release]; */
    
    funcChoosePage *main = [[funcChoosePage alloc]init];
    [self.navigationController pushViewController:main animated:YES];
    
    
}

-(void)checkregister{
    
    Registered *nVR = [[Registered alloc]init];
    //nVC.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:nVR animated:YES];
    
}

@end
