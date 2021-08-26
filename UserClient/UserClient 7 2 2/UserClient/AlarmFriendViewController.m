//
//  AlarmFriendViewController.m
//  UserClient
//
//  Created by user on 2016/7/23.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "AlarmFriendViewController.h"
#import <MessageUI/MessageUI.h>
#import "DriverRunViewController.h"

#import "UIDefine.h"

#import "TakeGeneralViewController.h"

@interface AlarmFriendViewController ()<MFMessageComposeViewControllerDelegate>{
    CGFloat width,height;
    
    UITextField *phoneField;
    UITextView *smsText;
}

@end

@implementation AlarmFriendViewController

-(void)viewDidLoad{
    [self.view setBackgroundColor:backColor];
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    width = aScreenRect.size.width;
    height = aScreenRect.size.height;
    
    [self setUpBar];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 74, width-40, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"將搭車訊息傳給熟人確保安全";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    titleLabel.textColor = greenWord;
    [self.view addSubview:titleLabel];
    
    UILabel *titleBottom = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.frame.origin.x+20, titleLabel.frame.origin.y+titleLabel.frame.size.height+5, titleLabel.frame.origin.x+titleLabel.frame.size.width-40, 20)];
    titleBottom.textAlignment = NSTextAlignmentCenter;
    titleBottom.text = @"傳送號碼：";
    titleBottom.textColor = greenWord;
    [self.view addSubview:titleBottom];
    
    phoneField = [[UITextField alloc]initWithFrame:CGRectMake(20, titleBottom.frame.origin.y+titleBottom.frame.size.height+5, width-40, 30)];
    phoneField.backgroundColor = [UIColor whiteColor];
    phoneField.layer.cornerRadius = 5;
    phoneField.text = @"";
    phoneField.placeholder = @"請輸入傳送電話號碼";
    phoneField.textAlignment = NSTextAlignmentCenter;
    phoneField.delegate = self;
    phoneField.returnKeyType = UIReturnKeyDone;
    phoneField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:phoneField];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, phoneField.frame.origin.y+phoneField.frame.size.height+20, width-40, 1)];
    line.backgroundColor = RGBACOLOR(132, 132, 132, 1);
    [self.view addSubview:line];
    
    UILabel *smsLabel = [[UILabel alloc]initWithFrame:CGRectMake(line.frame.origin.x+20, line.frame.origin.y+line.frame.size.height+20, line.frame.origin.x+line.frame.size.width-40, 20)];
    smsLabel.textAlignment = NSTextAlignmentCenter;
    smsLabel.text = @"簡訊內容：";
    smsLabel.textColor = greenWord;
    [self.view addSubview:smsLabel];
    
    smsText = [[UITextView alloc]initWithFrame:CGRectMake(20, smsLabel.frame.origin.y+smsLabel.frame.size.height+10, width-40, 80)];
    
    if ([[_listDetail objectForKey:@"time"] isEqualToString:@""]) {
        
        // 获取系统当前时间
        NSDate * date = [NSDate date];
        NSTimeInterval sec = [date timeIntervalSinceNow];
        NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
        
        //设置时间输出格式：
        NSDateFormatter * df = [[NSDateFormatter alloc] init ];
        [df setDateFormat:@"yyyy年MM月dd日 HH小时mm分"];
        NSString * nowDate = [df stringFromDate:currentDate];
        
        smsText.text = [NSString stringWithFormat:@"我在%@搭乘車牌%@，從%@前往%@。",nowDate,[_result objectForKey:@"plate"],[_listDetail objectForKey:@"start_place"],[_listDetail objectForKey:@"end_place"]];
    }else{
        smsText.text = [NSString stringWithFormat:@"我在%@搭乘車牌%@，從%@前往%@。",[_listDetail objectForKey:@"time"],[_result objectForKey:@"plate"],[_listDetail objectForKey:@"start_place"],[_listDetail objectForKey:@"end_place"]];
    }
    
    smsText.font = [UIFont systemFontOfSize:14];
    smsText.layer.cornerRadius = 5;
    smsText.delegate = self;
    smsText.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:smsText];
    
    /*UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton setFrame:CGRectMake(20, smsText.frame.origin.y+smsText.frame.size.height+40, width-40, 40)];
    [sendButton setTitle:@"傳送" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton setBackgroundColor:greenButton];
    sendButton.layer.cornerRadius = 10;
    [sendButton addTarget:self action:@selector(sendSMS) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];*/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendSMS{
    NSLog(@"送出簡訊");
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = smsText.text;
        controller.recipients = [NSArray arrayWithObjects:phoneField.text, nil];
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }else{
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"設備不支援簡訊發送" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
    }
    
    
    //    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

-(void)setUpBar{
    [self.navigationItem setTitle:@"通知熟人"];
    UIBarButtonItem *okButton = [[UIBarButtonItem alloc]initWithTitle:@"送出" style:UIBarButtonItemStylePlain target:self action:@selector(rightDone)];
    self.navigationItem.rightBarButtonItem = okButton;
}

-(void)rightDone{
    //    [self.navigationController popToRootViewControllerAnimated:NO];
    DriverRunViewController *nVD = [[DriverRunViewController alloc]init];
    [self.navigationController pushViewController:nVD animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //    UITouch *touch = [touches anyObject];
    [self textFieldShouldReturn:phoneField];
    [self textViewShouldEndEditing:smsText];
}

#pragma mark - TextView delegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    CGRect frame = textView.frame;
    int offset = frame.origin.y +80 - (self.view.frame.size.height - 250.0);//键盘高度250
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float textWidth = self.view.frame.size.width;
    float textHeight = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,textWidth,textHeight);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}

//按下Done
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0, 0, width, height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textView resignFirstResponder];
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
}

#pragma Textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma SMS
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"錯誤" message:@"簡訊發送失敗" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
        case MessageComposeResultSent:
            [self dismissViewControllerAnimated:YES completion:nil];
            [self rightDone];
            return;
            
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    //initData
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}

@end