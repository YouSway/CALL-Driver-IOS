//
//  MKMap.m
//  UserClient
//
//  Created by DSL on 2016/7/21.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "MKMap.h"
#import "MyAnnotation.h"
#import "UIView+Toast.h"

@implementation MKMap
UIImageView *putLocation;
MyAnnotation *myPoint;
NSString *addressRS;
UISearchBar *MKsearchBar;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{

    self=[super initWithFrame:frame];
    if (self) {
    }
    //self.frame=CGRectMake(0, 0, 200, 200);
    
    return self;
}

-(void)setMKMapDataSource{
    //NSLog(@"IN");
    
    self.frame=[_DataSource MKMapSetFrame:self ];
    self.showsUserLocation=YES;
   
    
    [self setSearchBar];
    
    UIButton *locationBtn=[[UIButton alloc]init];
    [locationBtn setFrame:CGRectMake(20,60, 30, 30)];
    locationBtn.backgroundColor=[UIColor redColor];
    [self addSubview:locationBtn];
    [locationBtn addTarget:self action:@selector(getlocation) forControlEvents:UIControlEventTouchUpInside];
    
    self.locationManager= [[CLLocationManager alloc] init];
    self.locationManager.delegate=self;
    //[self.locationManager startUpdatingLocation];
    
    //地址轉經緯度
    //http://maps.googleapis.com/maps/api/geocode/json?address=新北市平溪區十分街51&sensor=false
    //經緯度轉地址
    //http://maps.googleapis.com/maps/api/geocode/json?latlng=25.0420118,121.5
    
    //
    UITapGestureRecognizer *mTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
    [self addGestureRecognizer:mTap];
    
     
    
}

-(void)setSearchBar{
    if (!MKsearchBar) {
    MKsearchBar=[[UISearchBar alloc]init];
    MKsearchBar.delegate=self;
    [MKsearchBar setFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    [self addSubview:MKsearchBar];
    }
    else{
        MKsearchBar.text=addressRS;
        
        //儲存資訊
        [self saveNSUserDefaults];
    }
    
//     NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//     NSString *rs = [userDefaultes stringForKey:@"MKMapAddress"];
//     NSLog(@"RS:%@",rs);
}


-(void)saveNSUserDefaults
{
    NSString *MKMapAddress = addressRS;
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //存储时，除NSNumber类型使用对应的类型意外，其他的都是使用setObject:forKey:
    [userDefaults setObject:MKMapAddress forKey:@"MKMapAddress"];
    //这里建议同步存储到磁盘中，但是不是必须的
    [userDefaults synchronize];
    
    
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"search click");
    [searchBar resignFirstResponder];
    
    //地址轉經緯度
    NSString *str =@"NSString";
   str = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false&language=zh-tw",MKsearchBar.text];
    //中文網址轉換
    str=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    //save to ns data
    NSError *error;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *addressLoc = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//     NSArray* latestLoans = [addressLoc objectForKey:@"results"];
 
    
  //檢查狀態
    NSString *status=[addressLoc objectForKey:@"status"];
    NSLog(@"%@",status);
    BOOL caompare=[status isEqualToString:@"OK"];
    if (!caompare) {
         UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [window.viewForBaselineLayout makeToast:@"沒有找到地點"
         duration:3.0 position:CSToastPositionTop
         ];
        return;
    }
    
    
    NSArray* latestLoans = [addressLoc objectForKey:@"results"];
    NSDictionary* loan = [latestLoans objectAtIndex:0];
    latestLoans = [loan objectForKey:@"geometry"];
    loan = [loan objectForKey:@"geometry"];
    loan=[loan objectForKey:@"location"];
    
    
    CLLocationCoordinate2D loc;
    NSString *lat=[loan objectForKey:@"lat"];
    //lat=[lat substringFromIndex:8];
    NSString *lng=[loan objectForKey:@"lng"];
    //lng=[lng substringFromIndex:8];
    loc.latitude=[lat doubleValue];
    loc.longitude=[lng doubleValue];
//
   
    //NSLog(@"%@",latestLoans);
    //NSLog(@"%@",loan);
   NSLog(@"%f,%f",loc.latitude,loc.longitude);
    NSLog(@"%@,%@",lat,lng);
//
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [self setRegion:region animated:YES];
    
    [self removeAnnotation:myPoint];
    NSString *titile = [NSString stringWithFormat:@"%f,%f",loc.latitude,loc.longitude];
    myPoint = [[MyAnnotation alloc] initWithCoordinate:loc andTitle:titile];
    [self addAnnotation:myPoint];

 }


