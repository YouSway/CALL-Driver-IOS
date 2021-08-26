//
//  aboutViewController.m
//  userClient
//
//  Created by 黃柏鈞 on 2016/7/2.
//  Copyright © 2016年 倪志鹏. All rights reserved.
//

#import "pastBillViewController.h"
#import "style.h"

#import "ViewController.h"
#import "YiLeftView.h"
#import "YiRightView.h"
#import "YiSlideMenu.h"
#import "NextViewController.h"
#import "Header.h"






//toast
#import "UIView+Toast.h"


@interface pastBillViewController ()<UITableViewDelegate,UITableViewDataSource,YiSlideMenuDelegate>{
    float width,height;
    
    //YiSlideMenu
    UITableView *YiSlidetableView;
    YiSlideMenu *slideMenu;
    
    
    UIImageView *content;
    UILabel *titleLabel,*fromLabel,*toLabel,*dateTimeLabel;
    UIButton *checkBtn,*grabBtn;
    
    NSMutableArray *resultArray;
    
}

@property (strong, nonatomic) UITableView *ordertableview;


@end

@implementation pastBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=floor_bgcolor;
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    width = aScreenRect.size.width;
    height = aScreenRect.size.height;
    
    
    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    // [navigationArray removeAllObjects];    // This is just for remove all view controller from navigation stack.
    [navigationArray removeObjectAtIndex: 0];  // You can pass your index here
    self.navigationController.viewControllers = navigationArray;
    
    [self YImenuSetUP];
    YiSlidetableView.scrollEnabled=NO;
    [self pastbill];
    // Do any additional setup after loading the view.


    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)pastbill{

    _ordertableview = [[UITableView alloc]initWithFrame:CGRectMake(width/2-160, 20, 320, height-64-40)];
    _ordertableview.dataSource = self;
    _ordertableview.delegate = self;
    _ordertableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    _tableview.bounces = NO;
    _ordertableview.backgroundColor = RGBACOLOR(241, 241, 241, 1);
    [YiSlidetableView addSubview:_ordertableview];
    
    
    
    /*dispatch_async(kBgQueue, ^{
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
     NSDictionary *userReg = [userDefaults valueForKey:@"userReg"];
     NSDictionary *results = [APIController Order_doing_list:@{@"user_id":[userReg objectForKey:@"user_id"]}];
     
     [self performSelectorOnMainThread:@selector(fetchedData:) withObject:results waitUntilDone:YES];
     });*/
    
}


- (void)fetchedData:(NSDictionary *)responseData {
    //    NSLog(@"%@",responseData);
    resultArray = [responseData objectForKey:@"orders"];
    [_ordertableview reloadData];
}

//-(void)leftDateTap{
//    NSLog(@"left");
//}
//
//-(void)RightDateTap{
//    NSLog(@"Right");
//}

#pragma mark - TableViewDelegate & TableViewDatasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView == YiSlidetableView)
    {
        return 0;
    }
    
    //    NSLog(@"有 %ld 筆",[resultArray count]);
    //return  [resultArray count];
    return  10;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(tableView == YiSlidetableView)
    {
        NSString *CellId = @"CellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellId];
            
            //        cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        cell.textLabel.text=slideMenu.navTitleLabel.text;
        cell.detailTextLabel.text=@"I am a 22 year old developer who works primarily on iOS. I love building creative products that are beneficial to people's lives.";
        cell.detailTextLabel.numberOfLines=0;
        return cell;
    }
    
    static NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = floor_bgcolor;    }
    
    NSString *type = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"type"];
    
    [[cell viewWithTag:111]removeFromSuperview];
    content = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 110)];
    content.backgroundColor = [UIColor whiteColor];
    [content.layer setCornerRadius:10];
    content.tag = 111;
    content.userInteractionEnabled = YES;
    [cell.contentView addSubview:content];
    
    
    NSString *dateTime = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"time"];
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, content.frame.size.width-100, 20)];
    
    if ([dateTime isEqualToString:@"0000-00-00 00:00:00"]) {
        if ([type isEqualToString:@"people"]) {
            titleLabel.text = [NSString stringWithFormat:@"即時訂單(小費：%@元)",[[resultArray objectAtIndex:indexPath.row] objectForKey:@"tips"]];
        }else if([type isEqualToString:@"item"]){
            titleLabel.text = [NSString stringWithFormat:@"即時寄貨(小費：%@元)",[[resultArray objectAtIndex:indexPath.row] objectForKey:@"tips"]];
        }
    }else{
        if ([type isEqualToString:@"people"]) {
            titleLabel.text = [NSString stringWithFormat:@"預約訂單(小費：%@元)",[[resultArray objectAtIndex:indexPath.row] objectForKey:@"tips"]];
        }else if([type isEqualToString:@"item"]){
            titleLabel.text = [NSString stringWithFormat:@"預約寄貨(小費：%@元)",[[resultArray objectAtIndex:indexPath.row] objectForKey:@"tips"]];
        }
    }
    
    //titleLabel.textColor = orangeWord;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.tag = 222;
    
    [content addSubview:titleLabel];
    
    fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, content.frame.size.width-100, 20)];
    fromLabel.text = [NSString stringWithFormat:@"從：%@",[[resultArray objectAtIndex:indexPath.row] objectForKey:@"start_place"]];
    fromLabel.textAlignment = NSTextAlignmentLeft;
    fromLabel.tag = 333;
    [content addSubview:fromLabel];
    
    toLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 55, content.frame.size.width-100, 20)];
    toLabel.text = [NSString stringWithFormat:@"到：%@",[[resultArray objectAtIndex:indexPath.row] objectForKey:@"end_place"]];
    
    toLabel.textAlignment = NSTextAlignmentLeft;
    toLabel.tag = 444;
    [content addSubview:toLabel];
    
    dateTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, content.frame.size.width-100, 20)];
    dateTimeLabel.text = dateTime;
    dateTimeLabel.textAlignment = NSTextAlignmentLeft;
    dateTimeLabel.tag = 555;
    [content addSubview:dateTimeLabel];
    
    if ([dateTime isEqualToString:@"0000-00-00 00:00:00"]) {
        if ([type isEqualToString:@"people"]) {
            dateTimeLabel.text = @"即時訂單";
        }else if([type isEqualToString:@"item"]){
            dateTimeLabel.text = @"即時寄貨";
        }
    }
    
    
    return cell;
}



