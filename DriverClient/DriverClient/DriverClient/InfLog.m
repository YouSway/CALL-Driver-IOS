//
//  InfLog.m
//  DriverClient
//
//  Created by YouSway on 2016/7/3.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "InfLog.h"
#import "style.h"
#import "CustomView.h"
#import "Credentials.h"
#import "Cydia.h"
#import "MBProgressHUD.h"
#import "APIController.h"
#import "UIView+Toast.h"

@interface InfLog (){
    
    NSString *phoneSave;
    
}

@end

@implementation InfLog

- (void)viewDidLoad {
    
    self.title = @"司機登錄";
    
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

    
    //完成按紐
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(complete)];
    self.navigationItem.rightBarButtonItem = right;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];

    
    
    [self inflog];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)inflog{
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    
    
    
    UILabel *infcar = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, 20, width*0.8,40)];
    infcar.backgroundColor = [UIColor clearColor];
    infcar.layer.cornerRadius = 5;
    infcar.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    infcar.text = @"  車籍資料";
    infcar.textColor =font_titleColor2;
    [self.view addSubview:infcar];
    
    
    CustomView *inf = [[CustomView alloc]initWithFrame:CGRectMake(width*0.1,infcar.frame.origin.y+infcar.frame.size.height , width*0.8, height*0.4)];
    inf.backgroundColor = [UIColor clearColor];
    inf.layer.cornerRadius = 5;
    [self.view addSubview:inf];
    
    
    
    UILabel *infplant = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*0, inf.frame.size.width/3+20,inf.frame.size.height/5)];
    infplant.backgroundColor = [UIColor clearColor];
    infplant.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infplant.text = @"廠牌名稱：";
    infplant.textColor = font_labelTitleColor;
    [inf addSubview:infplant];
    
    
    UILabel *infid = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*1, inf.frame.size.width/3+20,inf.frame.size.height/5)];
    infid.backgroundColor = [UIColor clearColor];
    infid.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infid.text = @"車種排氣量：";
    infid.textColor = font_labelTitleColor;
    [inf addSubview:infid];
    
    
    UILabel *infphone = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*2, inf.frame.size.width/3+20,inf.frame.size.height/5)];
    infphone.backgroundColor = [UIColor clearColor];
    infphone.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infphone.text = @"車種出廠年份：";
    infphone.textColor = font_labelTitleColor;
    [inf addSubview:infphone];
    
    
    UILabel *infpasswd = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*3, inf.frame.size.width/3+20,inf.frame.size.height/5)];
    infpasswd.backgroundColor = [UIColor clearColor];
    infpasswd.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infpasswd.text = @"車牌號碼：";
    infpasswd.textColor = font_labelTitleColor;
    [inf addSubview:infpasswd];
    
    UILabel *infpasswd2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*4, inf.frame.size.width/3+20,inf.frame.size.height/5)];
    infpasswd2.backgroundColor = [UIColor clearColor];
    infpasswd2.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infpasswd2.text = @"營業證號：";
    infpasswd2.textColor = font_labelTitleColor;
    [inf addSubview:infpasswd2];
    
    
    plantField = [[UITextField alloc] initWithFrame:CGRectMake(inf.frame.size.width/3+30, inf.frame.size.height/5*0, inf.frame.size.width/2,inf.frame.size.height/5)];
    plantField.keyboardType = UIKeyboardTypeDefault;
    [plantField setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    plantField.layer.cornerRadius = 5;
    plantField.backgroundColor = [UIColor clearColor];
    plantField.delegate = self;
    plantField.returnKeyType = UIReturnKeyDone;
    plantField.leftViewMode = UITextFieldViewModeAlways;
    plantField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [plantField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [inf addSubview:plantField];
    
    ccField = [[UITextField alloc] initWithFrame:CGRectMake(inf.frame.size.width/3+30, inf.frame.size.height/5*1, inf.frame.size.width/2,inf.frame.size.height/5)];
    ccField.keyboardType = UIKeyboardTypeDefault;
    ccField.secureTextEntry = YES;
    [ccField setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    ccField.layer.cornerRadius = 5;
    ccField.backgroundColor = [UIColor clearColor];
    ccField.delegate = self;
    ccField.returnKeyType = UIReturnKeyDone;
    ccField.leftViewMode = UITextFieldViewModeAlways;
    ccField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [ccField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [inf addSubview:ccField];
    
    yearField = [[UITextField alloc] initWithFrame:CGRectMake(inf.frame.size.width/3+30, inf.frame.size.height/5*2, inf.frame.size.width/2,inf.frame.size.height/5)];
    yearField.keyboardType = UIKeyboardTypeDefault;
    [yearField setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    yearField.layer.cornerRadius = 5;
    yearField.backgroundColor = [UIColor clearColor];
    yearField.delegate = self;
    yearField.returnKeyType = UIReturnKeyDone;
    yearField.leftViewMode = UITextFieldViewModeAlways;
    yearField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [yearField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [inf addSubview:yearField];
    
    numberField = [[UITextField alloc] initWithFrame:CGRectMake(inf.frame.size.width/3+30, inf.frame.size.height/5*3, inf.frame.size.width/2,inf.frame.size.height/5)];
    numberField.keyboardType = UIKeyboardTypeDefault;
    [numberField setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    numberField.layer.cornerRadius = 5;
    numberField.backgroundColor = [UIColor clearColor];
    numberField.delegate = self;
    numberField.returnKeyType = UIReturnKeyDone;
    numberField.leftViewMode = UITextFieldViewModeAlways;
    numberField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [numberField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [inf addSubview:numberField];
    
    
    businessField = [[UITextField alloc] initWithFrame:CGRectMake(inf.frame.size.width/3+30, inf.frame.size.height/5*4, inf.frame.size.width/2,inf.frame.size.height/5)];
    businessField.keyboardType = UIKeyboardTypeDefault;
    [businessField setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    businessField.layer.cornerRadius = 5;
    businessField.backgroundColor = [UIColor clearColor];
    businessField.delegate = self;
    businessField.returnKeyType = UIReturnKeyDone;
    businessField.leftViewMode = UITextFieldViewModeAlways;
    businessField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [businessField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [inf addSubview:businessField];
    

    
    
}

-(void)complete{
    
    NSUserDefaults *phoneDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary  *phoneDictionary = [phoneDefaults valueForKey:@"phoneReg"];
    
    if(phoneDictionary)
    {
        phoneSave = [phoneDictionary valueForKey:@"phone"];
    }else
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary  *dictSave = [userDefaults valueForKey:@"userReg"];
        phoneSave = [dictSave valueForKey:@"phone"];
    }
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *phone = phoneSave;
    NSString *car_name = plantField.text;
    NSString *car_cc = ccField.text;
    NSString *car_year = yearField.text;
    NSString *car_number = numberField.text;
    NSString *car_business_id = businessField.text;

    NSDictionary *dict = @{@"phone":phone,@"car_name":car_name,@"car_cc":car_cc,@"car_year":car_year,@"car_number":car_number,@"car_business_id":car_business_id};
    NSDictionary *result = [APIController InsertDriverInfo:dict];
    NSString *status = [NSString stringWithFormat:@"%@",[result objectForKey:@"status"]];
    if ([status isEqualToString:@"fail"]) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.view makeToast:@"資料有誤，請重新確認！"];
    }else{
        NSLog(@"%@",result);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        Credentials *nVC = [[Credentials alloc]init];
        //nVC.hidesBottomBarWhenPushed = NO;
        [self.navigationController pushViewController:nVC animated:YES];
        
    }
    

}

-(void)textFieldDone:(UITextField*)textField
{
    [textField resignFirstResponder];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    //initData
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}

-(void)backBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
