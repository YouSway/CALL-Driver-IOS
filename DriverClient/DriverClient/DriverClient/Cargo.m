//
//  Cargo.m
//  DriverClient
//
//  Created by YouSway on 2016/7/4.
//  Copyright © 2016年 YouSway. All rights reserved.
//
#import "style.h"
#import "Cargo.h"
#import "UIDefine.h"
#import "funcChoosePage.h"

@interface Cargo (){
    
    CGFloat width,height;
    UIScrollView *mainView;
    
    NSDictionary *result;
}

@end

@implementation Cargo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:backColor];
//    self.navigationController.navigationBar.barTintColor = greenWord;
//    self.title = @"貨物資訊";
//    self.navigationController.navigationBar.hidden=NO;
    
    self.view.backgroundColor=floor_bgcolor;
    self.navigationController.navigationBar.barTintColor = title_bgcolor;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title=@"貨物資訊";
    
    /*
    self.navigationController.navigationBar.barTintColor = title_bgcolor;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = floor_bgcolor;
     */
    
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
    
    
    mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(20, 20, width-40, height*0.8)];
    [mainView setContentSize:CGSizeMake(width-40, 1450)];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.cornerRadius = 5;
    mainView.layer.masksToBounds = YES;
    mainView.userInteractionEnabled = YES;
    [self.view addSubview:mainView];
    
    UILabel *fLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 60)];
    fLabel.text = @"付款方：";
    fLabel.textColor = orangeWord;
    [mainView addSubview:fLabel];
    
    UILabel *fcitytown = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, width-160, 60)];
    fcitytown.text = [result objectForKey:@"start_place"];
    fcitytown.textAlignment = NSTextAlignmentLeft;
    [mainView addSubview:fcitytown];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, 59.5, width-80, 1)];
    line.backgroundColor = backColor;
    [mainView addSubview:line];
    
    UILabel *receiverLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 100, 60)];
    receiverLabel.text = @"收貨人姓名：";
    receiverLabel.textColor = greenWord;
    [mainView addSubview:receiverLabel];
    
    UILabel *receiver = [[UILabel alloc]initWithFrame:CGRectMake(100, 60, width-160, 60)];
    receiver.text = [result objectForKey:@"end_place"];
    receiver.textAlignment = NSTextAlignmentLeft;
    [mainView addSubview:receiver];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(20, 119.5, width-80, 1)];
    line2.backgroundColor = backColor;
    [mainView addSubview:line2];
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 120, 90, 60)];
    phoneLabel.text = @"電話：";
    phoneLabel.textColor = greenWord;
    [mainView addSubview:phoneLabel];
    
    UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(100, 120, width-160, 60)];
    phone.text = [result objectForKey:@"time"];
    if ([[result objectForKey:@"time"] isEqualToString:@"0000-00-00 00:00:00"]) {
       phone.text = @"即時搭車";
    }
    phone.textAlignment = NSTextAlignmentLeft;
    
    [mainView addSubview:phone];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(20, 179.5, width-80, 1)];
    line3.backgroundColor = backColor;
    [mainView addSubview:line3];
    
    UILabel *startingLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 180, 90, 60)];
    startingLabel.text = @"起始位置：";
    startingLabel.textColor = greenWord;
    [mainView addSubview:startingLabel];
    
    UILabel *startingValue = [[UILabel alloc]initWithFrame:CGRectMake(100, 180, width-160, 60)];
    startingValue.text = [result objectForKey:@"requirements"];
    startingValue.textAlignment = NSTextAlignmentLeft;
    [mainView addSubview:startingValue];
    
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(20, 239.5, width-80, 1)];
    line4.backgroundColor = backColor;
    [mainView addSubview:line4];
    
    
    UILabel *annotationLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 240, 90, 60)];
    annotationLabel.text = @"終點位置：";
    annotationLabel.textColor = greenWord;
    [mainView addSubview:annotationLabel];
    
    UILabel *tcitytown = [[UILabel alloc]initWithFrame:CGRectMake(100, 240, width-160, 60)];
    tcitytown.text = [result objectForKey:@"end_place"];
    tcitytown.textAlignment = NSTextAlignmentLeft;
    
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(20, 299.5, width-80, 1)];
    line5.backgroundColor = backColor;
    [mainView addSubview:line5];
    
    
    UILabel *reservationLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 300, 90, 60)];
    reservationLabel.text = @"預約時間：";
    reservationLabel.textColor = greenWord;
    [mainView addSubview:reservationLabel];
    
    UILabel *reservation = [[UILabel alloc]initWithFrame:CGRectMake(100, 300, width-160, 60)];
    reservation.text = [result objectForKey:@"end_place"];
    reservation.textAlignment = NSTextAlignmentLeft;
    
    
    UIView *line6 = [[UIView alloc]initWithFrame:CGRectMake(20, 359.5, width-80, 1)];
    line6.backgroundColor = backColor;
    [mainView addSubview:line6];
    
    
    UILabel *merchandiseLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 360, 90, 60)];
    merchandiseLabel.text = @"貨物內容：";
    merchandiseLabel.textColor = greenWord;
    [mainView addSubview:merchandiseLabel];
    
    UILabel *merchandise = [[UILabel alloc]initWithFrame:CGRectMake(100, 360, width-160, 60)];
    merchandise.text = [result objectForKey:@"end_place"];
    merchandise.textAlignment = NSTextAlignmentLeft;
    
    
    UIView *line7 = [[UIView alloc]initWithFrame:CGRectMake(20, 419.5, width-80, 1)];
    line7.backgroundColor = backColor;
    [mainView addSubview:line7];
    
    
    UILabel *weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 420, 90, 60)];
    weightLabel.text = @"重        量：";
    weightLabel.textColor = greenWord;
    [mainView addSubview:weightLabel];
    
    UILabel *weight = [[UILabel alloc]initWithFrame:CGRectMake(100, 420, width-160, 60)];
    weight.text = [result objectForKey:@"end_place"];
    weight.textAlignment = NSTextAlignmentLeft;
    
    
    UIView *line8 = [[UIView alloc]initWithFrame:CGRectMake(20, 479.5, width-80, 1)];
    line8.backgroundColor = backColor;
    [mainView addSubview:line8];
    
    
    UILabel *materialLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 480, 90, 60)];
    materialLabel.text = @"才        數：";
    materialLabel.textColor = greenWord;
    [mainView addSubview:materialLabel];
    
    UILabel *material = [[UILabel alloc]initWithFrame:CGRectMake(100, 480, width-160, 60)];
    material.text = [result objectForKey:@"end_place"];
    material.textAlignment = NSTextAlignmentLeft;
    
    
    UIView *line9 = [[UIView alloc]initWithFrame:CGRectMake(20, 539.5, width-80, 1)];
    line9.backgroundColor = backColor;
    [mainView addSubview:line9];
    
    
    
    UILabel *needLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 540, 90, 60)];
    needLabel.text = @"特殊需求：";
    needLabel.textColor = greenWord;
    [mainView addSubview:needLabel];
    
    UILabel *need = [[UILabel alloc]initWithFrame:CGRectMake(100, 540, width-160, 60)];
    need.text = [result objectForKey:@"end_place"];
    need.textAlignment = NSTextAlignmentLeft;
    
    
    UIView *line10 = [[UIView alloc]initWithFrame:CGRectMake(20, 599.5, width-80, 1)];
    line10.backgroundColor = backColor;
    [mainView addSubview:line10];
    
    
    UILabel *bonusLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 600, 90, 60)];
    bonusLabel.text = @"小        費：";
    bonusLabel.textColor = greenWord;
    [mainView addSubview:bonusLabel];
    
    UILabel *bonus = [[UILabel alloc]initWithFrame:CGRectMake(100, 600, width-160, 60)];
    bonus.text = [result objectForKey:@"end_place"];
    bonus.textAlignment = NSTextAlignmentLeft;
    
    
    UIView *line11 = [[UIView alloc]initWithFrame:CGRectMake(20, 659.5, width-80, 1)];
    line11.backgroundColor = backColor;
    [mainView addSubview:line11];
    
    
    UILabel *remarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 660, 90, 60)];
    remarkLabel.text = @"備        註：";
    remarkLabel.textColor = greenWord;
    [mainView addSubview:remarkLabel];
    
    
    UILabel *remark = [[UILabel alloc]initWithFrame:CGRectMake(20, 720, width-80, 150)];
    remark.layer.borderColor = backColor.CGColor;
    remark.layer.borderWidth = 1.0;
    remark.layer.cornerRadius = 5;
    [mainView addSubview:remark];
    
    

    UILabel *remarkValue = [[UILabel alloc]initWithFrame:CGRectMake(20, 720, width-80, 150)];
    remarkValue.text = [result objectForKey:@"requirements"];
    remarkValue.textAlignment = NSTextAlignmentLeft;
    
    
    UILabel *cargopicLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 910, 90, 60)];
    cargopicLabel.text = @"貨物圖片：";
    cargopicLabel.textColor = greenWord;
    [mainView addSubview:cargopicLabel];
    
    
    UIImageView *cargopic1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 970, width-80, 200)];
    cargopic1.layer.cornerRadius = 5;
    cargopic1.backgroundColor = grayWord;
    cargopic1.image = [UIImage imageNamed:@""];
    [mainView addSubview:cargopic1];
    
    
    UIImageView *cargopic2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 1190, width-80, 200)];
    cargopic2.layer.cornerRadius = 5;
    cargopic2.backgroundColor = grayWord;
    cargopic2.image = [UIImage imageNamed:@""];
    [mainView addSubview:cargopic2];
    
    
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

