//
//  funcChoosePage.m
//  userClient
//
//  Created by CSIEiMac14 on 2016/4/14.
//  Copyright © 2016年 倪志鹏. All rights reserved.
//

#import "funcChoosePage.h"
#import "style.h"
#import "TaxiMainViewController.h"

//#import "realtimeCallTaxiPage.h"
//#import "bookingCallTaxi.h"
//#import "AirplaneViewController.h"

//#import "ChooseValueViewController.h"
//#import "BookChooseItemViewController.h"
//#import "PierViewController.h"

//#import "OrderListViewController.h"

//#import "UserConfigViewController.h"

//YiSlideMenu
#import "ViewController.h"
#import "YiLeftView.h"
#import "YiRightView.h"
#import "YiSlideMenu.h"
#import "NextViewController.h"
#import "Header.h"

#import "aboutViewController.h"
#import "ConsumerSupportViewController.h"




@interface funcChoosePage ()<UITableViewDelegate,UITableViewDataSource,YiSlideMenuDelegate>{
    float width,height;
    
    //YiSlideMenu
    UITableView *tableView;
    YiSlideMenu *slideMenu;
    
}

@end

@implementation funcChoosePage

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    self.navigationController.viewControllers = [NSArray arrayWithObject: self];
    [self.view setBackgroundColor:floor_bgcolor];
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    width = aScreenRect.size.width;
    height = aScreenRect.size.height;
    
    [self setUpBar];
    [self YImenuSetUP];
    
    UIView *adv=[[UIView alloc]init];
    int advSpace=70;
    [adv setFrame:CGRectMake(aScreenRect.size.width/2-(aScreenRect.size.width-advSpace)/2, 20, aScreenRect.size.width-advSpace, aScreenRect.size.width-advSpace)];
    adv.backgroundColor=[UIColor grayColor];
    [tableView addSubview:adv];
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, aScreenRect.size.width-advSpace+50, width-40, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"您好，請選擇需要的服務";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    titleLabel.textColor = font_labelTitleColor;
    [tableView addSubview:titleLabel];
    /*
     NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"item" ofType:@"plist"];
     NSArray *array = [NSArray arrayWithContentsOfFile:sourcePath];
     
     float rangeY = ((height-titleLabel.frame.origin.y-titleLabel.frame.size.height)-270)/4;
     for (int i=0; i<9; i++) {
     UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeSystem];
     if (i<3) {
     itemButton.frame = CGRectMake((i*((width-270)/4+90))+(width-270)/4, (titleLabel.frame.origin.y+titleLabel.frame.size.height)+rangeY, 90, 90);
     }else if(i<6){
     itemButton.frame = CGRectMake(((i-3)*((width-270)/4+90))+(width-270)/4, (titleLabel.frame.origin.y+titleLabel.frame.size.height)+rangeY*2+(90*1), 90, 90);
     }else{
     itemButton.frame = CGRectMake(((i-6)*((width-270)/4+90))+(width-270)/4,(titleLabel.frame.origin.y+titleLabel.frame.size.height)+rangeY*3+(90*2), 90, 90);
     }
     [itemButton setBackgroundColor:[UIColor clearColor]];
     [itemButton addTarget:self action:@selector(toItemView:) forControlEvents:UIControlEventTouchUpInside];
     UIImage *buttonImage;
     buttonImage = [[UIImage imageNamed:[[array objectAtIndex:i] objectForKey:@"itemImg"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     [itemButton setTitle:[[array objectAtIndex:i] objectForKey:@"itemName"] forState:UIControlStateNormal];
     [itemButton setTitleColor:greenWord forState:UIControlStateNormal];
     [itemButton setImage:buttonImage forState:UIControlStateNormal];
     itemButton.titleEdgeInsets = UIEdgeInsetsMake(90.0, - buttonImage.size.width, 0.0, 0.0);
     itemButton.imageEdgeInsets = UIEdgeInsetsMake(-10.0, 0.0, 10.0, - itemButton.titleLabel.bounds.size.width);
     [itemButton setTag:i];
     [self.view addSubview:itemButton];
     }
     */
    
    NSString *sourcePath=[[NSBundle mainBundle] pathForResource:@"CC01_item" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:sourcePath];
    
    //debug
    //NSLog(@"%@",[[array objectAtIndex:0] objectForKey:@"img"]);
    //NSLog(@"%@",[[array objectAtIndex:0] objectForKey:@"funName"]);
    
    float rangeY = ((height-titleLabel.frame.origin.y-titleLabel.frame.size.height)-270)/4;
    for (int i=0; i<3; i++) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeSystem];
        if (i<3) {
            itemButton.frame = CGRectMake((i*((width-270)/4+90))+(width-270)/4, titleLabel.frame.origin.y+70, 70, 70);
        }else if(i<6){
            itemButton.frame = CGRectMake(((i-3)*((width-270)/4+90))+(width-270)/4, (titleLabel.frame.origin.y+titleLabel.frame.size.height)+rangeY*2+(90*1), 90, 90);
        }else{
            itemButton.frame = CGRectMake(((i-6)*((width-270)/4+90))+(width-270)/4,(titleLabel.frame.origin.y+titleLabel.frame.size.height)+rangeY*3+(90*2), 90, 90);
        }
        [itemButton setBackgroundColor:[UIColor clearColor]];
        [itemButton addTarget:self action:@selector(toItemView:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *buttonImage;
        buttonImage = [[UIImage imageNamed:[[array objectAtIndex:i] objectForKey:@"img"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [itemButton setTitle:[[array objectAtIndex:i] objectForKey:@"funName"] forState:UIControlStateNormal];
        [itemButton setTitleColor:font_titleColor forState:UIControlStateNormal];
        [itemButton setImage:buttonImage forState:UIControlStateNormal];
        itemButton.titleEdgeInsets = UIEdgeInsetsMake(90.0, - buttonImage.size.width, 0.0, 0.0);
        itemButton.imageEdgeInsets = UIEdgeInsetsMake(-10.0, 0.0, 10.0, - itemButton.titleLabel.bounds.size.width);
        [itemButton setTag:i];
        [tableView addSubview:itemButton];
    }
    
    
    
}


- (void)toItemView:(id)sender
{
    UIButton *btn=sender;
    switch (btn.tag) {
            
        case 0:
        {
            TaxiMainViewController *nVT = [[TaxiMainViewController alloc]init];
            [self.navigationController pushViewController:nVT animated:YES];
        }
            break;
            
            
        case 1:
        {
        }

            break;
            
        case 2:
        {
        }
            
            break;

    }

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpBar{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"第一幫"];
}

/*
-(void)toItemView:(id)send{
    UIButton *btn = send;
    switch (btn.tag) {
        case 0:
        {
            realtimeCallTaxiPage *realtimeCVC = [[realtimeCallTaxiPage alloc]init];
            [self.navigationController pushViewController:realtimeCVC animated:YES];
        }
            break;
        case 1:
        {
            bookingCallTaxi *bookCVC = [[bookingCallTaxi alloc]init];
            [self.navigationController pushViewController:bookCVC animated:YES];
        }
            break;
        case 2:
        {
            AirplaneViewController *airplane = [[AirplaneViewController alloc] init];
            [self.navigationController pushViewController:airplane animated:YES];
        }
            break;
        case 3:
        {
            ChooseValueViewController *chooseVVC = [[ChooseValueViewController alloc]init];
            [self.navigationController pushViewController:chooseVVC animated:YES];
        }
            break;
        case 4:
        {
            BookChooseItemViewController *bookCIVC = [[BookChooseItemViewController alloc]init];
            [self.navigationController pushViewController:bookCIVC animated:YES];
        }
            break;
        case 5:
        {
            PierViewController *pierVVC = [[PierViewController alloc]init];
            [self.navigationController pushViewController:pierVVC animated:YES];
        }
            break;
        case 6:
        {
            OrderListViewController *orderLVC = [[OrderListViewController alloc]init];
            [self.navigationController pushViewController:orderLVC animated:YES];
        }
            break;
        case 7:
        {
            //            ChooseValueViewController *chooseVVC = [[ChooseValueViewController alloc]init];
            //            [self.navigationController pushViewController:chooseVVC animated:YES];
        }
            break;
        case 8:
        {
            UserConfigViewController *userCVC = [[UserConfigViewController alloc]init];
            [self.navigationController pushViewController:userCVC animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}
*/

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
    slideMenu.navTitleLabel.text=@"第一幫";
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0 , WScreen, HScreen-64) style:UITableViewStylePlain];
    [slideMenu.centerView addSubview:tableView];
    
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    tableView.rowHeight=aScreenRect.size.height*2;
    tableView.dataSource=self;
    tableView.delegate=self;
    
    if (iOS7) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    tableView.showsVerticalScrollIndicator=NO;
    
    tableView.backgroundColor=floor_bgcolor;
    self.view.backgroundColor=floor_bgcolor;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
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
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath slide:(YiSlideDirection)slideDirection{
}
-(void)passView:(UIViewController *)passView{
    NSLog(@"passview");
    [self.navigationController pushViewController:passView animated:YES];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)



// YI Slide menu

@end
