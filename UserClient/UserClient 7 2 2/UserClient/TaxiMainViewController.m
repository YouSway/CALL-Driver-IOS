//
//  TaxiMainViewController.m
//  UserClient
//
//  Created by user on 2016/7/18.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "TaxiMainViewController.h"
#import "TakeGeneralViewController.h"
#import "TKGViewController.h"
#import "funcChoosePage.h"
#import "style.h"

@interface TaxiMainViewController ()<UITableViewDelegate,UITableViewDataSource>{
    float width,height;

    
}
@end

@implementation TaxiMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.viewControllers = [NSArray arrayWithObject: self];
    [self.view setBackgroundColor:floor_bgcolor];
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    width = aScreenRect.size.width;
    height = aScreenRect.size.height;
    
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

    [self.navigationItem setTitle:@"計程車"];
    
    [self service];

    
    
    // Do any additional setup after loading the view.
}


-(void)service{

    
    int advSpace=70;
    
    UIView *adv=[[UIView alloc]init];
    [adv setFrame:CGRectMake(width/2-(width-advSpace)/2, 80, width-advSpace, height*0.4)];
    adv.backgroundColor=[UIColor grayColor];
    [self.view addSubview:adv];
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, adv.frame.origin.y+adv.frame.size.height+25, width-40, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"您好，請選擇需要的服務";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    titleLabel.textColor = font_labelTitleColor;
    [self.view addSubview:titleLabel];
    
    UIButton *serviceBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [serviceBtn1 setFrame:CGRectMake(width*0.1, titleLabel.frame.origin.y+titleLabel.frame.size.height+20, width*0.15, width*0.15)];
    [serviceBtn1 setImage:[UIImage imageNamed:@"realTimeCar"]
                 forState:UIControlStateNormal];
    [serviceBtn1 addTarget:self action:@selector(service1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serviceBtn1];
    
    UIButton *serviceBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [serviceBtn2 setFrame:CGRectMake(serviceBtn1.frame.origin.x+serviceBtn1.frame.size.width+width*0.0666, titleLabel.frame.origin.y+titleLabel.frame.size.height+20, width*0.15, width*0.15)];
    [serviceBtn2 setImage:[UIImage imageNamed:@"realTimeCar"]
                 forState:UIControlStateNormal];
    [serviceBtn2 addTarget:self action:@selector(service2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serviceBtn2];
    
    UIButton *serviceBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [serviceBtn3 setFrame:CGRectMake(serviceBtn2.frame.origin.x+serviceBtn1.frame.size.width+width*0.0666, titleLabel.frame.origin.y+titleLabel.frame.size.height+20, width*0.15, width*0.15)];
    [serviceBtn3 setImage:[UIImage imageNamed:@"airport"]
                 forState:UIControlStateNormal];
    [serviceBtn3 addTarget:self action:@selector(service3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serviceBtn3];
    
    UIButton *serviceBtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [serviceBtn4 setFrame:CGRectMake(serviceBtn3.frame.origin.x+serviceBtn1.frame.size.width+width*0.0666, titleLabel.frame.origin.y+titleLabel.frame.size.height+20, width*0.15, width*0.15)];
    [serviceBtn4 setImage:[UIImage imageNamed:@"realTimeCar"]
                 forState:UIControlStateNormal];
    [serviceBtn4 addTarget:self action:@selector(service4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serviceBtn4];
    

    
}


-(void)service1{

    TKGViewController *nVT = [[TKGViewController alloc]init];
    [self.navigationController pushViewController:nVT animated:YES];
    
}


-(void)service4{

    
}


-(void)backBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    //initData
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
