//
//  CallDriverViewController.m
//  UserClient
//
//  Created by user on 2016/7/23.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "CallDriverViewController.h"

#import "UIDefine.h"
#import "CCProgressView.h"
#import "ZHPickView.h"
#import "APIController.h"

#import "TakeGeneralViewController.h"
#import "DriverRunViewController.h"
#import "pastBillViewController.h"

@interface CallDriverViewController ()<ZHPickViewDelegate>{
    CGFloat width,height;
    UIButton *tipButton;
    
    NSString *nowTips;
    
    NSDictionary *result;
    
    NSTimer *timer;
}

@property (strong, nonatomic) CCProgressView *progressView;
@property(nonatomic,strong)ZHPickView *pickview;

@end

@implementation CallDriverViewController

//-(instancetype)initData:(NSString *)orderID{
//
//    return self;
//}


-(void)viewDidLoad{
    self.view.backgroundColor = backColor;
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    width = aScreenRect.size.width;
    height = aScreenRect.size.height;
    
    [self setUpBar];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 74, width-40, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"收到，正在為您叫車";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    titleLabel.textColor = greenWord;
    [self.view addSubview:titleLabel];
    
    UILabel *titleBottom = [[UILabel alloc]initWithFrame:CGRectMake((width - 200) / 2.0f, titleLabel.frame.origin.y+titleLabel.frame.size.height+5, 200, 20)];
    titleBottom.textAlignment = NSTextAlignmentCenter;
    titleBottom.text = @"優先通知附近車輛";
    titleBottom.textColor = grayWord;
    [self.view addSubview:titleBottom];
    
    _progressView = [[CCProgressView alloc] initWithFrame:CGRectMake((width - 240) / 2.0f, titleBottom.frame.origin.y+titleBottom.frame.size.height+30, 240, 240)];
    [_progressView setAnimationTime:60];
    
    [self.view addSubview:_progressView];
    
    [_progressView startAnimation];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake((width - 40) / 2.0f, _progressView.frame.origin.y+_progressView.frame.size.height+15, 40, 20)];
    tipLabel.text = @"小費";
    tipLabel.textColor = greenWord;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    
    tipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tipButton.frame = CGRectMake((width - 160) / 2.0f, tipLabel.frame.origin.y+tipLabel.frame.size.height+10, 160, 30);
    [tipButton setTitle:@"請點選" forState:UIControlStateNormal];
    [tipButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tipButton addTarget:self action:@selector(showTip) forControlEvents:UIControlEventTouchUpInside];
    [tipButton setBackgroundColor:[UIColor whiteColor]];
    tipButton.layer.cornerRadius = 5;
    [self.view addSubview:tipButton];
    
    [_progressView setLabelText:@"已通知 0 輛車"];
    
    nowTips = @"0";
    
    // timer以每隔1秒執行
    timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(find_driver) userInfo:nil repeats:YES];
    
    
    
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)setUpBar{
    [self.navigationItem setTitle:@"通知司機中"];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"取消叫車" style:UIBarButtonItemStylePlain target:self action:@selector(rightCancel)];
    self.navigationItem.rightBarButtonItem = cancelButton;
    
    UIButton *left=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [left setBackgroundImage:[UIImage imageNamed:@"arrows"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(leftBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithCustomView:left];
    
    self.navigationItem.leftBarButtonItem = backButton;
}

-(void)showTip{
    NSMutableArray *money = [[NSMutableArray alloc] init];
    for(int i = 0; i <= 1000; i=i+50){
        [money addObject:[NSString stringWithFormat:@"%d",i]];
    }
    NSArray *array = [NSArray arrayWithArray:money];
    _pickview = [[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    _pickview.delegate = self;
    [_pickview show];
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    [tipButton setTitle:[NSString stringWithFormat:@"%@元",resultString] forState:UIControlStateNormal];
    [self changeTips];
    nowTips = resultString;
}

-(void)leftBack{
    [self stopTimer];
    TakeGeneralViewController *nVT = [[TakeGeneralViewController alloc]init];
    [self.navigationController pushViewController:nVT animated:NO];
}

-(void)rightCancel{
    [self stopTimer];
    //self disableCall];
    //[self.navigationController popToRootViewControllerAnimated:NO];
    
    DriverRunViewController *nVD = [[DriverRunViewController alloc]init];
    [self.navigationController pushViewController:nVD animated:YES];
}

-(void)find_driver{
   /* dispatch_async(kBgQueue, ^{
        result = [APIController Find_driver:@"people" id:_order_id];
        //        NSLog(@"尋找司機 %@",result);
        [self performSelectorOnMainThread:@selector(toDriverRun:) withObject:result waitUntilDone:YES];
    });*/
    
}

-(void)disableCall{
   /* dispatch_async(kBgQueue, ^{
        result = [APIController Cancel_find_driver:@"people" id:_order_id];
        
        NSLog(@"取消呼叫司機 %@",result);
        
        //[self performSelectorOnMainThread:@selector(fetchedData:) withObject:dct waitUntilDone:YES];
    });*/
}

-(void)changeTips{
   /* dispatch_async(kBgQueue, ^{
        NSDictionary *dict = @{@"tips":nowTips};
        result = [APIController Update_tips:dict order_type:@"people" id:_order_id];
        NSLog(@"更改小費 %@",result);
        
        //        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:dct waitUntilDone:YES];
    });*/
}

-(void)stopTimer{
    [timer invalidate];
    timer = nil;
}

-(void)toDriverRun:(NSDictionary *)responseData {
    /*NSString *check_driver = [NSString stringWithFormat:@"%@",[responseData objectForKey:@"check_driver"]];
    [_progressView setLabelText:[NSString stringWithFormat:@"已通知 %@ 輛車",check_driver]];
    if (![check_driver isEqualToString:@"0"]) {
        [self stopTimer];
        DriverRunViewController *driverRunVC = [[DriverRunViewController alloc]init];
        driverRunVC.order_id = _order_id;
        driverRunVC.listDetail = _listDetail;
        [self.navigationController pushViewController:driverRunVC animated:YES];
    }*/
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