- (void)tapPress:(UIGestureRecognizer*)gestureRecognizer {
    
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self];//这里touchPoint是点击的某点在地图控件中的位置
    CLLocationCoordinate2D touchMapCoordinate =
    [self convertPoint:touchPoint toCoordinateFromView:self];//这里touchMapCoordinate就是该点的经纬度了
    
    
    
    //加入一個大頭針
    NSString *titile = [NSString stringWithFormat:@"%f,%f",touchMapCoordinate.latitude,touchMapCoordinate.longitude];
    [self removeAnnotation:myPoint];
    myPoint = [[MyAnnotation alloc] initWithCoordinate:touchMapCoordinate andTitle:titile];
    [self addAnnotation:myPoint];

    
    //放大到标注的位置
    //    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    //    [self.mapView setRegion:region animated:YES];

    
    //經緯度轉地址
    //http://maps.googleapis.com/maps/api/geocode/json?latlng=25.0420118,121.5
    NSString *str =@"NSString";
    str = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=false&language=zh-tw",touchMapCoordinate.latitude,touchMapCoordinate.longitude];
//    NSLog(@"%@", str);
    
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    //save to ns data
    NSError *error;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
//    NSLog(@"%@",response);
    
    
    
    NSDictionary *addressDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
   
//    NSMutableArray *addressInfo=[[NSMutableArray alloc]init];
//    addressInfo= [NSJSONSerialization JSONObjectWithData: response options:NSJSONReadingMutableContainers error:nil];
    
    //檢查狀態
    NSString *status=[addressDic objectForKey:@"status"];
    NSLog(@"%@",status);
    BOOL caompare=[status isEqualToString:@"OK"];
    if (!caompare) {
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [window.viewForBaselineLayout makeToast:@"ERROR"
                                       duration:3.0 position:CSToastPositionTop
         ];
        return;
    }

    
    NSArray* latestLoans = [addressDic objectForKey:@"results"];
    NSDictionary* loan = [latestLoans objectAtIndex:0];
    latestLoans = [loan objectForKey:@"address_components"];
    NSString *adres=[loan objectForKey:@"formatted_address"];
    NSLog(@"address:%@",adres);
    addressRS=adres;
    
//    for (int i=0; i<6; i++) {
//    loan=nil;
//    loan=[latestLoans objectAtIndex:i];
//    if (!loan) {break;}
//    str=[loan objectForKey:@"long_name"];
//    NSLog(@"%@",str);
//    }
   
    
    
    adres=nil;
    latestLoans=nil;
    loan=nil;
    str=nil;
    
    [self setSearchBar];
    
    NSLog(@"纬度 %f", touchMapCoordinate.latitude);
    NSLog(@"经度 %f", touchMapCoordinate.longitude);
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
    [self.locationManager stopUpdatingLocation];
    CLLocationCoordinate2D loc;
    loc=location.coordinate;
    [self setlocation:&loc];
    //[self.view makeToast:@"定位完成!"];
}

-(void)getlocation{
   
    self.locationManager= [[CLLocationManager alloc] init];
    self.locationManager.delegate=self;
    [self.locationManager startUpdatingLocation];
    
}

-(void)setlocation:(CLLocationCoordinate2D *)loc{
        //loc->latitude=32;
        //loc->longitude=121;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(*loc, 250, 250);
        [self setRegion:region animated:YES];
        [self.locationManager stopUpdatingLocation];

}




//#pragma mark - CLLocationManagerDelegate 定位服务

