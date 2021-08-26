//
//  funcChoosePage.m
//  userClient
//
//  Created by CSIEiMac14 on 2016/4/14.
//  Copyright © 2016年 倪志鹏. All rights reserved.
//

#import "funcChoosePage.h"
#import "UIDefine.h"
#import "style.h"
#import "APIController.h"
#import "Travel.h"
#import "Cargo.h"


//YiSlideMenu
#import "ViewController.h"
#import "YiLeftView.h"
#import "YiRightView.h"
#import "YiSlideMenu.h"
#import "NextViewController.h"
#import "Header.h"




#import "screenConditionPage.h"
#import "waitForRunViewController.h"
#import "pastBillViewController.h"
#import "ConsumerSupportViewController.h"
#import "newNewsViewController.h"
#import "aboutViewController.h"
#import "myAccountViewController.h"

//toast
#import "UIView+Toast.h"

@interface funcChoosePage ()<UITableViewDelegate,UITableViewDataSource,YiSlideMenuDelegate>{
    float width,height;
    
    //YiSlideMenu
    UITableView *YiSlidetableView;
    YiSlideMenu *slideMenu;
    
    //選擇欄位
    int nowType;
    
    
    UIImageView *content;
    UILabel *titleLabel,*fromLabel,*toLabel,*dateTimeLabel;
    UIButton *checkBtn,*grabBtn;
    
    NSMutableArray *resultArray;
    UIAlertView *order_prompt;
    
}

@property (strong, nonatomic) UISegmentedControl *segControl;
@property (strong, nonatomic) UITableView *ordertableview;


@end

@implementation funcChoosePage

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    
    self.navigationController.viewControllers = [NSArray arrayWithObject: self];
    [self.view setBackgroundColor:backColor];
    
