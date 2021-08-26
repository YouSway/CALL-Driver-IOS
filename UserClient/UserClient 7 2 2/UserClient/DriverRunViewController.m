//
//  DriverRunViewController.m
//  UserClient
//
//  Created by user on 2016/7/23.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "DriverRunViewController.h"
#import "CancelGeneral.h"
#import "AlarmFriendViewController.h"

#import "UIDefine.h"
#import "APIController.h"

#import "TakeGeneralViewController.h"

@interface DriverRunViewController(){
    CGFloat width,height;
    
    UIImageView *call;
    NSDictionary *result;
    
    //checkAlert
    UIImageView *CalertView;
    
    UILabel *driverName,*driverValue,*rangeLabel,*timeLabel,*driverCard,*tipLabel;
    
    UIImageView *mainView;
    UIAlertView *prompt;
}

@end

@implementation DriverRunViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:backColor];
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    width = aScreenRect.size.width;
    height = aScreenRect.size.height;
    
    [self setUpBar];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, width-40, 60)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"稍後，司機正趕來接您";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    titleLabel.textColor = greenWord;
    [self.view addSubview:titleLabel];
    
    
    mainView = [[UIImageView alloc]initWithFrame:CGRectMake(20, titleLabel.frame.origin.y+titleLabel.frame.size.height+10, width-40, 145)];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.cornerRadius = 5;
    mainView.userInteractionEnabled = YES;
    [self.view addSubview:mainView];
    
    UIImageView *driverHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, mainView.frame.size.width/4-20, mainView.frame.size.width/4-20)];
    driverHead.image = [UIImage imageNamed:@"twitter_okabe.jpg"];
    driverHead.layer.cornerRadius = (mainView.frame.size.width/4-20)*0.5;
    driverHead .layer.masksToBounds = YES;
    [mainView addSubview:driverHead];
    
    driverName = [[UILabel alloc]initWithFrame:CGRectMake(driverHead.frame.origin.x+driverHead.frame.size.width+10, driverHead.frame.origin.y+5, 80, 20)];
    driverName.text = @"鳳凰院";
    driverName.textAlignment = NSTextAlignmentLeft;
    driverName.textColor = greenWord;
    driverName.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    [mainView addSubview:driverName];
    
    driverValue = [[UILabel alloc]initWithFrame:CGRectMake(driverHead.frame.origin.x+driverHead.frame.size.width+10, driverName.frame.origin.y+23, 150, 20)];
    driverValue.text = @"車型";
    driverValue.textColor = greenWord;
    driverValue.textAlignment = NSTextAlignmentLeft;
    driverValue.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [mainView addSubview:driverValue];
    
    driverCard = [[UILabel alloc]initWithFrame:CGRectMake(driverHead.frame.origin.x+driverHead.frame.size.width+10, driverValue.frame.origin.y+15, 100, 20)];
    driverCard.text = @"車牌";
    driverCard.textColor = greenWord;
    driverCard.textAlignment = NSTextAlignmentLeft;
    driverCard.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [mainView addSubview:driverCard];
    
        for (int i=0; i<5; i++) {
            UIImageView *star = [[UIImageView alloc]initWithFrame:CGRectMake(driverName.frame.origin.x+driverName.frame.size.width+(i*17), driverName.frame.origin.y , 15, 15)];
            [star setImage:[UIImage imageNamed:@"star"]];
            [mainView addSubview:star];
        }
    
    call = [[UIImageView alloc]initWithFrame:CGRectMake(driverName.frame.origin.x+driverName.frame.size.width+60+45, 10, mainView.frame.size.width/4-20, mainView.frame.size.width/4-20)];
    [call setImage:[UIImage imageNamed:@"phone"]];
    call.userInteractionEnabled = YES;
    [mainView addSubview:call];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, driverHead.frame.origin.y+driverHead.frame.size.height+20, mainView.frame.size.width, 1)];
    line.backgroundColor = backColor;
    [mainView addSubview:line];
    
    rangeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, line.frame.origin.y+11, mainView.frame.size.width/2-10.5, 30)];
    rangeLabel.textAlignment = NSTextAlignmentCenter;
    [mainView addSubview:rangeLabel];
    
    NSMutableAttributedString * rangeText = [[NSMutableAttributedString alloc] initWithString:@""];
    NSString *str1 = @"距您";
    NSString *str2 = @"公里";
    NSString *rangeValue = @"0";
    NSAttributedString *subString = [[NSAttributedString alloc] initWithString:str1 attributes:@{NSForegroundColorAttributeName: greenWord}];
    [rangeText appendAttributedString:subString];
    subString = [[NSAttributedString alloc] initWithString:rangeValue attributes:@{NSForegroundColorAttributeName: greenWord,NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:30]}];
    [rangeText appendAttributedString:subString];
    subString = [[NSAttributedString alloc] initWithString:str2 attributes:@{NSForegroundColorAttributeName: greenWord}];
    [rangeText appendAttributedString:subString];
    [rangeLabel setAttributedText:rangeText];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(mainView.frame.size.width/2-0.5, line.frame.origin.y, 1, mainView.frame.size.height+mainView.frame.size.height-rangeLabel.frame.origin.y)];
    line2.backgroundColor = backColor;
    [mainView addSubview:line2];
    
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainView.frame.size.width/2+1.5, line.frame.origin.y+11, mainView.frame.size.width/2-10.5, 30)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [mainView addSubview:timeLabel];
    
    
    UIButton *driwherebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [driwherebtn setFrame:CGRectMake(mainView.frame.size.width/2-0.5, line.frame.origin.y, mainView.frame.size.width/2, mainView.frame.size.height-line.frame.origin.y)];
    [driwherebtn setTitle:@"司機在哪" forState:UIControlStateNormal];
    [driwherebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [driwherebtn setBackgroundColor:greenButton];
    [driwherebtn addTarget:self action:@selector(driverwhere) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:driwherebtn];
    
    
    UIImageView *tipView = [[UIImageView alloc]initWithFrame:CGRectMake(20, mainView.frame.origin.y+mainView.frame.size.height+5, width-40, 40)];
    tipView.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    [self.view addSubview:tipView];
    
    tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, tipView.frame.size.width-20, 30)];
    tipLabel.text = @"小 費：0元";
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.textColor = [UIColor grayColor];
    [tipView addSubview:tipLabel];
    
    UIImageView *billTypeView = [[UIImageView alloc]initWithFrame:CGRectMake(20, tipView.frame.origin.y+tipView.frame.size.height+5, width-40, 40)];
    billTypeView.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    [self.view addSubview:billTypeView];
    
    UILabel *billLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, tipView.frame.size.width-20, 30)];
    billLabel.text = @"計費方式採跳表收費";
    billLabel.textAlignment = NSTextAlignmentLeft;
    billLabel.textColor = orangeWord;
    billLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [billTypeView addSubview:billLabel];
    
    UIButton *boardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [boardButton setFrame:CGRectMake(20, billTypeView.frame.origin.y+billTypeView.frame.size.height+40, width-40, 50)];
    [boardButton setTitle:@"分享乘車資訊" forState:UIControlStateNormal];
    [boardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [boardButton setBackgroundColor:greenButton];
    boardButton.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    boardButton.layer.cornerRadius = 10;
    [boardButton addTarget:self action:@selector(information) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:boardButton];
    
    
    UIButton *paymentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [paymentButton setFrame:CGRectMake(20, boardButton.frame.origin.y+boardButton.frame.size.height+20, width-40, 50)];
    [paymentButton setTitle:@"線上支付" forState:UIControlStateNormal];
    [paymentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [paymentButton setBackgroundColor:greenButton];
    paymentButton.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    paymentButton.layer.cornerRadius = 10;
    [boardButton addTarget:self action:@selector(onlinepayment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:paymentButton];
    
    dispatch_async(kBgQueue, ^{
        /*result = [APIController Driving:@"people" id:_order_id];
        NSLog(@"司機趕路中 %@",result);
        
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:result waitUntilDone:YES];*/
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpBar{
    [self.navigationItem setTitle:@"司機趕路中"];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"取消叫車" style:UIBarButtonItemStylePlain target:self action:@selector(rightCancel)];
    self.navigationItem.rightBarButtonItem = cancelButton;
    
    UIButton *left=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [left setBackgroundImage:[UIImage imageNamed:@"arrows"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(leftBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithCustomView:left];
    
    self.navigationItem.leftBarButtonItem = backButton;
}

-(void)rightCancel{
    CancelGeneral *nVC = [[CancelGeneral alloc]init];
    [self.navigationController pushViewController:nVC animated:YES];
}

-(void)leftBack{
    TakeGeneralViewController *nVT = [[TakeGeneralViewController alloc]init];
    [self.navigationController pushViewController:nVT animated:NO];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if ([touch view] == call)
    {
        UIAlertView *calert;
        NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[result objectForKey:@"phone"]]];
        if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
            [[UIApplication sharedApplication] openURL:phoneUrl];
        } else
        {
            calert = [[UIAlertView alloc]initWithTitle:@"無法撥打電話" message:@"" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [calert show];
        }
    }
}

- (void)fetchedData:(NSDictionary *)responseData {
    driverName.text = [result objectForKey:@"name"];
    
    NSString *rating = [result objectForKey:@"rating"];
    NSString *order_count = [result objectForKey:@"order_count"];
    
    driverValue.text = [NSString stringWithFormat:@"積分：%@     %@筆",rating,order_count];
    
    driverCard.text = [NSString stringWithFormat:@"%@ %@",[result objectForKey:@"plate"],[result objectForKey:@"car"]];
    
    NSMutableAttributedString * rangeText = [[NSMutableAttributedString alloc] initWithString:@""];
    NSString *str1 = @"距您";
    NSString *str2 = @"公里";
    float distance = [[result objectForKey:@"distance"] floatValue];
    NSAttributedString *subString = [[NSAttributedString alloc] initWithString:str1 attributes:@{NSForegroundColorAttributeName: greenWord}];
    [rangeText appendAttributedString:subString];
    subString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f",distance] attributes:@{NSForegroundColorAttributeName: greenWord,NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:30]}];
    [rangeText appendAttributedString:subString];
    subString = [[NSAttributedString alloc] initWithString:str2 attributes:@{NSForegroundColorAttributeName: greenWord}];
    [rangeText appendAttributedString:subString];
    [rangeLabel setAttributedText:rangeText];
    
    NSMutableAttributedString * timeText = [[NSMutableAttributedString alloc] initWithString:@""];
    NSString *str3 = @"預估";
    NSString *str4 = @"分鐘";
    NSString *timeValue = [NSString stringWithFormat:@"%@",[result objectForKey:@"time"]];
    subString = [[NSAttributedString alloc] initWithString:str3 attributes:@{NSForegroundColorAttributeName: greenWord}];
    [timeText appendAttributedString:subString];
    subString = [[NSAttributedString alloc] initWithString:timeValue attributes:@{NSForegroundColorAttributeName: orangeWord,NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:30]}];
    [timeText appendAttributedString:subString];
    subString = [[NSAttributedString alloc] initWithString:str4 attributes:@{NSForegroundColorAttributeName: greenWord}];
    [timeText appendAttributedString:subString];
    [timeLabel setAttributedText:timeText];
    
    tipLabel.text = [NSString stringWithFormat:@"小 費：%@元",[result objectForKey:@"tips"]];
    int starCount = [[result objectForKey:@"star"] intValue];
    for (int i=0; i<starCount; i++) {
        UIImageView *star = [[UIImageView alloc]initWithFrame:CGRectMake(driverName.frame.origin.x+driverName.frame.size.width+(i*12), driverName.frame.origin.y , 10, 15)];
        [star setImage:[UIImage imageNamed:@"star"]];
        [mainView addSubview:star];
    }
}

-(void)information{
    /*AlarmFriendViewController *alarmVC = [[AlarmFriendViewController alloc]init];
    alarmVC.result = result;
    alarmVC.listDetail = _listDetail;
    [self.navigationController pushViewController:alarmVC animated:YES];*/
    
    prompt = [[UIAlertView alloc] initWithTitle:@"分享資訊"
                                        message:NO // IMPORTANT
                                       delegate:self
                              cancelButtonTitle:@"簡訊"
                              otherButtonTitles:@"LINE", nil];
    
    
    [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
    [prompt show];

    
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    switch (buttonIndex) {
        case 0:
        {
            NSLog(@"Cancel Button Pressed");
            AlarmFriendViewController *nVA = [[AlarmFriendViewController alloc]init];
            [self.navigationController pushViewController:nVA animated:YES];
            
        }

            break;
        case 1:
        {
            NSLog(@"Button 1 Pressed");
        }
            break;
        
            
    }
    
    
    
}


-(void)driverwhere{

    
}

-(void)onlinepayment{

    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    //initData
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}
@end