// 当获得了新的位置时，调用该方法
//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation*)locations fromLocation:(CLLocation *)oldLocation{
//    
//    
//
//    //NSLog(@"Latitude = %f", locations.coordinate.latitude);
//    //NSLog(@"Longitude = %f", locations.coordinate.longitude);
//    
//    //顯示經緯度
//    //NSLog(@"%@", locations);
//    NSLog(@"纬度 %f", locations.coordinate.latitude);
//    NSLog(@"经度 %f", locations.coordinate.longitude);
//    
//    
//    //反譯經緯度
//    // 创建一个定位对象
//    CLLocation *thelocation = [[CLLocation alloc]initWithLatitude:locations.coordinate.latitude
//                                                        longitude:locations.coordinate.longitude];
//    
//    // 初始化一个反向地理编码对象
//    self.myGeocoder = [[CLGeocoder alloc] init];
//    // 根据给定的经纬度来得到相应的地址信息
//    [self.myGeocoder reverseGeocodeLocation:thelocation completionHandler:^(NSArray*placemarks, NSError *error) {
//        if (error == nil && [placemarks count] > 0){
//            
//            // CLPlacemark 存储着相应的地址数据
//            CLPlacemark *placemark = [placemarks objectAtIndex:0];
//            
//            NSLog(@"Country = %@", placemark.country);
//            NSLog(@"Postal Code = %@", placemark.postalCode);
//            NSLog(@"Locality = %@", placemark.locality);
//        }
//        else if (error == nil && [placemarks count] == 0){
//            NSLog(@"No results were returned.");
//        }
//        else if (error != nil){
//            NSLog(@"An error occurred = %@", error); }
//    }];
//    
//    
//    
//   
//    
//    // locations包含的是CLLocation对象
//    //    CLLocationCoordinate2D 2D位置坐标  也就是经纬度
//    //    latitude      纬度
//    //    longitude     经度
////    CLLocation *location = [locations lastObject];
////    
////    NSLog(@"纬度 %f", location.coordinate.latitude);
////    NSLog(@"经度 %f", location.coordinate.longitude);
//    
//    // 停止更新位置——实现一次定位
//    
//    
//    
//    CLLocationCoordinate2D loc;
//    loc=locations.coordinate;
//    [self setlocation:&loc];
//    //[self.view makeToast:@"定位完成!"];
//    
//}



//-(void)parseJson:(NSString *)addr
//{
//    //The URL of JSON service
//    NSString *_urlString = @"http://maps.googleapis.com/maps/api/geocode/json?address=nanjing&sensor=true";
//    NSString *_dataString = [[NSString alloc] initWithData:[_urlString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding];
//    
//    //_dataString=[NSString stringWithUTF8String:[_urlString UTF8String]];
//    
//    NSURL *_url = [NSURL URLWithString:_dataString];
//    NSMutableURLRequest *_request = [NSMutableURLRequest requestWithURL:_url];
//    [_request setValue:@"accept" forHTTPHeaderField:@"application/json"];
//    [NSURLConnection sendAsynchronousRequest:_request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
//                               //block define statment
//                               NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
//                               
//                               int responseStatusCode = [httpResponse statusCode];
//                               NSLog(@"response status code is %d",responseStatusCode);
//                               
//                               NSError *_errorJson = nil;
//                               
//                               NSDictionary *resultsDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//                               
//                               if (_errorJson != nil) {
//                                   NSLog(@"Error %@", [_errorJson localizedDescription]);
//                               } else {
//                                   NSString *resultStatus = [resultsDic objectForKey:@"status"];
//                                   
//                                   if ([resultStatus isEqualString:@"OK"])
//                                   {
//                                       NSArray *resultsArr = [resultsDic objectForKey:@"results"];
//                                       
//                                       //Do something with returned array
//                                       for (NSDictionary * resultDetailDic in resultsArr)
//                                       {
//                                           NSDictionary * locationDic=[[resultDetailDic objectForKey:@"geometry"] objectForKey:@"location"];
//                                           NSString * lat=[locationDic objectForKey:@"lat"];
//                                           NSString * lng=[locationDic objectForKey:@"lng"];
//                                           
//                                           dispatch_async(dispatch_get_main_queue(), ^{
//                                               NSLog(@"locationDic.lat 是--->%@\n",lat);
//                                               NSLog(@"locationDic.lng 是--->%@\n",lng);
//                                           });// dispatch async main
//                                       }
//                                   }
//                               }
//                           }];  
//}  

@end