//    
//    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
//    // [navigationArray removeAllObjects];    // This is just for remove all view controller from navigation stack.
//    [navigationArray removeObjectAtIndex: 0];  // You can pass your index here
//    self.navigationController.viewControllers = navigationArray;
    
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    width = aScreenRect.size.width;
    height = aScreenRect.size.height;
    
    
    [self YImenuSetUP];
    [self orders];
    [self type];
    

    
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)orders{


    
    NSArray *segments = [[NSArray alloc] initWithObjects: @"即時",
                         @"預約", @"車行", nil];
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    _segControl = [[UISegmentedControl alloc]initWithItems:segments];
    [_segControl setFrame:CGRectMake(20, 30, width-40, 40)];
    [_segControl setSelectedSegmentIndex:0];
    [_segControl setTintColor:segGreen];
    [_segControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [_segControl addTarget:self action:@selector(segTap:) forControlEvents:UIControlEventValueChanged];
    [YiSlidetableView addSubview:_segControl];
    
    
    
    
    _ordertableview = [[UITableView alloc]initWithFrame:CGRectMake(20, _segControl.frame.origin.y+_segControl.frame.size.height+20, width-40, height*0.7)];
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


-(void)type{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary  *dictSave = [userDefaults valueForKey:@"userReg"];
    NSString *driver_type = [dictSave valueForKey:@"driver_type"];
    NSString *car_info = [dictSave valueForKey:@"car_info"];
    NSString *info_photo = [dictSave valueForKey:@"info_photo"];
    
    if([driver_type isEqualToString:@"0"]){
    
        UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"司機身份未選擇"
                                                         message:@"請到「主選單>我的帳戶>司機身份」中\n繼續完成註冊步驟" // IMPORTANT
                                                        delegate:nil
                                               cancelButtonTitle:NO
                                               otherButtonTitles:@"確認", nil];

        [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
        [prompt show];
        
    }else if([car_info isEqualToString:@"0"]){
        
        UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"車籍登入未完成"
                                                         message:@"請到「主選單>我的帳戶>車籍登錄」中\n繼續完成註冊步驟" // IMPORTANT
                                                        delegate:nil
                                               cancelButtonTitle:NO
                                               otherButtonTitles:@"確認", nil];
        
        [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
        [prompt show];
    
    }else if([info_photo isEqualToString:@"0"]){
        
        UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"證件上傳未完成"
                                                         message:@"請到「主選單>我的帳戶>證件上傳」中\n繼續完成註冊步驟" // IMPORTANT
                                                        delegate:nil
                                               cancelButtonTitle:NO
                                               otherButtonTitles:@"確認", nil];
        
        [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
        [prompt show];
        
    }else if([info_photo isEqualToString:@"2"]){
        
        UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"司機資格審核中"
                                                         message:@"審核通過後將開啟接單功能\n請等候簡訊" // IMPORTANT
                                                        delegate:nil
                                               cancelButtonTitle:NO
                                               otherButtonTitles:@"確認", nil];
        
        [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
        [prompt show];
        
    }

    
}



-(void)segTap:(UISegmentedControl *)paramSender{
    if ([paramSender isEqual:_segControl]){
        //get index position for the selected control
        NSInteger selectedIndex = [paramSender selectedSegmentIndex];
        //get the Text for the segmented control that was selected
        NSString *myChoice = [paramSender titleForSegmentAtIndex:selectedIndex];
        if ([myChoice isEqualToString:@"即時"]) {
            nowType = 1;
            
        }else if ([myChoice isEqualToString:@"預約"]) {
            nowType = 2;
            
        }else if ([myChoice isEqualToString:@"車行"]) {
            nowType = 3;
        }
        
    }
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
    content = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width-40, 110)];
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
    [orderProcess setFrame:CGRectMake(content.frame.size.width-70, 20, 60, 30)];
    orderProcess.titleLabel.numberOfLines = 2;
    [orderProcess setTitle:@"查看" forState:UIControlStateNormal];
    orderProcess.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
    [orderProcess setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [orderProcess setBackgroundColor:greenButton];
    [orderProcess.layer setCornerRadius:5];
    [orderProcess addTarget:self action:@selector(toProcess:event:) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:orderProcess];
    
    
    UIButton *robberyProcess = [UIButton buttonWithType:UIButtonTypeCustom];
    [robberyProcess setFrame:CGRectMake(content.frame.size.width-70, orderProcess.frame.origin.y+orderProcess.frame.size.height+10, 60, 30)];
    robberyProcess.titleLabel.numberOfLines = 2;
    [robberyProcess setTitle:@"搶單" forState:UIControlStateNormal];
    robberyProcess.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
    [robberyProcess setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [robberyProcess setBackgroundColor:orangeButton];
    [robberyProcess.layer setCornerRadius:5];
    [robberyProcess addTarget:self action:@selector(torobbery:event:) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:robberyProcess];
    
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
        
        Travel *nVT = [[Travel alloc]init];
        [self.navigationController pushViewController:nVT animated:YES];
        
    }
}



-(void)torobbery:(id)sender event:(id)event{
    
    /*NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_ordertableview];
    NSIndexPath *indexPath = [_ordertableview indexPathForRowAtPoint: currentTouchPosition];
    if (indexPath != nil){
        NSString *type = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"type"];
        NSString *order_id = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"id"];
        if ([type isEqualToString:@"people"]) {
         CarProcessViewController *carPVC = [[CarProcessViewController alloc]init];
         carPVC.order_id = order_id;
         carPVC.cphone = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"user_phone"];
         [self.navigationController pushViewController:carPVC animated:YES];
         }else if([type isEqualToString:@"item"]){
         ItemProcessViewController *itemPVC = [[ItemProcessViewController alloc]init];
         itemPVC.order_id = order_id;
         itemPVC.cphone = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"user_phone"];
         [self.navigationController pushViewController:itemPVC animated:YES];
         }
        
        Cargo *nVC = [[Cargo alloc]init];
        [self.navigationController pushViewController:nVC animated:YES];
        
    }*/
    
    order_prompt = [[UIAlertView alloc] initWithTitle:@"確認接單"
                                        message:@"如果經常性或惡意取消訂單\n可能會受到處罰" // IMPORTANT
                                       delegate:self
                              cancelButtonTitle:@"放棄接單"
                              otherButtonTitles:@"確認接單", nil];
    
    
    // set place
    [order_prompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
    [order_prompt show];
    //[prompt release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView == order_prompt)
    {
        
        switch (buttonIndex) {
            case 0:
                NSLog(@"Cancel Button Pressed");
                break;
            case 1:
                NSLog(@"Button 1 Pressed");
                
                waitForRunViewController *nVW = [[waitForRunViewController alloc]init];
                [self.navigationController pushViewController:nVW animated:YES];
                break;
                
        }
        
    }
    
}


//////////////////////////以下是側欄位ㄥ////////////

// YI Slide menu
-(void)YImenuSetUP{
    //YiSlideMenu
    // Do any additional setup after loading the view, typically from a nib.
    /*
     UINavigationController *nav = nil;
     nav = [[UINavigationController alloc] initWithRootViewController:self];
     */
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    self.navigationController.navigationBar.hidden=YES;
    
    slideMenu = [[YiSlideMenu alloc] initWithFrame:CGRectMake(0,0, WScreen, HScreen)];
    [self.view addSubview:slideMenu];
    slideMenu.slideMenuDelegate=self;
    slideMenu.navTitleLabel.text=@"開始接單";
    
    YiSlidetableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0 , WScreen, HScreen-64) style:UITableViewStylePlain];
    YiSlidetableView.scrollEnabled = NO;
    
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
    slideMenu.navRightBt.hidden=YES;
    
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

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

-(void)passView:(UIViewController *)passView{
    NSLog(@"funcChoosePage");
    [self.navigationController pushViewController:passView animated:YES];
    
}

-(void)toast1:(NSString*)value1
{
    NSLog(@"123%@",value1);
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath slide:(YiSlideDirection)slideDirection{
}



// YI Slide menu

@end
