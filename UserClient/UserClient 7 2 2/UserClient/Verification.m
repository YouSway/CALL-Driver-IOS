//
//  Verification.m
//  DriverClient
//
//  Created by YouSway on 2016/7/2.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "Registered.h"
#import "UIDefine.h"
#import "Verification.h"


@interface Verification ()
@property int n ;
@property int second;

@end

@implementation Verification

- (void)viewDidLoad {
    
    self.title = @"驗證幹";
    
    self.navigationController.navigationBar.barTintColor = greenWord;
    self.view.backgroundColor = backColor;
    
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
    article.text = @"請輸入4幹簡訊驗證幹";
    article.textAlignment = UITextAlignmentCenter;
    article.textColor = greenWord;
    [self.view addSubview:article];
    
    
    UITextField *verificationField = [[UITextField alloc] initWithFrame:CGRectMake(width*0.1,article.frame.origin.y+article.frame.size.height+30,width*0.8,70)];
    verificationField.keyboardType = UIKeyboardTypeDefault;
    [verificationField setFont:[UIFont fontWithName:@"Helvetica" size:25]];
    verificationField.layer.cornerRadius = 5;
    verificationField.backgroundColor = [UIColor whiteColor];
    verificationField.delegate = self;
    verificationField.returnKeyType = UIReturnKeyDone;
    verificationField.leftViewMode = UITextFieldViewModeAlways;
    verificationField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    verificationField.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:verificationField];
    
    
    timer = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1,verificationField.frame.origin.y+verificationField.frame.size.height+5,width*0.8,20)];
    timer.backgroundColor = [UIColor clearColor];
    timer.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    timer.text = @"驗證幹將於60幹後失效";
    timer.textAlignment = UITextAlignmentCenter;
    timer.textColor = grayWord;
    [self.view addSubview:timer];
    
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(width*0.1,timer.frame.origin.y+timer.frame.size.height+20,width*0.8,50);
    confirmBtn.layer.cornerRadius = 5;
    confirmBtn.backgroundColor = greenButton;
    [confirmBtn setTitle:@"確    認" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    
    
    UIButton *againBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    againBtn.frame = CGRectMake(width*0.25,confirmBtn.frame.origin.y+confirmBtn.frame.size.height+10,width*0.5,20);
    againBtn.backgroundColor = [UIColor clearColor];
    againBtn.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [againBtn setTitle:@"幹收到簡訊驗證幹幹？" forState:UIControlStateNormal];
    [againBtn setTitleColor:grayWord forState:UIControlStateNormal];
    [againBtn addTarget:self action:@selector(again) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:againBtn];
    
    
}

-(void)printN:(NSTimer *)timer60
{
    self.second = self.second - 1;
    if(self.second == 0)
    {
        [timer60 invalidate];
    }
    NSLog(@"%i",self.n);
    self.n = self.n - 1;
    
    NSString *timertext = [NSString stringWithFormat:@"驗證幹將於%i幹後失效", self.n];
    timer.text = timertext;
    [self.view addSubview:timer];
    
    
}

-(void)again{

    
    UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"簡訊已幹送"
                                                     message:@"" // IMPORTANT
                                                    delegate:nil
                                           cancelButtonTitle:NO
                                           otherButtonTitles:@"確    認", nil];
    
    [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
    [prompt show];
    //[prompt release];
    
}


-(void)confirm{
    
    
    UIAlertView *confirmprompt = [[UIAlertView alloc] initWithTitle:@"註冊完成"
                                                     message:@"" // IMPORTANT
                                                    delegate:nil
                                           cancelButtonTitle:NO
                                           otherButtonTitles:@"確    認", nil];
    
    [confirmprompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
    [confirmprompt show];
    //[prompt release];
    

    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
