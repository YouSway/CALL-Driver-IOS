//
//  Travel.m
//  DriverClient
//
//  Created by YouSway on 2016/7/4.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "Travel.h"
#import "style.h"
#import "funcChoosePage.h"


@interface Travel (){
    
    CGFloat width,height;
    UIImageView *mainView;
    
    NSDictionary *result;
}

@end

@implementation Travel

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = title_bgcolor;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = floor_bgcolor;
    
    
    self.title=@"乘車資訊";
    
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

    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    width = aScreenRect.size.width;
    height = aScreenRect.size.height;
    
    [self travle];
    
    
    //    NSLog(@"%@",result);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)travle{
    
    
    mainView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, width-40, 470)];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.cornerRadius = 5;
    mainView.layer.masksToBounds = YES;
    mainView.userInteractionEnabled = YES;
    [self.view addSubview:mainView];
    
    UILabel *fLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 60)];
    fLabel.text = @"起始位置：";
    fLabel.textColor = font_labelTitleColor;
    [mainView addSubview:fLabel];
    
    UILabel *fcitytown = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, width-160, 60)];
    fcitytown.text = [result objectForKey:@"start_place"];
    fcitytown.textAlignment = NSTextAlignmentLeft;
    [mainView addSubview:fcitytown];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, 59.5, width-80, 1)];
    line.backgroundColor = floor_bgcolor;
    [mainView addSubview:line];
    
    UILabel *tLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 90, 60)];
    tLabel.text = @"終點位置：";
    tLabel.textColor = font_labelTitleColor;
    [mainView addSubview:tLabel];
    
    UILabel *tcitytown = [[UILabel alloc]initWithFrame:CGRectMake(100, 60, width-160, 60)];
    tcitytown.text = [result objectForKey:@"end_place"];
    tcitytown.textAlignment = NSTextAlignmentLeft;
    
    [mainView addSubview:tcitytown];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(20, 119.5, width-80, 1)];
    line2.backgroundColor = floor_bgcolor;
    [mainView addSubview:line2];
    
    UILabel *orderTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 120, 90, 60)];
    orderTimeLabel.text = @"預約時間：";
    orderTimeLabel.textColor = font_labelTitleColor;
    [mainView addSubview:orderTimeLabel];
    
    UILabel *orderTime = [[UILabel alloc]initWithFrame:CGRectMake(100, 120, width-160, 60)];
    orderTime.text = [result objectForKey:@"time"];
    if ([[result objectForKey:@"time"] isEqualToString:@"0000-00-00 00:00:00"]) {
        orderTime.text = @"即時搭車";
    }
    orderTime.textAlignment = NSTextAlignmentLeft;
    
    [mainView addSubview:orderTime];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(20, 179.5, width-80, 1)];
    line3.backgroundColor = floor_bgcolor;
    [mainView addSubview:line3];
    
    UILabel *needLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 180, 90, 60)];
    needLabel.text = @"特殊需求：";
    needLabel.textColor = font_labelTitleColor;
    [mainView addSubview:needLabel];
    
    UILabel *needValue = [[UILabel alloc]initWithFrame:CGRectMake(100, 180, width-160, 60)];
    needValue.text = [result objectForKey:@"requirements"];
    needValue.textAlignment = NSTextAlignmentLeft;
    [mainView addSubview:needValue];
    
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(20, 239.5, width-80, 1)];
    line4.backgroundColor = floor_bgcolor;
    [mainView addSubview:line4];
    
    
    UILabel *annotationLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 240, 90, 60)];
    annotationLabel.text = @"備註：";
    annotationLabel.textColor = font_labelTitleColor;
    [mainView addSubview:annotationLabel];
    
    
    UILabel *annotationLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 300, width-80, 150)];
    annotationLabel2.layer.borderColor = floor_bgcolor.CGColor;
    annotationLabel2.layer.borderWidth = 1.0;
    annotationLabel2.layer.cornerRadius = 5;
    [mainView addSubview:annotationLabel2];
    
    
    //Ｘ註用
    /*UILabel *annotationValue = [[UILabel alloc]initWithFrame:CGRectMake(20, 300, width-80, 150)];
     annotationValue.text = [result objectForKey:@"requirements"];
     annotationValue.textAlignment = NSTextAlignmentLeft;
     [mainView addSubview:annotationValue];*/
    
    

    
}

-(void)backBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
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


