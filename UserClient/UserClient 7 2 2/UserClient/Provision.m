//
//  Provision.m
//  DriverClient
//
//  Created by YouSway on 2016/7/2.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "Provision.h"
#import "UIDefine.h"

@interface Provision ()

@end

@implementation Provision

- (void)viewDidLoad {
    
    self.title = @"會員條款";

    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    
    self.navigationController.navigationBar.barTintColor = greenWord;
    self.view.backgroundColor = backColor;
    
    UIWebView *rule = [[UIWebView alloc]initWithFrame:CGRectMake(width*0.1, 100 , width*0.8, height*0.75)];
    [self.view addSubview:rule];

    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end