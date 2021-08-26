//
//  aboutViewController.m
//  userClient
//
//  Created by 黃柏鈞 on 2016/7/2.
//  Copyright © 2016年 倪志鹏. All rights reserved.
//

#import "waitForRunViewController.h"
#import "style.h"
#import "OrderProcessing.h"
#import "InvoiceProcessing.h"

//YiSlideMenu
#import "ViewController.h"
#import "YiLeftView.h"
#import "YiRightView.h"
#import "YiSlideMenu.h"
#import "NextViewController.h"
#import "Header.h"



#import "funcChoosePage.h"
#import "screenConditionPage.h"
#import "waitForRunViewController.h"
#import "pastBillViewController.h"
#import "ConsumerSupportViewController.h"
#import "newNewsViewController.h"
#import "aboutViewController.h"
#import "myAccountViewController.h"

//toast
#import "UIView+Toast.h"


@interface waitForRunViewController ()<UITableViewDelegate,UITableViewDataSource,YiSlideMenuDelegate>{
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

@implementation waitForRunViewController

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
    [self waitforrun];
    // Do any additional setup after loading the view.

    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)waitforrun{

    _ordertableview = [[UITableView alloc]initWithFrame:CGRectMake(width/2-160, 20, 320, height-64-40)];
    _ordertableview.dataSource = self;
    _ordertableview.delegate = self;
    _ordertableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    _tableview.bounces = NO;
    _ordertableview.backgroundColor =floor_bgcolor;
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
        cell.backgroundColor = RGBACOLOR(241, 241, 241, 1);
    }
    
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
    
    titleLabel.textColor = orangeWord;
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
    
    UIButton *orderProcess = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderProcess setFrame:CGRectMake(content.frame.size.width-70, 25, 60, 60)];
    orderProcess.titleLabel.numberOfLines = 2;
    [orderProcess setTitle:@"訂單\n處理" forState:UIControlStateNormal];
    orderProcess.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
    [orderProcess setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [orderProcess setBackgroundColor:orangeButton];
    [orderProcess.layer setCornerRadius:5];
    [orderProcess addTarget:self action:@selector(toProcess:event:) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:orderProcess];

    
    return cell;
}

-(void)toProcess:(id)sender event:(id)event{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_ordertableview];
    NSIndexPath *indexPath = [_ordertableview indexPathForRowAtPoint: currentTouchPosition];
    if (indexPath != nil){
        NSString *type = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"type"];
        NSString *order_id = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"id"];
        /*if ([type isEqualToString:@"people"]) {
         CarProcessViewController *carPVC = [[CarProcessViewController alloc]init];
         carPVC.order_id = order_id;
         carPVC.cphone = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"user_phone"];
         [self.navigationController pushViewController:carPVC animated:YES];
         }else if([type isEqualToString:@"item"]){
         ItemProcessViewController *itemPVC = [[ItemProcessViewController alloc]init];
         itemPVC.order_id = order_id;
         itemPVC.cphone = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"user_phone"];
         [self.navigationController pushViewController:itemPVC animated:YES];
         }*/
        
        
        InvoiceProcessing *nVO = [[InvoiceProcessing alloc]init];
        [self.navigationController pushViewController:nVO animated:YES];

        
    }
}


/////////以下是側欄位


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
    slideMenu.navTitleLabel.text=@"待跑訂單";
    
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
}

-(void)passView:(UIViewController *)passView{
    NSLog(@"waitForRunViewController");
    [self.navigationController pushViewController:passView animated:YES];
    
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
