//
//  Instructions.m
//  DriverClient
//
//  Created by YouSway on 2016/7/5.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "Instructions.h"
#import "style.h"
#import "OrderProcessing.h"
#import "Instructions.h"

@interface Instructions ()

@end

@implementation Instructions

- (void)viewDidLoad {
    
    self.title = @"使用說明";
    
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    
    self.navigationController.navigationBar.barTintColor = title_bgcolor;
    self.view.backgroundColor =floor_bgcolor;
    
    UIWebView *rule = [[UIWebView alloc]initWithFrame:CGRectMake(width*0.1, 100 , width*0.8, height*0.75)];
    [self.view addSubview:rule];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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