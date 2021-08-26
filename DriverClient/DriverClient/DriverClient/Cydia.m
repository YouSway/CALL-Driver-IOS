//
//  Cydia.m
//  DriverClient
//
//  Created by YouSway on 2016/7/2.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "Registered.h"
#import "style.h"
#import "InfLog.h"
#import "Cydia.h"
#import "MBProgressHUD.h"
#import "APIController.h"


@interface Cydia (){

    NSString *n;
    NSString *phoneSave;
    
}



@end

@implementation Cydia

- (void)viewDidLoad {
    
    self.title = @"選擇身份";
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = title_bgcolor;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = floor_bgcolor;
    
    
    NSUserDefaults *phoneDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary  *phoneDictionary = [phoneDefaults valueForKey:@"phoneReg"];
    
    if(phoneDictionary)
    {
        self.navigationItem.hidesBackButton = YES;
    }else
    {
        self.navigationItem.hidesBackButton = NO;
    }
    
    
    
    n = @"0";
    [self verification];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


-(void)verification{
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    
    UILabel *article = [[UILabel alloc] initWithFrame:CGRectMake(width*0.2,40,width*0.6,30)];
    article.backgroundColor = [UIColor clearColor];
    article.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    article.text = @"選擇註冊身份";
    article.textAlignment = UITextAlignmentCenter;
    article.textColor = font_titleColor;
    [self.view addSubview:article];
    
    
    UILabel *article2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1,article.frame.origin.y+article.frame.size.height,width*0.8,50)];
    article2.backgroundColor = [UIColor clearColor];
    article2.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    article2.text = @"每個手機號碼只能註冊一種身份";
    article2.textAlignment = UITextAlignmentCenter;
    article2.textColor = [UIColor grayColor];
    [self.view addSubview:article2];
    

    
    UIButton *taxiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    taxiBtn.frame = CGRectMake(width*0.1,article2.frame.origin.y+article2.frame.size.height+20,width*0.8,height/8);
    taxiBtn.layer.cornerRadius = 5;
    taxiBtn.backgroundColor = button_bgcolor;
    [taxiBtn setTitle:@"計程車司機" forState:UIControlStateNormal];
    [taxiBtn addTarget:self action:@selector(taxi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:taxiBtn];
    
    
    UIButton *truckBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    truckBtn.frame = CGRectMake(width*0.1,taxiBtn.frame.origin.y+taxiBtn.frame.size.height+20,width*0.8,height/8);
    truckBtn.layer.cornerRadius = 5;
    truckBtn.backgroundColor = button_bgcolor;
    [truckBtn setTitle:@"貨車司機" forState:UIControlStateNormal];
    [truckBtn addTarget:self action:@selector(truck) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:truckBtn];
    
    
    UIButton *cargoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cargoBtn.frame = CGRectMake(width*0.1,truckBtn.frame.origin.y+truckBtn.frame.size.height+20,width*0.8,height/8);
    cargoBtn.layer.cornerRadius = 5;
    cargoBtn.backgroundColor = button_bgcolor;
    [cargoBtn setTitle:@"貨櫃車司機" forState:UIControlStateNormal];
    [cargoBtn addTarget:self action:@selector(cargo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cargoBtn];
    
    
    
}


-(void)taxi{

    n = @"1";
    [self send];
    
}

-(void)truck{
    
    n = @"2";
    [self send];
    
}

-(void)cargo{
    
    n = @"3";
    [self send];
}

-(void)send{

    
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
    NSString *driver_type = n;
    NSDictionary *dict = @{@"phone":phone,@"driver_type":driver_type};
    NSDictionary *result = [APIController Select_driver_role:dict];
    NSString *status = [NSString stringWithFormat:@"%@",[result objectForKey:@"status"]];
    if ([status isEqualToString:@"fail"]) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }else{
        
        NSLog(@"%@",result);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        InfLog *nVI = [[InfLog alloc]init];
        //nVC.hidesBottomBarWhenPushed = NO;
        [self.navigationController pushViewController:nVI animated:YES];
        
    }
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    //initData
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

