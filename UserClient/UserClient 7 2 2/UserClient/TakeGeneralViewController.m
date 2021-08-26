//
//  TakeGeneralViewController.m
//  UserClient
//
//  Created by 黃柏鈞 on 2016/7/18.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "TakeGeneralViewController.h"
#import "style.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "UIView+Toast.h"
#import "FavoritePointViewController.h"
#import "TaxiSpecialVIew.h"

#import "MKMap.h"
@interface TakeGeneralViewController ( )<TaxiSpecialVIewDelegate,MKMapDelegate,UIAlertViewDelegate ,CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,UITextFieldDelegate >{
    UITableView *takoTableView;
    int tableCellSelect;
    NSString *tableCellSelectRD;
    MKMap*Map;
    UIBarButtonItem *NavRightButton ;
    UIAlertView *alert;
    UIAlertView *alert2;
    TaxiSpecialVIew *TspV;
    UIBarButtonItem *submitButton;
    NSMutableDictionary *mapRS;

}


@property (nonatomic, strong) CLLocationManager *locationManager;




@end



@implementation TakeGeneralViewController

int titleWidth=320;
int tableCellHeight=60;
int tableValue=5;

-(void)clearUserDefault{
    
    //清除userdefault
    NSString *MKMapAddress = @"";
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //存储时，除NSNumber类型使用对应的类型意外，其他的都是使用setObject:forKey:
    [userDefaults setObject:MKMapAddress forKey:@"MKMapAddress"];
    //这里建议同步存储到磁盘中，但是不是必须的
    [userDefaults synchronize];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    [self clearUserDefault];
    
    mapRS=[NSMutableDictionary dictionaryWithCapacity:10];
    tableCellSelectRD=@"0";
    
    submitButton = [[UIBarButtonItem alloc] initWithTitle:@"叫車" style:UIBarButtonItemStylePlain target:self action:@selector(callTaxi)];
    submitButton.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = submitButton;
    
    
    
    
    alert = [[UIAlertView alloc] initWithTitle:@"請選擇一個方式" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"從地圖輸入", @"從常用加入", nil];
    alert.tag=0;
    //[alert show];
    
    UILabel *title=[[UILabel alloc]init];
    [title setFrame:CGRectMake(aScreenRect.size.width/2-titleWidth/2, 20, titleWidth, 40)];
    title.text=@"您好！您要去哪裡？";
    title.font = [UIFont systemFontOfSize:30];
    UIColor *color = font_titleColor;
    [title setTextColor:color];
    title.textAlignment = NSTextAlignmentCenter;
    //title.backgroundColor=[UIColor redColor];
    [self.view addSubview:title];
    [self takoView];
    
    //定位
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    //請求權限
    [self.locationManager requestAlwaysAuthorization];
    
    //[self specialOption];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:3];
    
    [takoTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}



- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    FavoritePointViewController *fpVC;
    if(alertView.tag==0){
        switch (buttonIndex) {
            case 0:
                NSLog(@"Cancel Button Pressed");
                break;
            case 1:
                NSLog(@"Button 1 Pressed");
                [self showMap];
                break;
            case 2:
                NSLog(@"Button 2 Pressed");
                if(!fpVC){
                    fpVC=[[FavoritePointViewController alloc]init];
                }
                [self.navigationController pushViewController:fpVC animated:YES];
                break;
            default:
                break;
        }
    }
    
    else{
        switch (buttonIndex) {
            case 0:
                NSLog(@"Cancel Button Pressed");
                break;
            case 1:
                NSLog(@"Button 1 Pressed");
                break;
            default:
                break;
        }
        
    }
    
}

-(void)specialOption{
    if (!TspV) {
        TspV=[[TaxiSpecialVIew alloc]init];
        TspV.DataSource=self;
        [TspV setTaxiSpecialVIew];
    }
    [self.view addSubview:TspV];
    
}

-(void)showMap{
    //map
    
    if (!Map) {
        Map=[[MKMap alloc]init];
        Map.hidden=NO;
        Map.delegate=self;
        Map.DataSource=self;
        [Map setMKMapDataSource];
        [self.view addSubview:Map];
    }
    else{
        
        Map.hidden=NO;
        [self.view addSubview:Map];
        
    }
    
    //Map.hidden=YES;
    
    
    NavRightButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(mapDone)];
    self.navigationItem.rightBarButtonItem = NavRightButton;
    
    
    
}

