//
//  QuoteAudit.m
//  DriverClient
//
//  Created by YouSway on 2016/7/15.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "QuoteAudit.h"
#import "UIDefine.h"
#import "funcChoosePage.h"
#import "style.h"

@interface QuoteAudit (){
    
    CGFloat width,height;
    UIScrollView *mainView;
    
    NSDictionary *result;
}

@end

@implementation QuoteAudit

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:backColor];
    self.navigationController.navigationBar.barTintColor = greenWord;
    self.title = @"等待審核";
    self.navigationController.navigationBar.hidden=NO;
    
    /*
     self.navigationController.navigationBar.barTintColor = title_bgcolor;
     self.navigationController.navigationBar.translucent = NO;
     self.view.backgroundColor = floor_bgcolor;
     */
    
    
    //取消按紐
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = right;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    width = aScreenRect.size.width;
    height = aScreenRect.size.height;
    
    [self quoteaudit];
    
    //    NSLog(@"%@",result);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)quoteaudit{
    
    UILabel *article = [[UILabel alloc] initWithFrame:CGRectMake(width*0.2,90,width*0.6,80)];
    article.backgroundColor = [UIColor clearColor];
    article.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    article.text = @"您的報價已提供\n等待客戶審核中";
    article.textAlignment = UITextAlignmentCenter;
    article.textColor = font_titleColor;
    [self.view addSubview:article];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    //initData
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}

@end

