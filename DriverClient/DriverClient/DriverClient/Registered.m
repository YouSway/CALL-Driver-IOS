//
//  Registered.m
//  DriverClient
//
//  Created by YouSway on 2016/7/1.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "Registered.h"
//#import "UIDefine.h"
#import "CustomView.h"
#import "contrastViewController.h"
#import "Verification.h"
#import "style.h"
#import "PublicController.h"
#import "APIController.h"
#import "MBProgressHUD.h"
#import "UIView+Toast.h"

@interface Registered ()
{
    CustomView *inf;
    int inf_error;
}

@end

@implementation Registered

- (void)viewDidLoad {
    
    self.title = @"會員註冊";
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    inf_error = 2;
    
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
    
    
    
   
    
    
    inf = [[CustomView alloc]initWithFrame:CGRectMake(width/2-160,64 , 320, height*0.4)];
    inf.backgroundColor = [UIColor whiteColor];
    inf.layer.masksToBounds=YES;
    inf.layer.cornerRadius = 5;
    [self.view addSubview:inf];
    
    
    
    UILabel *infname = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*0, inf.frame.size.width/3+10,inf.frame.size.height/5)];
    infname.backgroundColor = [UIColor clearColor];
    infname.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infname.text = @"姓    名：";
    infname.textColor = font_labelTitleColor;
    [inf addSubview:infname];
    
    
    UILabel *infid = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*1, inf.frame.size.width/3+10,inf.frame.size.height/5)];
    infid.backgroundColor = [UIColor clearColor];
    infid.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infid.text = @"身份證字號：";
    infid.textColor = font_labelTitleColor;
    [inf addSubview:infid];
    
    
    UILabel *infphone = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*2, inf.frame.size.width/3+10,inf.frame.size.height/5)];
    infphone.backgroundColor = [UIColor clearColor];
    infphone.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infphone.text = @"手 機 號 碼：";
    infphone.textColor = font_labelTitleColor;
    [inf addSubview:infphone];
    
    
    UILabel *infpasswd = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*3, inf.frame.size.width/3+10,inf.frame.size.height/5)];
    infpasswd.backgroundColor = [UIColor clearColor];
    infpasswd.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infpasswd.text = @"登 入 密 碼：";
    infpasswd.textColor = font_labelTitleColor;
    [inf addSubview:infpasswd];
    
    UILabel *infpasswd2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*4, inf.frame.size.width/3+10,inf.frame.size.height/5)];
    infpasswd2.backgroundColor = [UIColor clearColor];
    infpasswd2.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infpasswd2.text = @"密 碼 確 認：";
    infpasswd2.textColor = font_labelTitleColor;
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
    [nameField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [inf addSubview:nameField];
    
    
    
    idField = [[UITextField alloc] initWithFrame:CGRectMake(inf.frame.size.width/3+15, inf.frame.size.height/5*1, inf.frame.size.width/2.2,inf.frame.size.height/5)];
    idField.keyboardType = UIKeyboardTypeDefault;
    [idField setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    idField.layer.cornerRadius = 5;
    idField.backgroundColor = [UIColor clearColor];
    idField.delegate = self;
    idField.returnKeyType = UIReturnKeyDone;
    idField.leftViewMode = UITextFieldViewModeAlways;
    idField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [idField addTarget:self action:@selector(textFieldidcheck:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [inf addSubview:idField];
    
    
    id_error = [[UIImageView alloc] initWithFrame: CGRectMake(idField.frame.origin.x+idField.frame.size.width+10,idField.frame.origin.y+20,20,20)];
    [id_error setBackgroundColor: [UIColor clearColor]];
    [id_error setImage:[UIImage imageNamed:@""]];
    [inf addSubview: id_error];
    
    
    
    phoneField = [[UITextField alloc] initWithFrame:CGRectMake(inf.frame.size.width/3+15, inf.frame.size.height/5*2, inf.frame.size.width/2.2,inf.frame.size.height/5)];
    phoneField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [phoneField setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    phoneField.layer.cornerRadius = 5;
    phoneField.backgroundColor = [UIColor clearColor];
    phoneField.delegate = self;
    phoneField.returnKeyType = UIReturnKeyDone;
    phoneField.leftViewMode = UITextFieldViewModeAlways;
    phoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [phoneField addTarget:self action:@selector(textFieldphonecheck:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [inf addSubview:phoneField];
    
    
    phone_error = [[UIImageView alloc] initWithFrame: CGRectMake(phoneField.frame.origin.x+phoneField.frame.size.width+10,phoneField.frame.origin.y+20,20,20)];
    [phone_error setBackgroundColor: [UIColor clearColor]];
    [phone_error setImage:[UIImage imageNamed:@""]];
    [inf addSubview: phone_error];
    
    
    passwdField = [[UITextField alloc] initWithFrame:CGRectMake(inf.frame.size.width/3+15, inf.frame.size.height/5*3, inf.frame.size.width/2.2,inf.frame.size.height/5)];
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
    [inf addSubview:passwdField];
    
    
    passwd2Field = [[UITextField alloc] initWithFrame:CGRectMake(inf.frame.size.width/3+15, inf.frame.size.height/5*4, inf.frame.size.width/2.2,inf.frame.size.height/5)];
    passwd2Field.keyboardType = UIKeyboardTypeDefault;
    passwd2Field.secureTextEntry = YES;
    [passwd2Field setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    passwd2Field.layer.cornerRadius = 5;
    passwd2Field.backgroundColor = [UIColor clearColor];
    passwd2Field.delegate = self;
    passwd2Field.returnKeyType = UIReturnKeyDone;
    passwd2Field.leftViewMode = UITextFieldViewModeAlways;
    passwd2Field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [passwd2Field addTarget:self action:@selector(textFieldpasswd2check:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [inf addSubview:passwd2Field];
    
    
    passwd2_error = [[UIImageView alloc] initWithFrame: CGRectMake(passwd2Field.frame.origin.x+passwd2Field.frame.size.width+10,passwd2Field.frame.origin.y+20,20,20)];
    [passwd2_error setBackgroundColor: [UIColor clearColor]];
    [passwd2_error setImage:[UIImage imageNamed:@""]];
    [inf addSubview: passwd2_error];
    
    
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
    agreetext1.textColor = font_labelTitleColor;
    [self.view addSubview:agreetext1];

    
    UIButton *agreetext2 = [UIButton buttonWithType:UIButtonTypeCustom];
    agreetext2.frame = CGRectMake(agreetext1.frame.origin.x+agreetext1.frame.size.width,agreetext1.frame.origin.y,155,agreetext1.frame.size.height);
    agreetext2.backgroundColor = [UIColor clearColor];
    [agreetext2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [agreetext2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [agreetext2 setTitle:@"隱私權政策和會員規則" forState:UIControlStateNormal];
    [agreetext2 addTarget:self action:@selector(rule) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:agreetext2];
    
    
    UIButton *diliverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    diliverBtn.frame = CGRectMake(inf.frame.origin.x, agree.frame.origin.y+agree.frame.size.height+20, inf.frame.size.width, inf.frame.size.height/5);
    diliverBtn.layer.cornerRadius = 5;
    diliverBtn.backgroundColor = button_bgcolor;
    [diliverBtn setTitle:@"傳送驗證碼" forState:UIControlStateNormal];
    [diliverBtn addTarget:self action:@selector(diliver) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:diliverBtn];
    
    
}


- (void)agree:(id)sender {
    // If checked, uncheck and visa versa
    [(UIButton *)sender setSelected:![(UIButton *)sender isSelected]];
    inf_error = 0;
    NSLog(@"同意");
}

-(void)rule{
    
    contrastViewController *nVR = [[contrastViewController alloc]init];
    //nVC.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:nVR animated:YES];
    
}

-(void)diliver{
    
    
    if(inf_error == 2){
        [self.view makeToast:@"資料填寫有誤，請重新確認"];
    }else{
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *name = nameField.text;
        NSString *NID = idField.text;
        NSString *phone = phoneField.text;
        NSString *password = passwdField.text;
        NSString *pass = [PublicController md5:password];
        NSDictionary *dict = @{@"name":name,@"NID":NID,@"phone":phone,@"password":pass};
        NSDictionary *result = [APIController Register:dict];
        NSString *status = [NSString stringWithFormat:@"%@",[result objectForKey:@"status"]];
        if ([status isEqualToString:@"fail"]) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self.view makeToast:@"此手機號碼已註冊過！"];
            NSLog(@"%@",result);
            
        }else{
            NSLog(@"%@",result);
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            //保存若是為驗證後跳出程式用
            NSUserDefaults *registeredDefaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *registeredUser = dict;
            NSDictionary *registeredSave = @{@"phone":[registeredUser objectForKey:@"phone"]};
            [registeredDefaults setObject:registeredSave forKey:@"registeredReg"];
            
            //資料照片用
            NSUserDefaults *phoneDefaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *phoneUser = dict;
            NSDictionary *phoneSave = @{@"phone":[phoneUser objectForKey:@"phone"]};
            [phoneDefaults setObject:phoneSave forKey:@"phoneReg"];
            
            
            
            Verification *nVV = [[Verification alloc]init];
            nVV.hidesBottomBarWhenPushed = NO;
            [self.navigationController pushViewController:nVV animated:YES];
            
        }

    }
    
 
    
}

-(void)textFieldDone:(UITextField*)textField
{
    [textField resignFirstResponder];
}

-(void)textFieldidcheck:(UITextField*)textField
{
    NSString *idch = [PublicController idcheck:idField.text];
    NSLog(@"%@",idch);
    if([idch isEqualToString:@"2"]){
        [id_error setImage:[UIImage imageNamed:@"no_red"]];
        inf_error = 2;
        [inf addSubview: id_error];
    }else{
        [id_error setImage:[UIImage imageNamed:@""]];
        inf_error = 0;
        [inf addSubview: id_error];
    }
    [textField resignFirstResponder];
}

-(void)textFieldphonecheck:(UITextField*)textField
{
    NSString *phonech = [PublicController phonecheck:phoneField.text];
    NSLog(@"%@",phonech);
    if([phonech isEqualToString:@"2"]){
        [phone_error setImage:[UIImage imageNamed:@"no_red"]];
        inf_error = 2;
        [inf addSubview: phone_error];
    }else{
        [phone_error setImage:[UIImage imageNamed:@""]];
        inf_error = 0;
        [inf addSubview: phone_error];
    }
    [textField resignFirstResponder];
}

-(void)textFieldpasswd2check:(UITextField*)textField
{

    if([passwd2Field.text isEqualToString:passwdField.text]){
        [passwd2_error setImage:[UIImage imageNamed:@""]];
        inf_error = 0;
        [inf addSubview: passwd2_error];
    }else{
        [passwd2_error setImage:[UIImage imageNamed:@"no_red"]];
        inf_error = 2;
        [inf addSubview: passwd2_error];
    }
    [textField resignFirstResponder];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    //initData
}


-(void)backBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
