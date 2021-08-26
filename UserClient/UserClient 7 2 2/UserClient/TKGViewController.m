//
//  TKGViewController.m
//  UserClient
//
//  Created by 黃柏鈞 on 2016/8/3.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "TKGViewController.h"
#import "style.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "UIView+Toast.h"
#import "MKMap.h"
#import "FavoritePointViewController.h"
#import "TaxiSpecialVIew.h"
@interface TKGViewController ()<UITableViewDelegate,CLLocationManagerDelegate,MKMapDelegate,MKMapViewDelegate,UIAlertViewDelegate,TaxiSpecialVIewDelegate>{
UIBarButtonItem *NavRightButton ;
    NSString *cellName;
    UIAlertView *alert;
    UIAlertView *alert2;
    MKMap*Map;
    int selectPathRD;
    NSMutableDictionary *dictionary;
    TaxiSpecialVIew *TspV;
     UIBarButtonItem *submitButton;
    
}
@property (nonatomic, strong) UITableViewCell *buttonCell;
@property (nonatomic, assign) NSUInteger cellCount;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation TKGViewController
int CellHeight=60;
int generalWidth;

//類型
BOOL now=true;
bool notNow=false;
- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
   
    [self makeTableView];
    //定位
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    //請求權限
    [self.locationManager requestAlwaysAuthorization];
    
    dictionary= [NSMutableDictionary dictionaryWithCapacity:10];
    
  
