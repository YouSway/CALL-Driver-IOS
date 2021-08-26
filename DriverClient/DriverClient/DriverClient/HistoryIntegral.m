//
//  HistoryIntegral.m
//  DriverClient
//
//  Created by YouSway on 2016/8/6.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "HistoryIntegral.h"
#import "Integral.h"
#import "style.h"
@interface HistoryIntegral (){
    
    UIScrollView* scrollView;
}

@end

@implementation HistoryIntegral

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=floor_bgcolor;
    self.navigationController.navigationBar.barTintColor = title_bgcolor;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title=@"積分紀錄";
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    
    
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
    
    
    
    //多少東西
    int tableValue=50;
    int tableHeight=50;
    
    
    //滑滑滑
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor = floor_bgcolor;
    scrollView.scrollEnabled = YES;
    int scHeight=tableValue*tableHeight+200;//螢幕最小長度
    if (self.view.frame.size.height<scHeight) {
        scHeight=scHeight;
    }
    else{
        scHeight=self.view.frame.size.height;
    }
    
    scrollView.contentSize = CGSizeMake(320, scHeight);
    //scrollView.backgroundColor=[UIColor redColor];
    //NSLog(@"%f",self.view.bounds.size.height);
    [self.view addSubview:scrollView];
    
    
    //打底
    
    UILabel *mainForm=[[UILabel alloc]init];
    [mainForm setFrame:CGRectMake(aScreenRect.size.width/2-160, 40, 320, tableHeight*tableValue+15)];
    mainForm.backgroundColor=[UIColor whiteColor];
    mainForm.layer.masksToBounds = YES;
    mainForm.layer.cornerRadius=5;
    [scrollView addSubview:mainForm];
    
    
    
    for (int i=0; i<tableValue; i++) {
        
        UILabel *passengerSay=[[UILabel alloc]init];
        [passengerSay setFrame:CGRectMake(mainForm.frame.origin.x, 20+i*tableHeight, 320, 20)];
        passengerSay.backgroundColor=[UIColor whiteColor];
        passengerSay.text=@"等待資料中";
        [mainForm addSubview:passengerSay];
        
        
        
        if(i>0){
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(mainForm.frame.size.width/2-(320-40)/2,passengerSay.frame.origin.y-15, 320-40, 1)];
            lineView.backgroundColor = floor_bgcolor;
            [mainForm addSubview:lineView];
        }
        
    }
    
    
    
}

-(void)backBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
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

@end