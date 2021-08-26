//
//  InvoiceProcessing.m
//  DriverClient
//
//  Created by YouSway on 2016/7/5.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "InvoiceProcessing.h"
#import "UIDefine.h"
#import "style.h"
#import "waitForRunViewController.h"
#import "pastBillViewController.h"
#import "APIController.h"
#import "Cargo.h"
#import "Instructions.h"
#import "CancelManifest.h"
#import "Receipt.h"
#import "UIView+Toast.h"

#import "MKMap.h"
#import <MapKit/MapKit.h>
#import<CoreLocation/CoreLocation.h>

@interface InvoiceProcessing ()<MKMapViewDelegate,MKMapDelegate,CLLocationManagerDelegate>{
    
    CGFloat width,height;
    CLLocation *currentLocation;
    NSDictionary *result;
    
    UIAlertView *cancelprompt;
    UIAlertView *mprompt;
    
    MKMap*Map;
}
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation InvoiceProcessing

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=floor_bgcolor;
    self.navigationController.navigationBar.barTintColor = title_bgcolor;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title=@"貨單處理";
    
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

    
    
    //取消訂單按紐
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"取消訂單" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = right;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    width = aScreenRect.size.width;
    height = aScreenRect.size.height;
    
    [self orderprocessing];
    
    //    NSLog(@"%@",result);
    
    //定位
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestAlwaysAuthorization];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGRect)MKMapSetFrame:(MKMap *)MKMap{
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    return CGRectMake(0, 0, aScreenRect.size.width, aScreenRect.size.height);
}