//    NSLog(@"%d",_cellCount);
    
   
    UILabel *title=[[UILabel alloc]init];
    [title setFrame:CGRectMake(aScreenRect.size.width/2-generalWidth/2, 20, generalWidth, 40)];
    title.text=@"您好！您要去哪裡？";
    title.font = [UIFont systemFontOfSize:30];
    UIColor *color = font_titleColor;
    [title setTextColor:color];
    title.textAlignment = NSTextAlignmentCenter;
    //title.backgroundColor=[UIColor redColor];
    [self.view addSubview:title];

    submitButton = [[UIBarButtonItem alloc] initWithTitle:@"叫車" style:UIBarButtonItemStylePlain target:self action:@selector(callTaxi)];
    submitButton.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = submitButton;

}
-(void)makeTableView{

    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    int titleWidth=aScreenRect.size.width-60;
    generalWidth=titleWidth;
    _cellCount = 4;
    

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [_tableView setFrame:CGRectMake(aScreenRect.size.width/2-titleWidth/2, 60, titleWidth, _tableView.bounds.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate=self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"buttonCell"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    cellName=@"*終點:";
    [self.view addSubview:_tableView];

    


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
    
}

#pragma mark -
- (UITableViewCell *)buttonCell {
    if (_buttonCell == nil) {
//        _buttonCell = [_tableView dequeueReusableCellWithIdentifier:@"buttonCell"];
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//        button.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
//        [button setTitle:@"add" forState:UIControlStateNormal];
//        [button sizeToFit];
//        button.center = _buttonCell.contentView.center;
//        [button addTarget:self action:@selector(addMoreCell) forControlEvents:UIControlEventTouchUpInside];
//        [_buttonCell.contentView addSubview:button];
        
        
        static NSString *cellIdentifier = @"cell";
       // UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
          _buttonCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return _buttonCell;
}
- (void)addMoreCell {
    //if (_cellCount<=4) {
    _cellCount++;
    cellName=@"停靠:";
    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:(_cellCount-2) inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    //}
    
    
    
   
    
}
//-(void)delCell{
//    if (_cellCount>0) {
//        _cellCount--;
//        [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:YES];
//    }
//}
#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    
    if (section == 0) {
        
      return _cellCount;
    }
    else if (section == 1){
        
      return 2;
    }
    return 0;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

bool firstTimeSetUP=true;
int btn1X;
int btn2X;
int btn3X;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        return self.buttonCell;
//    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (indexPath.section==0) {
//         cell.textLabel.text = [NSString stringWithFormat:@"cell %ld", indexPath.row];
        cell.textLabel.tag=indexPath.row;
        
       
        if (now && indexPath.row==1) {
            cell.textLabel.text=@"";
            return cell;
        }

        
        
        switch (indexPath.row) {
                
                
            case 0:
                cell.textLabel.text = @"  類型:       即時      預約";
                break;
            case 1:
                cell.textLabel.text = @"*時間:";
                break;
            case 2:
                
                if ([dictionary objectForKey:@"START"]!=NULL) {
                    cell.textLabel.text=[NSString stringWithFormat:@"*起點:%@",[dictionary objectForKey:@"START"]];
                    
                }
                else{
                    cell.textLabel.text = @"*起點:請定位";
                    NSLog(@"%@",[dictionary objectForKey:@"START"]);
                }
                
                break;
           default:
                if (indexPath.row == (_cellCount-1)) {
                
                    NSString *tmp=[NSString stringWithFormat:@"%d",(int)indexPath.row];
                    NSLog(@"RD:KEY:%@,ADS:%@",tmp,[dictionary objectForKey:tmp]);
//                    NSString*tmp2=[NSString stringWithFormat:@"*終點:%@",[dictionary objectForKey:@"END"]];
//                    cell.textLabel.text = tmp2;
                    
                    
                    NSString*tmp2;
                    if ([dictionary objectForKey:@"END"]==NULL) {
                        tmp2=@"*終點:請選擇一個地點";
                        cell.textLabel.text = tmp2;
                    }
                    else{
                        tmp2=[NSString stringWithFormat:@"*終點:%@",[dictionary objectForKey:@"END"]];
                        cell.textLabel.text = tmp2;
                    }

                    
                    NSLog(@"END:%ld",indexPath.row);
                    
                }
                else{
//                    cell.textLabel.text = @"停靠:";
                    
                    NSString *tmp=[NSString stringWithFormat:@"%d",(int)indexPath.row];
                    NSLog(@"RD:KEY:%@,ADS:%@",tmp,[dictionary objectForKey:tmp]);
                    NSString*tmp2;
                    if ([dictionary objectForKey:tmp]==NULL) {
                        tmp2=@" 停靠:請選擇一個地點";
                        cell.textLabel.text = tmp2;
                    }
                    else{
                        tmp2=[NSString stringWithFormat:@"  停靠:%@",[dictionary objectForKey:tmp]];
                        cell.textLabel.text = tmp2;
                    }
                    
                    NSLog(@"MID:%ld",indexPath.row);
                }
        }
        
        
        if(firstTimeSetUP){
            btn1X=cell.frame.size.width+cell.frame.origin.x-40;
            btn2X=cell.frame.size.width+cell.frame.origin.x-10;
            btn3X=cell.frame.size.width+cell.frame.origin.x-10;
            firstTimeSetUP =false;
        }
    
       
        
        UIButton *cellFun=[[UIButton alloc]init];
        cellFun.tag=indexPath.row;
        cellFun.backgroundColor=[UIColor redColor];
        [cellFun setFrame:CGRectMake(btn1X, 0, 30, 30)];
        [cell.contentView addSubview:cellFun];
        [cellFun addTarget:self action:@selector(fun:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *cellFun2=[[UIButton alloc]init];
        cellFun2.tag=indexPath.row;
        cellFun2.backgroundColor=[UIColor yellowColor];
        [cellFun2 setFrame:CGRectMake(btn2X, 0, 30, 30)];
        [cell.contentView addSubview:cellFun2];
        
        
        //按鈕位置設定
        if (indexPath.row==0) {
            [cellFun setFrame:CGRectMake(cell.frame.origin.x+70, 20, 20, 20)];
            [cellFun2 setFrame:CGRectMake(cell.frame.origin.x+135, 20, 20, 20)];
        }
        if (indexPath.row==1) {
            cellFun2.backgroundColor=[UIColor clearColor];
        }
        
        
//        [cellFun2 addTarget:self action:@selector(fun2:) forControlEvents:UIControlEventTouchUpInside];
        
        
            
        if (indexPath.row == (_cellCount-1)) {
            //終點動作
            [cellFun2 addTarget:self action:@selector(fun3:) forControlEvents:UIControlEventTouchUpInside];
        }
        else {
            //停靠動作
            [cellFun2 addTarget:self action:@selector(fun2:) forControlEvents:UIControlEventTouchUpInside];

        }
        
    }
    
    else{
        //section 1
        UIButton *cellFun=[[UIButton alloc]init];
        cellFun.tag=indexPath.row;
        cellFun.backgroundColor=[UIColor redColor];
        [cellFun setFrame:CGRectMake(btn3X, 0, 30, 30)];
//        [cell.contentView addSubview:cellFun];
        [cellFun addTarget:self action:@selector(fun4:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if (indexPath.row==0) {
            cell.textLabel.text=@"*特殊需求";
            [cell.contentView addSubview:cellFun];

        }
        else if (indexPath.row==1){
            cell.textLabel.text=@"  備註:";
        }
    }
    
    

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld,%ld",(long)indexPath.section,(long)indexPath.row);
    if (indexPath.section==0) {
        if (indexPath.row==0) {
//             [self addMoreCell];
        }
        if (indexPath.row==1) {
            
        }
        if (indexPath.row==2) {
            //
        }
    }
}

//fun1~3 section0
//fun4 section1

-(void)fun:(id)sender{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    UIButton *btn=sender;
    
    if (btn.tag==0) {
        if (!now) {
            now=true;
            notNow=false;
            [_tableView reloadData];
        }
        NSLog(@"即時:%d,預約:%D",now,notNow);
    }
    
    if (btn.tag>=3) {
        alert = [[UIAlertView alloc] initWithTitle:@"請選擇一個方式" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"從地圖輸入", @"從常用加入", nil];
        alert.tag=0;
        [alert show];
    }
    
    selectPathRD=(int)indexPath.row;
    //NSLog(@"SLRD:%d",selectPathRD);
    
}
-(void)fun2:(id)sender{
    
    //獲取indexPath
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    if (indexPath != nil)
    {
//        int currentIndex = indexPath.row;
//        int tableSection = indexPath.section;
    }
    selectPathRD=(int)indexPath.row;
    //NSLog(@"SLRD:%d",selectPathRD);

    //刪除CELL
    UIButton *btn=sender;
    
    
    if (btn.tag==0) {
        if (now) {
            now=false;
            notNow=true;
            [_tableView reloadData];
        }
        NSLog(@"即時:%d,預約:%D",now,notNow);
    }
    

    
    if (btn.tag==2) {
        NSLog(@"CLICK");
        [self.locationManager startUpdatingLocation];
       
    }
    
       if (btn.tag>=3) {
        if (_cellCount>4) {
            _cellCount--;
            [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:YES];
           NSString *tmp=[NSString stringWithFormat:@"%d",selectPathRD];
            [dictionary removeObjectForKey:tmp];
            
          
        }
           

    
    }
    
   

    
    
}

-(void)fun3:(id)sender{
    UIButton *btn=sender;
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    selectPathRD=(int)indexPath.row;
    
    if (btn.tag==2) {
        //
        NSLog(@"fun3click");
    }
    
    if (btn.tag>=3 ) {
        NSLog(@"CLICK2");
        
        NSString *tmp=[NSString stringWithFormat:@"%d",(int)(selectPathRD-1)];
        if ([dictionary objectForKey:tmp]==NULL && selectPathRD!=3) {
            NSLog(@"NULL");
        }
        else{
            [self addMoreCell];
        }
        
       
       
        
    }
    
    
}

-(void)fun4:(id)sender{
    if (!TspV) {
        TspV=[[TaxiSpecialVIew alloc]init];
        TspV.DataSource=self;
        [TspV setTaxiSpecialVIew];
    }
    [self.view addSubview:TspV];

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
    
    
    [dictionary setObject:@"完成" forKey:@"START"];
    [_tableView reloadData];
    
    
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
-(void)mapDone{
    Map.hidden=YES;
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *rs = [userDefaultes stringForKey:@"MKMapAddress"];
    NSLog(@"RS:%@",rs);
    NSString *tmp=[NSString stringWithFormat:@"%d",selectPathRD];
   
    
    if (_cellCount==selectPathRD+1) {
        NSLog(@"END");
        [dictionary setObject:rs forKey:@"END"];
    }
    else{
        NSLog(@"NOTEND");
        [dictionary setObject:rs forKey:tmp];
    }
        
//    NSLog(@"KEY:%@,ADS:%@",tmp,[dictionary objectForKey:tmp]);
    
    
    
    
//    
////    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    UILabel *label = (UILabel *)[_tableView viewWithTag:selectPathRD];
//    label.text=[dictionary objectForKey:tmp];
//
   
    
    [_tableView reloadData];
    
    submitButton = [[UIBarButtonItem alloc] initWithTitle:@"叫車" style:UIBarButtonItemStylePlain target:self action:@selector(callTaxi)];
    submitButton.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = submitButton;

}



-(void)callTaxi{
    
    alert2 = [[UIAlertView alloc] initWithTitle:@"確認單" message:@"date\n from\n to"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"確認", nil ];
    alert2.alertViewStyle=UIAlertViewStyleDefault;
    alert2.tag=1;
    [alert2 show];
    
    
}



-(CGRect)MKMapSetFrame:(MKMap *)MKMap{
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    return CGRectMake(0, 0, aScreenRect.size.width, aScreenRect.size.height);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    if (indexPath.section==0) {
        if (now && indexPath.row==1) {
            
            return 0;
        }

    }
    return CellHeight;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
