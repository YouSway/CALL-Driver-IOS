//
//  ViewController.m
//  DriverClient
//
//  Created by YouSway on 2016/7/1.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "ViewController.h"
//#import "UIDefine.h"
#import "ForgetPasswd.h"
#import "funcChoosePage.h"
#import "Verification.h"
#import "Registered.h"
#import "style.h"
#import "UIView+Toast.h"
#import "MBProgressHUD.h"
#import "APIController.h"
#import "PublicController.h"
@interface ViewController ()
{
    UILabel *infphone;
    UILabel *infpasswd;
}

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

    self.navigationController.navigationBar.barTintColor = title_bgcolor;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = floor_bgcolor;
    self.navigationController.navigationBar.topItem.title = @"登入帳號";
    
    
    UILabel *inf = [[UILabel alloc] initWithFrame:CGRectMake(aScreenRect.size.width/2-160, 60 , 320, 120)];
    [inf setBackgroundColor:[UIColor whiteColor]];
    inf.layer.masksToBounds=YES;
    inf.layer.cornerRadius = 5;
    [self.view addSubview:inf];
    
    
    infphone = [[UILabel alloc] initWithFrame:CGRectMake(inf.frame.origin.x+20, inf.frame.origin.y+15 , inf.frame.size.width/4+20,inf.frame.size.height/4)];
    infphone.backgroundColor = [UIColor clearColor];
    infphone.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infphone.text = @"手        機：";
    infphone.textColor = font_labelTitleColor;
    
    [self.view addSubview:infphone];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(width/2-140,infphone.frame.origin.y+45,280,1.5)];
    lineView.backgroundColor = floor_bgcolor;
    [self.view addSubview:lineView];
    
    
    
    infpasswd = [[UILabel alloc] initWithFrame:CGRectMake(inf.frame.origin.x+20, inf.frame.origin.y+inf.frame.size.height-45 , inf.frame.size.width/4+20,inf.frame.size.height/4)];
    infpasswd.backgroundColor = [UIColor clearColor];
    infpasswd.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infpasswd.text = @"密        碼：";
    infpasswd.textColor = font_labelTitleColor;
    [self.view addSubview:infpasswd];
    
    
    phoneField = [[UITextField alloc] initWithFrame:CGRectMake(infphone.frame.origin.x+infphone.frame.size.width, infphone.frame.origin.y, inf.frame.size.width*0.6, inf.frame.size.height/4)];
    phoneField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [phoneField setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    phoneField.layer.cornerRadius = 5;
    phoneField.backgroundColor = [UIColor clearColor];
    phoneField.delegate = self;
    phoneField.returnKeyType = UIReturnKeyDone;
    phoneField.leftViewMode = UITextFieldViewModeAlways;
    phoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [phoneField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
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
    [passwdField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:passwdField];
    
    
    UIButton *passwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    passwdBtn.frame = CGRectMake(infpasswd.frame.origin.x-20, infpasswd.frame.origin.y+55, infpasswd.frame.size.width, infpasswd.frame.size.height);
    passwdBtn.backgroundColor = [UIColor clearColor];
    [passwdBtn setFont:[UIFont fontWithName:@"Helvetica-Oblique" size:15]];
    //[passwdBtn setTitleColor:grayWord forState:UIControlStateNormal];
    [passwdBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [passwdBtn setTitle:@"忘記密碼" forState:UIControlStateNormal];
    [passwdBtn addTarget:self action:@selector(passwdforget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:passwdBtn];
    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(inf.frame.origin.x, passwdBtn.frame.origin.y+50, inf.frame.size.width/2-10, inf.frame.size.height/3);
    loginBtn.layer.cornerRadius = 5;
    loginBtn.backgroundColor = button_bgcolor;
    [loginBtn setTitle:@"登      入" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(checkLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(inf.frame.origin.x+loginBtn.frame.size.width+20, passwdBtn.frame.origin.y+50, inf.frame.size.width/2-10, inf.frame.size.height/3);
    registerBtn.layer.cornerRadius = 5;
    registerBtn.backgroundColor = button_bgcolor;
    [registerBtn setTitle:@"註      冊" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(checkregister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    //若前次註冊未輸入驗證碼轉跳頁面
    NSUserDefaults *registeredDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *registeredSave = [registeredDefaults valueForKey:@"registeredReg"];
    
    if(registeredSave){
    
        Verification *nVV = [[Verification alloc]init];
        [self.navigationController pushViewController:nVV animated:NO];
        
    }
    


}

-(void)passwdforget{
    
    ForgetPasswd *nVF = [[ForgetPasswd alloc]init];
    //nVC.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:nVF animated:YES];
    
}


-(void)checkLogin{

    
    @try {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *phone = phoneField.text;
        NSString *password = passwdField.text;
        NSString *pass = [PublicController md5:password];
        //NSDictionary *dict = @{@"phone":@"0970330301",@"password":@"123456"};
        NSDictionary *dict = @{@"phone":phone,@"password":pass};
        NSDictionary *result = [APIController Login:dict];
        NSString *status = [NSString stringWithFormat:@"%@",[result objectForKey:@"status"]];
        if ([status isEqualToString:@"fail"]) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSLog(@"%@",result);
            [self.view makeToast:@"電話或密碼輸入錯誤！"];
        }else{
            NSLog(@"%@",result);
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *user = [result objectForKey:@"user"];
            
            //看d_type空值
            NSString *d_type;
            if([user valueForKey:@"driver_type"] == [NSNull null]){
                d_type =@"0";
            }else{
                d_type = [user valueForKey:@"driver_type"];
            }
            
            
            //看car_type空值
            NSString *car_info;
            if(([user valueForKey:@"car_business_id"] == [NSNull null])||([user valueForKey:@"car_cc"] == [NSNull null])||([user valueForKey:@"car_name"] == [NSNull null])||([user valueForKey:@"car_number"] == [NSNull null])||([user valueForKey:@"car_year"] == [NSNull null])){
                car_info = @"0";
            }else{
                car_info = @"1";
            }
            
            
            
            //看photo空值
            NSString *info_photo;
            if([[user valueForKey:@"credentials_photo1_status"] isEqualToString:@"success"]&&[[user valueForKey:@"credentials_photo2_status"] isEqualToString:@"success"]&&[[user valueForKey:@"credentials_photo3_status"] isEqualToString:@"success"]&&[[user valueForKey:@"credentials_photo4_status"] isEqualToString:@"success"]&&[[user valueForKey:@"credentials_photo5_status"] isEqualToString:@"success"]){
                info_photo = @"1";
            }else if([[user valueForKey:@"credentials_photo1_status"] isEqualToString:@"checking"]||[[user valueForKey:@"credentials_photo2_status"] isEqualToString:@"checking"]||[[user valueForKey:@"credentials_photo3_status"] isEqualToString:@"checking"]||[[user valueForKey:@"credentials_photo4_status"] isEqualToString:@"checking"]||[[user valueForKey:@"credentials_photo5_status"] isEqualToString:@"checking"]){
                info_photo = @"2";
            }else{
                info_photo = @"0";
            }
            
            
            
            NSDictionary *dictSave = @{@"name":[user objectForKey:@"name"],@"NID":[user objectForKey:@"NID"],@"phone":[user objectForKey:@"phone"],@"password":[PublicController md5:password],@"driver_type":d_type,@"car_info":car_info,@"info_photo":info_photo};
            NSLog(@"%@",dictSave);
            [userDefaults setObject:dictSave forKey:@"userReg"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            NSUserDefaults *phoneDefaults = [NSUserDefaults standardUserDefaults];
            [phoneDefaults removeObjectForKey:@"phoneReg"];
            
            
            funcChoosePage *nVF = [[funcChoosePage alloc]init];
            [self.navigationController pushViewController:nVF animated:YES];
        }
        
    } @catch (NSException *exception) {
        
        [self.view makeToast:@"伺服器異常，請稍候再試！"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
        
    } @finally {
        

        
    }
    

    
}

-(void)checkregister{
    
    Registered *nVR = [[Registered alloc]init];
    //nVC.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:nVR animated:YES];
    
}

-(void)textFieldDone:(UITextField*)textField
{
    [textField resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"登入帳號";
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = left;
    self.navigationController.navigationBar.hidden=NO;
    //initData
}

-(void)viewWillDisappear:(BOOL)animated{
    //self.navigationController.navigationBar.hidden=YES;
}

-(void)back{}

@end
