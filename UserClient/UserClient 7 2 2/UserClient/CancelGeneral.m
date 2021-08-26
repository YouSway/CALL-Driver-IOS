//
//  CancelGeneral.m
//  UserClient
//
//  Created by YouSway on 2016/7/25.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "DriverRunViewController.h"
#import "UIDefine.h"
#import "pastBillViewController.h"
#import "CancelGeneral.h"


@interface CancelGeneral ()

@end

@implementation CancelGeneral

- (void)viewDidLoad {
    
    self.title = @"取消叫車";
    
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    
    self.navigationController.navigationBar.barTintColor = greenWord;
    self.view.backgroundColor = backColor;
    
    //取消訂單按紐
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"仍要取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = right;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    [self cancelorder];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(void)cancelorder{
    
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    
    UILabel *article = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1,90,width*0.8,50)];
    article.backgroundColor = [UIColor clearColor];
    article.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    article.text = @"請選擇取消叫車的理由";
    article.textAlignment = UITextAlignmentCenter;
    article.textColor = greenWord;
    [self.view addSubview:article];
    
    UILabel *reason = [[UILabel alloc] initWithFrame:CGRectMake(width*0.15,article.frame.origin.y+article.frame.size.height+15,width*0.7,30)];
    reason.backgroundColor = [UIColor whiteColor];
    reason.font = [UIFont fontWithName:@"Helvetica" size:16];
    reason.textAlignment = UITextAlignmentCenter;
    reason.textColor = [UIColor blackColor];
    [self.view addSubview:reason];
    
    
    UILabel *article2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1,reason.frame.origin.y+reason.frame.size.height+20,width*0.8,50)];
    article2.backgroundColor = [UIColor clearColor];
    article2.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    article2.text = @"請留下您的寶貴意見";
    article2.textAlignment = UITextAlignmentCenter;
    article2.textColor = greenWord;
    [self.view addSubview:article2];
    
    
    
    UITextView *opinion = [[UITextView alloc] initWithFrame:CGRectMake(width*0.15,article2.frame.origin.y+article2.frame.size.height,width*0.7,200)];
    opinion.backgroundColor = [UIColor whiteColor];
    opinion.font = [UIFont fontWithName:@"Helvetica" size:16];
    opinion.textColor = [UIColor blackColor];
    [self.view addSubview:opinion];
    
    
}


-(void)cancel{
    
    pastBillViewController *nVP = [[pastBillViewController alloc]init];
    //nVC.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:nVP animated:YES];
    
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