-(void)orderprocessing{
    
    
    NSDictionary *results = [APIController Order_info:@"item" order_id:_order_id];
    result = [results objectForKey:@"orders"];
    
    UILabel *receiverPayLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 40, 80, 20)];
    receiverPayLabel.text = @"付款人：";
    receiverPayLabel.textColor = orangeWord;
    [receiverPayLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [self.view addSubview:receiverPayLabel];
    
    UILabel *whoPay = [[UILabel alloc]init];
    whoPay.frame = CGRectMake(100, 40, 80, 20);
    whoPay.textColor = orangeWord;
    whoPay.text = @"發貨方";
    [whoPay setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [self.view addSubview:whoPay];
    
    UILabel *itemType = [[UILabel alloc]initWithFrame:CGRectMake(30, 70, 200, 20)];
    itemType.textColor = orangeWord;
    [itemType setFont:[UIFont systemFontOfSize:18]];
    itemType.text = @"即時寄貨(小費：50元)";
    [self.view addSubview:itemType];
    
    UILabel *fLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 110, width-60, 30)];
    fLabel.text = @"從：";
    fLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:fLabel];
    
    UILabel *tLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 140, width-60, 30)];
    tLabel.text = @"到：";
    tLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tLabel];
    
    UILabel *itemDate = [[UILabel alloc]initWithFrame:CGRectMake(30, 170, width-60, 30)];
    itemDate.text = @"2015/12/08 07:07";
    itemDate.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:itemDate];
    
    
    UIImage *callImg = [UIImage imageNamed:@"phone"];
    UIButton *callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [callButton setFrame:CGRectMake(width-110, 110, 75, 75)];
    [callButton setTitle:@"撥給客戶" forState:UIControlStateNormal];
    [callButton setImage:callImg forState:UIControlStateNormal];
    callButton.titleEdgeInsets = UIEdgeInsetsMake(80.0, - callImg.size.width, 0.0, 0.0);
    callButton.imageEdgeInsets = UIEdgeInsetsMake(-10.0, 0.0, 10.0, - callButton.titleLabel.bounds.size.width);
    [callButton setTitleColor:greenLightButton forState:UIControlStateNormal];
    [callButton addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:callButton];
    
    UIImageView *bottomView = [[UIImageView alloc]initWithFrame:CGRectMake(0, height-320, width, 270)];
    bottomView.backgroundColor = blueButton;
    bottomView.userInteractionEnabled = YES;
    [self.view addSubview:bottomView];
    
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"Invoicebottom" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:sourcePath];
    
    for (int i=0; i<8; i++) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i<4) {
            itemButton.frame = CGRectMake((i*((width-210)/5+55))+(width-270)/4, 30, 55, 55);
        }else if(i<8){
            itemButton.frame = CGRectMake(((i-4)*((width-210)/5+55))+(width-270)/4, 130, 55, 55);
        }
        [itemButton setBackgroundColor:[UIColor clearColor]];
        [itemButton addTarget:self action:@selector(toItemView:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *buttonImage;
        buttonImage = [[UIImage imageNamed:[[array objectAtIndex:i] objectForKey:@"itemImg"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [itemButton setTitle:[[array objectAtIndex:i] objectForKey:@"itemName"] forState:UIControlStateNormal];
        [itemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [itemButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        [itemButton setImage:buttonImage forState:UIControlStateNormal];
        itemButton.titleEdgeInsets = UIEdgeInsetsMake(75.0, - buttonImage.size.width-5, 0.0, -5.0);
        itemButton.imageEdgeInsets = UIEdgeInsetsMake(-10.0, 0.0, 10.0, - itemButton.titleLabel.bounds.size.width);
        [itemButton setTag:i];
        [bottomView addSubview:itemButton];
    }
    
    
    UIButton *instructionsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    instructionsBtn.frame = CGRectMake(width*0.35,bottomView.frame.size.height-40,width*0.3,20);
    instructionsBtn.backgroundColor = [UIColor clearColor];
    [instructionsBtn setFont:[UIFont fontWithName:@"Helvetica-Oblique" size:13]];
    [instructionsBtn setTitleColor:RGBACOLOR(255,255,255,1) forState:UIControlStateNormal];
    [instructionsBtn setTitle:@"使 用 說 明" forState:UIControlStateNormal];
    [instructionsBtn addTarget:self action:@selector(instructions) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:instructionsBtn];
    
    
}

-(int)setUpMap{
    // 取得現在所在位置
    //    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    
    // 取得台北101所在位置
    // 根據台北101座標設定一個大頭針標示
    
    //    latitude      纬度
    //    longitude     经度
    if (!currentLocation) {
        NSLog(@"沒有定位");
        [self.view makeToast:@"請先設定導航起點"];
        return -1;
    }

    MKPlacemark *markPointA = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude) addressDictionary:nil];
    
    
    MKMapItem *pointA = [[MKMapItem alloc] initWithPlacemark:markPointA];
    // 設定大頭針上的標籤資訊
    pointA.name = @"台北101";
    pointA.phoneNumber = @"0977123456";
    
    // 取得師大分部所在位置
    // 根據師大分部座標設定一個大頭針標示
    MKPlacemark *markPointB = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(25.0084083, 121.535736) addressDictionary:nil];
    MKMapItem *pointB = [[MKMapItem alloc] initWithPlacemark:markPointB];
    // 設定大頭針上的標籤資訊
    pointB.name = @"師大分部";
    pointB.phoneNumber = @"0933123456";
    
    // 決定現在所在位置是起點還是終點
    // 這樣的設定是：起點Ａ 終點Ｂ
    NSArray *array = [[NSArray alloc] initWithObjects:pointA, pointB, nil];
    
    // 設定導航模式是行車還是走路
    NSDictionary *param = [NSDictionary dictionaryWithObject:MKLaunchOptionsDirectionsModeDriving forKey:MKLaunchOptionsDirectionsModeKey];
    
    // 開啓內建的地圖
    [MKMapItem openMapsWithItems:array launchOptions:param];
    

    return 0;

}
-(void)mapDone{
//    [Map removeFromSuperview];
     Map.hidden=YES;
}

-(void)toItemView:(id)send{
    UIButton *btn = send;
    switch (btn.tag) {
        case 0:
        {
            //            UIViewController *screenVC = [storyboard instantiateViewControllerWithIdentifier:@"screenConditionPage"];
            //            [self.navigationController pushViewController:screenVC animated:YES];
            
            Cargo *nVC = [[Cargo alloc]init];
            [self.navigationController pushViewController:nVC animated:YES];
             break;
            
        }
        case 1:
        {
            //            UIViewController *screenVC = [storyboard instantiateViewControllerWithIdentifier:@"startScreenPage"];
            //            [self.navigationController pushViewController:screenVC animated:YES];
            [self.view makeToast:@"開始定位"];
              [self.locationManager startUpdatingLocation];
            

             break;
        }
        case 2:
        {
            //            UIViewController *screenVC = [storyboard instantiateViewControllerWithIdentifier:@"orderToRun"];
            //            [self.navigationController pushViewController:screenVC animated:YES];
            
            [self setUpMap];
             break;
        }
        case 3:
        {
            mprompt = [[UIAlertView alloc] initWithTitle:@"修改價錢"
                                                             message:@"提出修改後的價錢\n" // IMPORTANT
                                                            delegate:nil
                                                   cancelButtonTitle:@"取消"
                                                   otherButtonTitles:@"送出", nil];
            mprompt.alertViewStyle = UIAlertViewStylePlainTextInput;
            
            // set place
            [mprompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
            [mprompt show];
            //[prompt release];
             break;
        }
        case 4:
        {
            //            BookChooseItemViewController *bookCIVC = [[BookChooseItemViewController alloc]init];
            //            [self.navigationController pushViewController:bookCIVC animated:YES];
            
            UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"已經上車"
                                                             message:@"已記錄上車時間\n等待資料" // IMPORTANT
                                                            delegate:nil
                                                   cancelButtonTitle:NO
                                                   otherButtonTitles:@"確認", nil];
            
            // set place
            [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
            [prompt show];
            //[prompt release];
            
             break;
            
            
        }
        case 5:
        {
            UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"完成訂單"
                                                             message:@"完成訂單時間\n等待資料" // IMPORTANT
                                                            delegate:nil
                                                   cancelButtonTitle:NO
                                                   otherButtonTitles:@"邀請客戶評分", nil];
            
            // set place
            [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
            [prompt show];
            //[prompt release];
            
            pastBillViewController *nVP = [[pastBillViewController alloc]init];
            [self.navigationController pushViewController:nVP animated:YES];
            
             break;
        }
        case 6:
        {
            [self.view makeToast:@"此功能尚未開放，敬請期待！"];
             break;
        }
        case 7:
        {
            Receipt *nVR = [[Receipt alloc]init];
            [self.navigationController pushViewController:nVR animated:YES];
            break;
        }
        default:
            break;
    }
    
}


-(void)cancel{
    
    cancelprompt = [[UIAlertView alloc] initWithTitle:@"取消訂單"
                                        message:@"如果經常性或惡意取消訂單\n可能會受到處罰" // IMPORTANT
                                       delegate:self
                              cancelButtonTitle:@"放棄取消"
                              otherButtonTitles:@"仍要取消", nil];
    
    
    // set place
    [cancelprompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
    [cancelprompt show];
    //[prompt release];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView == cancelprompt)
    {
        switch (buttonIndex) {
            case 0:
                NSLog(@"Cancel Button Pressed");
                break;
            case 1:
                NSLog(@"Button 1 Pressed");
                
                CancelManifest *nVC = [[CancelManifest alloc]init];
                [self.navigationController pushViewController:nVC animated:YES];
                break;
                
        }
    }else if (alertView == mprompt)
    {
        
        switch (buttonIndex) {
            case 3:
            {
                //得到输入框
                UITextField *tf=[alertView textFieldAtIndex:0];
                NSLog(@"%@",tf.text);
                break;
            }
                
                

        }
        
    }
    
    
    
    
    
}


-(void)instructions{
    
    Instructions *nVI = [[Instructions alloc]init];
    [self.navigationController pushViewController:nVI animated:YES];
    
}


-(void)call{
    NSLog(@"%@",_cphone);
}

-(void)toLocation{
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"%@", locations);
    
    // locations包含的是CLLocation对象
    //    CLLocationCoordinate2D 2D位置坐标  也就是经纬度
    //    latitude      纬度
    //    longitude     经度
    CLLocation *location = [locations lastObject];
    
    NSLog(@"纬度 %f", location.coordinate.latitude);
    NSLog(@"经度 %f", location.coordinate.longitude);
    
    // 停止更新位置——实现一次定位
    currentLocation=location;
    [self.locationManager stopUpdatingLocation];
   [self.view makeToast:@"定位成功"];
    
    
    
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error

{
    
    [self.view makeToast:@"定位失敗，請重新檢查"];
    
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    //initData
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}

-(void)backBtnPressed
{
    waitForRunViewController *nVW = [[waitForRunViewController alloc]init];
    [self.navigationController pushViewController:nVW animated:YES];
}



@end