//////////以下是側欄位ㄥ//////////


// YI Slide menu
-(void)YImenuSetUP{
    //YiSlideMenu
    // Do any additional setup after loading the view, typically from a nib.
    //UINavigationController *nav = nil;
    //nav = [[UINavigationController alloc] initWithRootViewController:self];
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    self.navigationController.navigationBar.hidden=YES;
    
    slideMenu = [[YiSlideMenu alloc] initWithFrame:CGRectMake(0,0, WScreen, HScreen)];
    [self.view addSubview:slideMenu];
    slideMenu.slideMenuDelegate=self;
    slideMenu.navTitleLabel.text=@"過去訂單";
    
    YiSlidetableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0 , WScreen, HScreen-64) style:UITableViewStylePlain];
    [slideMenu.centerView addSubview:YiSlidetableView];
    
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    YiSlidetableView.rowHeight=aScreenRect.size.height*2;
    YiSlidetableView.dataSource=self;
    YiSlidetableView.delegate=self;
    
    if (iOS7) {
        [YiSlidetableView setSeparatorInset:UIEdgeInsetsZero];
    }
    YiSlidetableView.showsVerticalScrollIndicator=NO;
    
    YiSlidetableView.backgroundColor=floor_bgcolor;
    self.view.backgroundColor=floor_bgcolor;
    
}
-(void)passView:(UIViewController *)passView{
    NSLog(@"passview");
    [self.navigationController pushViewController:passView animated:YES];
}


/*- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellId];
        
        //        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    cell.textLabel.text=slideMenu.navTitleLabel.text;
    cell.detailTextLabel.text=@"I am a 22 year old developer who works primarily on iOS. I love building creative products that are beneficial to people's lives.";
    cell.detailTextLabel.numberOfLines=0;
    return cell;
}*/



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath slide:(YiSlideDirection)slideDirection{
    
    
    NSLog(@"test");
//    UIViewController *selectPage;
//    NSString *sourcePath=[[NSBundle mainBundle] pathForResource:@"leftMenuItem" ofType:@"plist"];
//    NSArray *array = [NSArray arrayWithContentsOfFile:sourcePath];
//    
//    
//    if (slideDirection==YiLeftDirection) {
//        //slideMenu.navTitleLabel.text=[NSString stringWithFormat:@"Menu%ld",(long)indexPath.row];
//        slideMenu.navTitleLabel.text=[[array objectAtIndex:indexPath.row+1] objectForKey:@"funName"];
//        switch (indexPath.row) {
//            case 0:
//                selectPage=[[funcChoosePage alloc]init];
//                
//                break;
//            case 1:
//                
//                selectPage =[[screenConditionPage alloc]init];
//                
//                break;
//                
//            case 2:
//                
//                selectPage=[[waitForRunViewController alloc]init];
//                break;
//                
//            case 3:
//                
//                [slideMenu navLeftBtAction];
//                return;
//                break;
//                
//            case 4:
//                selectPage=[[ConsumerSupportViewController  alloc]init];
//                break;
//                
//            case 5:
//                selectPage=[[newNewsViewController alloc]init];
//                
//                break;
//                
//            case 6:
//                selectPage=[[aboutViewController alloc]init];
//                break;
//            case 7:
//                [self.view makeToast:@"share with friends"];
//                return;
//                break;
//                
//            case 8:
//                selectPage=[[myAccountViewController alloc]init];
//                break;
//                
//            case 9:
//                [self.view makeToast:@"功能即將開放,敬請期待!"];
//                return;
//                break;
//                
//            default:
//                break;
//        }
//        
//        
//        [slideMenu navLeftBtAction];
//        [YiSlidetableView reloadData];
//        
//        
//    }else if (slideDirection==YiRightDirection){
//        slideMenu.navTitleLabel.text=[NSString stringWithFormat:@"Notify%ld",(long)indexPath.row];
//        NextViewController *next=[[NextViewController alloc] init];
//    }
//    
//    
//    [self.navigationController pushViewController:selectPage animated:YES];
    
    
}




// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)



// YI Slide menu


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
