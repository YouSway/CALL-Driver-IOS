//
//  contrastViewController.m
//  driverClient
//
//  Created by DSL on 2016/7/4.
//  Copyright © 2016年 黃柏鈞. All rights reserved.
//

//dc06-1
#import "contrastViewController.h"
#import "style.h"
@interface contrastViewController ()

@end

@implementation contrastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=floor_bgcolor;
    self.navigationController.navigationBar.barTintColor = title_bgcolor;
    self.navigationController.navigationBar.translucent = NO;
    
    
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

    
    self.navigationItem.title=@"會員條款";
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    
    UIWebView *mainGround=[[UIWebView alloc]init];
    mainGround.backgroundColor=[UIColor whiteColor];
    [mainGround setFrame:CGRectMake(20, 20, aScreenRect.size.width-40, aScreenRect.size.height-120)];
    mainGround.layer.masksToBounds=YES;
    mainGround.layer.cornerRadius=5;
    [self.view addSubview:mainGround];
    
    NSString *urlNameInString = @"https://tw.yahoo.com";
    NSURL *url = [NSURL URLWithString:urlNameInString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [mainGround loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
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

-(void)backBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}




@end
