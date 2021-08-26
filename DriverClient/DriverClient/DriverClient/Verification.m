//
//  Verification.m
//  DriverClient
//
//  Created by YouSway on 2016/7/2.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "Registered.h"
#import "style.h"
#import "Verification.h"
#import "Cydia.h"
#import "APIController.h"
#import "MBProgressHUD.h"
#import "UIView+Toast.h"
@interface Verification ()
@property int n ;
@property int n2 ;
@property int n3 ;
@property int n4 ;
@property int second;

@end

@implementation Verification

- (void)viewDidLoad {
    
    self.title = @"驗證碼";
    
    self.navigationController.navigationBar.barTintColor = title_bgcolor;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = floor_bgcolor;
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIImage *navImg=[UIImage imageNamed:@"arrows.png"];
    int navBtnWdith=40;
    int navBtnHeight=40;
    UIGraphicsBeginImageContext(CGSizeMake(navBtnWdith, navBtnHeight));
    [navImg drawInRect:CGRectMake(0, 0, navBtnWdith, navBtnHeight)];
    UIImage *resizeImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIBarButtonItem *navLeftbtn=[[UIBarButtonItem alloc]initWithImage:resizeImage
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(backBtnPressed)];
    
    self.navigationItem.leftBarButtonItem = navLeftbtn;

    
    self.n2 = 0;
    self.n3 = 0;
    self.n4 = 0;
    //倒數...計時   ＾＾
    self.n = 60;
    self.second = 60;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(printN:) userInfo:nil repeats:YES];
    
    
    [self verification];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


-(void)verification{
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    
    UILabel *article = [[UILabel alloc] initWithFrame:CGRectMake(width*0.2,90,width*0.6,50)];
    article.backgroundColor = [UIColor clearColor];
    article.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    article.text = @"請輸入4碼簡訊驗證碼";
    article.textAlignment = UITextAlignmentCenter;
    article.textColor = font_titleColor;
    [self.view addSubview:article];
    
    
    verificationField = [[UITextField alloc] initWithFrame:CGRectMake(width*0.1,article.frame.origin.y+article.frame.size.height+30,width*0.8,70)];
    verificationField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [verificationField setFont:[UIFont fontWithName:@"Helvetica" size:25]];
    verificationField.layer.cornerRadius = 5;
    verificationField.backgroundColor = [UIColor whiteColor];
    verificationField.delegate = self;
    verificationField.returnKeyType = UIReturnKeyDone;
    verificationField.leftViewMode = UITextFieldViewModeAlways;
    verificationField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    verificationField.textAlignment = UITextAlignmentCenter;
    [verificationField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:verificationField];
    
    
    timer = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1,verificationField.frame.origin.y+verificationField.frame.size.height+5,width*0.8,20)];
    timer.backgroundColor = [UIColor clearColor];
    timer.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    timer.text = @"驗證碼將於60秒後失效";
    timer.textAlignment = UITextAlignmentCenter;
    timer.textColor = [UIColor grayColor];
    [self.view addSubview:timer];
    
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(width*0.1,timer.frame.origin.y+timer.frame.size.height+20,width*0.8,50);
    confirmBtn.layer.cornerRadius = 5;
    confirmBtn.backgroundColor = button_bgcolor;
    [confirmBtn setTitle:@"確    認" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    
    
    UIButton *againBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    againBtn.frame = CGRectMake(width*0.25,confirmBtn.frame.origin.y+confirmBtn.frame.size.height+10,width*0.5,20);
    againBtn.backgroundColor = [UIColor clearColor];
    againBtn.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [againBtn setTitle:@"沒收到簡訊驗證碼嗎？" forState:UIControlStateNormal];
    [againBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [againBtn addTarget:self action:@selector(again) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:againBtn];
    
    
    
    NSUserDefaults *registeredDefaults = [NSUserDefaults standardUserDefaults];
    NSString *registeredSave = [registeredDefaults valueForKey:@"registeredReg"];
    
    
}

-(void)printN:(NSTimer *)timer60
{
    self.second = self.second - 1;
    self.n = self.n - 1;
    
    NSLog(@"%i",self.n);
    NSLog(@"%i",self.n3);
    if(self.n3 == 1)
    {
        [timer60 invalidate];
    }
    if(self.n4 == 1)
    {
        self.n4 = 0;
        [timer60 invalidate];
    }
    if(self.n == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
        [timer60 invalidate];
    }
    
    NSString *timertext = [NSString stringWithFormat:@"驗證碼將於%i秒後失效", self.n];
    timer.text = timertext;
    [self.view addSubview:timer];
    
    
}

-(void)again{
    
    self.n2 = self.n2 + 1;
    

    if(self.n2 > 5)
    {
        UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"已超過重新發送次數"
                                                         message:@"" // IMPORTANT
                                                        delegate:nil
                                               cancelButtonTitle:NO
                                               otherButtonTitles:@"確    認", nil];
        
        [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
        [prompt show];
    }else
    {
        self.n4 = 1;
        self.n = 60;
        self.second = 60;
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(printN:) userInfo:nil repeats:YES];
        
        UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"簡訊已發送"
                                                         message:@"" // IMPORTANT
                                                        delegate:nil
                                               cancelButtonTitle:NO
                                               otherButtonTitles:@"確    認", nil];
        
        [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
        [prompt show];
        //[prompt release];
    }
    
    
    
}


-(void)confirm{
    
    NSUserDefaults *phoneDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary  *phoneDictionary = [phoneDefaults valueForKey:@"registeredReg"];
    NSString *phoneSave = [phoneDictionary valueForKey:@"phone"];
    NSLog(@"%@",phoneSave);
    
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *phone = phoneSave;
    NSString *token = verificationField.text;
    NSDictionary *dict = @{@"phone":phone,@"token":token};
    NSDictionary *result = [APIController TokenConfirmed:dict];
    NSString *status = [NSString stringWithFormat:@"%@",[result objectForKey:@"status"]];
    if ([status isEqualToString:@"fail"]) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.view makeToast:@"驗證碼輸入錯誤，請重新嘗試！"];
    }else{
        NSLog(@"%@",result);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        UIAlertView *confirmprompt = [[UIAlertView alloc] initWithTitle:@"註冊完成"
                                                                message:@"" // IMPORTANT
                                                               delegate:nil
                                                      cancelButtonTitle:NO
                                                      otherButtonTitles:@"確    認", nil];
        
        [confirmprompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
        [confirmprompt show];
        //[prompt release];
        
        
        NSUserDefaults *registeredDefaults = [NSUserDefaults standardUserDefaults];
        [registeredDefaults removeObjectForKey:@"registeredReg"];
        
        
        self.n3 = 1;
        
        Cydia *nVC = [[Cydia alloc]init];
        //nVC.hidesBottomBarWhenPushed = NO;
        [self.navigationController pushViewController:nVC animated:YES];
    }
    
    
}

-(void)textFieldDone:(UITextField*)textField
{
    [textField resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)backBtnPressed
{
    self.n4 = 1;
    [self.navigationController popViewControllerAnimated:YES];
}

@end