-(void)takoView{
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    takoTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    takoTableView.dataSource = self;
    takoTableView.delegate = self;
    takoTableView.backgroundColor=floor_bgcolor;
    [takoTableView setFrame:CGRectMake(aScreenRect.size.width/2-160, 60, 320, 480)];
    [self.view addSubview: takoTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    self.view.backgroundColor=floor_bgcolor;
    self.navigationController.navigationBar.barTintColor = title_bgcolor;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title=@"一般搭乘";
    
    //initData
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
    [Map removeFromSuperview];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return tableValue;
    }
    else if (section == 1){
        
        return 2;
    }
    return 0;
    //if 之外也要設一個值讓return回傳，不然是無法編譯的
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
    
    //
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *prs = [userDefaultes stringForKey:@"MKMapAddress"];
    NSString*rs=@"";
   
    
    
    [mapRS setObject:prs forKey:tableCellSelectRD];
    
//    NSLog(@"TBS:%@,%d",tableCellSelectRD,tableValue);
   
    //NSLog(@"KEY:%@,ARES:%@",tableCellSelectRD,prs);
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    // 以上兩行是制式寫法
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // cell就是我們表格的內容了
    
    // CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [cell setSelectedBackgroundView:bgColorView];
    
    UIButton *getLocation=[[UIButton alloc]init];
    getLocation.backgroundColor=[UIColor blueColor];
    [getLocation addTarget:self action:@selector(map) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *addTable=[[UIButton alloc]init];
    addTable.backgroundColor=[UIColor redColor];
    addTable.tag=(int)indexPath.row;
    [addTable addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *initLocation=[[UIButton alloc]init];
    initLocation.backgroundColor=[UIColor yellowColor];
    initLocation.tag=indexPath.row;
    [initLocation addTarget:self action:@selector(option) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSString *cellLabelTextTitle;
    if (indexPath.section==0) {
        
        UILabel *line=[[UILabel alloc]init];
        line.backgroundColor=floor_bgcolor;
        [line setFrame:CGRectMake(160-140, 34+tableCellHeight*(indexPath.row+1), 280, 1.5)];
        [tableView addSubview:line];
        
        if(indexPath.row==0){
            
            UIButton *optionBtn1 =[[UIButton alloc]init];
            [optionBtn1 setFrame:CGRectMake(cell.frame.origin.x+65, tableCellHeight*(indexPath.row+1)-5, 15, 15)];
            optionBtn1.backgroundColor=[UIColor redColor];
            [tableView addSubview:optionBtn1];
            
            UILabel *optionLb1=[[UILabel alloc]init];
            [optionLb1 setFrame:CGRectMake(optionBtn1.frame.origin.x+optionBtn1.frame.size.width+5, tableCellHeight*(indexPath.row+1)-5, 35,20 )];
            [optionLb1 setText:@"即時"];
            [tableView addSubview:optionLb1];
            
            UIButton *optionBtn2 =[[UIButton alloc]init];
            [optionBtn2 setFrame:CGRectMake(optionLb1.frame.origin.x+optionLb1.frame.size.width+5, tableCellHeight*(indexPath.row+1)-5, 15, 15)];
            optionBtn2.backgroundColor=[UIColor redColor];
            [tableView addSubview:optionBtn2];
            
            UILabel *optionLb2=[[UILabel alloc]init];
            [optionLb2 setFrame:CGRectMake(optionBtn2.frame.origin.x+optionBtn2.frame.size.width+5, tableCellHeight*(indexPath.row+1)-5, 35,20 )];
            [optionLb2 setText:@"預約"];
            [tableView addSubview:optionLb2];
        }
        
        switch (indexPath.row) {
            case 0:
                cellLabelTextTitle=@" 類型：";
                break;
            case 1:
                cellLabelTextTitle=@"*時間：";
                break;
            case 2:
                cellLabelTextTitle=@"*起點：";
                [getLocation setFrame:CGRectMake(cell.frame.origin.x+270, tableCellHeight*(indexPath.row+1)-10, 30, 30)];
                [tableView addSubview:getLocation];
                break;
                
            case 3:
                //cellLabelTextTitle=@" 中途停靠：";
                // break;
                
                
            default:
//                rs=prs;
//                rs=[NSString stringWithFormat:@" 中途停靠：%@",rs];
//                cellLabelTextTitle=rs;
             
                
                
                //
                //刪除ＣＥＬＬ按鈕
                [initLocation setFrame:CGRectMake(cell.frame.origin.x+270, tableCellHeight*(indexPath.row+1)-10, 30, 30)];
                [tableView addSubview:initLocation];
                
                if (indexPath.row+1==tableValue) {
//                    rs=prs;
//                    rs=[NSString stringWithFormat:@" *終點：%@",rs];
//                    cellLabelTextTitle=rs;
//                    //                cellLabelTextTitle=@" *終點：";
                    [addTable setFrame:CGRectMake(cell.frame.origin.x+270, tableCellHeight*(indexPath.row+1)-10, 30, 30)];
                    [tableView addSubview:addTable];
                }
                
                break;
        }
        
        cell.textLabel.text=cellLabelTextTitle;
        
        
        
        //根據ＣＥＬＬ地址內容放哪邊
        if (indexPath.row+1==tableValue) {
            int indexPathInt=(int)indexPath.row;
            NSString *indexPathString=[NSString stringWithFormat:@"%d",indexPathInt];
            indexPathString=[mapRS objectForKey:indexPathString];
            cell.textLabel.text=[NSString stringWithFormat:@" *終點：%@",indexPathString];
           
        }
        else if (indexPath.row>=3) {
            int indexPathInt=(int)indexPath.row;
            NSString *indexPathString=[NSString stringWithFormat:@"%d",indexPathInt];
          
            indexPathString=[mapRS objectForKey:indexPathString];
            cell.textLabel.text=[NSString stringWithFormat:@" 中途停靠：%@",indexPathString];
              
              
             
        }
        
        

        //
        
        
//        if (indexPath.row+1==tableValue) {
//            rs=[NSString stringWithFormat:@" *終點：%@",rs];
//            cellLabelTextTitle=rs;
//
//        
//        }

    }
    
    else{
        switch (indexPath.row) {
            case 0:
                cellLabelTextTitle=@"*特殊需求";
                break;
            case 1:
                cellLabelTextTitle=@" 備註";
                break;
            default:
                break;
        }
        cell.textLabel.text=cellLabelTextTitle;
    }
    
    
    [cell.contentView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [cell.contentView.layer setBorderWidth:1.0f];
    
    
    
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return tableCellHeight;
}

-(void)add{
    tableValue++;
    [takoTableView removeFromSuperview];
    
    //得到先前的資料
    NSString *Astr=[NSString stringWithFormat:@"%d",(tableValue-2)];
    NSString *Bstr=[mapRS objectForKey:Astr];
    
    //往下推
    NSString *Cstr=[NSString stringWithFormat:@"%d",(tableValue-1)];
    NSString *Dstr=Bstr;
    
    NSLog(@"ASTR:%@,%@",Astr,[mapRS objectForKey:Astr]);
    
    //儲存
  
    
    if ([mapRS objectForKey:Astr]!=NULL) {
//    [mapRS setObject:@"XX" forKey:Astr];
   
    [mapRS removeObjectForKey:Astr];
    [mapRS setObject:Dstr forKey:Cstr];
    }
    
    
    [self takoView];
    

}

-(void)option{
    tableValue--;
    [takoTableView removeFromSuperview];
    [self takoView];
    
}

-(void)map{
    //CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    //map
    /*
     //show map
     mapView = [[MKMapView alloc] init];
     mapView.delegate=self;
     [mapView setFrame:CGRectMake(0, 0, aScreenRect.size.width, aScreenRect.size.height)];
     mapView.showsUserLocation=YES;
     [self.view addSubview:mapView];
     
     
     NavRightButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(mapDone)];
     self.navigationItem.rightBarButtonItem = NavRightButton;
     */
    
    //開始定位
    [self.locationManager startUpdatingLocation];
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
    [self.view makeToast:@"定位完成!"];
    
}


-(void)mapDone{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    takoTableView.hidden=NO;
    Map.hidden=YES;
    self.navigationItem.rightBarButtonItem=nil;
    
    submitButton = [[UIBarButtonItem alloc] initWithTitle:@"叫車" style:UIBarButtonItemStylePlain target:self action:@selector(callTaxi)];
    submitButton.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = submitButton;
    
    //
    [takoTableView removeFromSuperview];
    [self takoView];

    
}

-(void)callTaxi{
    
    alert2 = [[UIAlertView alloc] initWithTitle:@"確認單" message:@"date\n from\n to"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"確認", nil ];
    alert2.alertViewStyle=UIAlertViewStyleDefault;
    alert2.tag=1;
    [alert2 show];
    
    
    
    
    //    // create the alert
    //    let alert = UIAlertController(title: "UIAlertController", message: "Would you like to continue learning how to use iOS alerts?", preferredStyle: UIAlertControllerStyle.Alert)
    //
    //    // add the actions (buttons)
    //    alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
    //    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
    //
    //    // show the alert
    //    self.presentViewController(alert, animated: true, completion: nil)
}

-(CGRect)MKMapSetFrame:(MKMap *)MKMap{
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    return CGRectMake(0, 0, aScreenRect.size.width, aScreenRect.size.height);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld,%ld",(long)indexPath.section,(long)indexPath.row);
    
    tableCellSelect=(int)indexPath.row;
    tableCellSelectRD= [NSString stringWithFormat:@"%d", tableCellSelect];
   // NSLog(@"tbsl:%@",tableCellSelectRD);
    
    
    if (indexPath.section==0) {
        // do somethiong
        
        if (indexPath.row>=3) {
            [alert show];
        }
        
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            [self specialOption];
            
        }
        if (indexPath.row==1) {
            //
        }
    }
    
    
}


//     NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//     NSString *rs = [userDefaultes stringForKey:@"MKMapAddress"];
//     NSLog(@"RS:%@",rs);


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
