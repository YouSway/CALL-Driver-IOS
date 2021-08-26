//
//  Integral.m
//  DriverClient
//
//  Created by YouSway on 2016/8/6.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "Integral.h"
#import "style.h"

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
#import "HistoryIntegral.h"

//toast
#import "UIView+Toast.h"

@interface Integral  ()<UITableViewDelegate,UITableViewDataSource,YiSlideMenuDelegate>{
    float width,height;
    
    //YiSlideMenu
    UITableView *tableView;
    YiSlideMenu *slideMenu;
    
}


@end

@implementation Integral

int cellValue=5;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=floor_bgcolor;
    
    //NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    // [navigationArray removeAllObjects];    // This is just for remove all view controller from navigation stack.
    //[navigationArray removeObjectAtIndex: 0];  // You can pass your index here
    //self.navigationController.viewControllers = navigationArray;
    
    
    
    [self YImenuSetUP];
    // Do any additional setup after loading the view.
    [self integral];
}

-(void)integral{

    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    //section 0
    UILabel *lb0bg=[[UILabel  alloc]init];
    lb0bg.backgroundColor=[UIColor whiteColor];
    [lb0bg setFrame:CGRectMake(20, 20, aScreenRect.size.width-40, 120)];
    lb0bg.layer.masksToBounds=YES;
    lb0bg.layer.cornerRadius=5;
    [tableView addSubview:lb0bg];
    
    UIImageView *mainView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30,100, 100)];
    mainView.backgroundColor =button_bgcolor;
    mainView.layer.cornerRadius = 5;
    mainView.userInteractionEnabled = YES;
    [tableView addSubview:mainView];
    
    UILabel *lbtxt0=[[UILabel alloc]init];
    [lbtxt0 setFrame:CGRectMake(mainView.frame.origin.x+mainView.frame.size.width+10, mainView.frame.origin.y-15, lb0bg.frame.size.width-135, 55)];
    lbtxt0.backgroundColor=[UIColor clearColor];
    [lbtxt0 setText:@"下次升級："];
    lbtxt0.textColor=[UIColor redColor];
    lbtxt0.font=[lbtxt0.font fontWithSize:20];
    [tableView addSubview:lbtxt0];
    
    UIButton *rankUP=[[UIButton alloc]init];
    rankUP.tag=0;
    [rankUP setTitle:@"升級樹苗" forState:UIControlStateNormal];
    rankUP.backgroundColor=button_bgcolor_orange;
    [rankUP setFrame:CGRectMake(mainView.frame.origin.x+mainView.frame.size.width+10, mainView.frame.origin.y+60, (lb0bg.frame.size.width-135)/2-5, 40)];
    rankUP.layer.cornerRadius=5;
    [rankUP addTarget:self action:@selector(section0Fun:) forControlEvents:UIControlEventTouchUpInside];
    [tableView addSubview:rankUP];
    
    
    UIButton *rankRD=[[UIButton alloc]init];
    rankRD.tag=1;
    [rankRD setTitle:@"積分紀錄" forState:UIControlStateNormal];
    rankRD.backgroundColor=button_bgcolor;
    [rankRD setFrame:CGRectMake(rankUP.frame.origin.x+rankUP.frame.size.width+10, mainView.frame.origin.y+60, (lb0bg.frame.size.width-135)/2-5, 40)];
    rankRD.layer.cornerRadius=5;
    [rankRD addTarget:self action:@selector(section0Fun:) forControlEvents:UIControlEventTouchUpInside];
    [tableView addSubview:rankRD];
    
    
    
    //section 1
    
    UILabel *lb1bg=[[UILabel  alloc]init];
    lb1bg.backgroundColor=[UIColor whiteColor];
    [lb1bg setFrame:CGRectMake(20,lb0bg.frame.size.height+lb0bg.frame.origin.y+20, aScreenRect.size.width-40, 85)];
    lb1bg.layer.masksToBounds=YES;
    lb1bg.layer.cornerRadius=5;
    [tableView addSubview:lb1bg];
    
    UILabel *lbtxt1=[[UILabel alloc]init];
    lbtxt1.text=@"車神";
    [lbtxt1 setFrame:CGRectMake(0, 0, lb1bg.frame.size.width, 50)];
    lbtxt1.textAlignment = NSTextAlignmentCenter;
    lbtxt1.font=[lbtxt1.font fontWithSize:20];
    lbtxt1.textColor=[UIColor colorWithRed:49/255.0 green:70/255.0 blue:63/255.0 alpha:1];
    [lb1bg addSubview:lbtxt1];
    
    UILabel *lbtxt2=[[UILabel alloc]init];
    lbtxt2.text=@"可以領取以下獎勵";
    [lbtxt2 setFrame:CGRectMake(0, 50, lb1bg.frame.size.width, 35)];
    lbtxt2.textAlignment = NSTextAlignmentCenter;
    [lb1bg addSubview:lbtxt2];
    
    
    //section2
    
    


    



}

-(void)section0Fun:(id)sender{
    //
    UIButton *btn=sender;
    switch (btn.tag) {
        case 0:
            //
            break;
        case 1:
            //
            break;
        default:
            //
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// YI Slide menu
-(void)YImenuSetUP{
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];

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
    slideMenu.navTitleLabel.text=@"積分獎勵";
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, aScreenRect.size.width, aScreenRect.size.height-150) style:UITableViewStylePlain];
    [slideMenu.centerView addSubview:tableView];
    
    
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
    
    return cellValue;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellId = @"CellId";
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellId];
        
        //        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    
    //樣式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row==0) {
        cell.backgroundColor=floor_bgcolor;

    }
    
    else{
    
        cell.backgroundColor=floor_bgcolor;
//        cell.textLabel.text=slideMenu.navTitleLabel.text;
//        cell.detailTextLabel.text=@"detial";
        cell.detailTextLabel.numberOfLines=0;
        
        UILabel *cellLB=[[UILabel alloc]init];
        [cellLB setFrame:CGRectMake(20, 0, aScreenRect.size.width-40, 60)];
        cellLB.backgroundColor=[UIColor whiteColor];
        [cellLB setText:@"  rank"];
        [cell.contentView addSubview:cellLB];
        
        if (indexPath.row==1) {
            UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:cellLB.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
            CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = cellLB.bounds;
            maskLayer.path = maskPath.CGPath;
            cellLB.layer.mask = maskLayer;

        }
        
        if (indexPath.row==cellValue-1) {
            UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:cellLB.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
            CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = cellLB.bounds;
            maskLayer.path = maskPath.CGPath;
            cellLB.layer.mask = maskLayer;

        }
       
        
        UIButton *cellBtn=[[UIButton alloc]init];
        cellBtn.tag=indexPath.row;
        [cellBtn setTitle:@"領取" forState:UIControlStateNormal];
        cellBtn.backgroundColor=button_bgcolor_orange;
    
        [cellBtn setFrame:CGRectMake(aScreenRect.size.width-80, 10, 50,40 )];
        cellBtn.layer.cornerRadius=5;
        [cellBtn addTarget:self action:@selector(cellBtnFun:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:cellBtn];
        
       

    }
    
    return cell;
}

-(void)cellBtnFun:(id)sender{
    UIButton *btn=sender;
    switch (btn.tag) {
        case 0:
            //
            break;
        case 1:
            //
            break;
        default:
            //
            break;
    }


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 280;
    }
    else {
        return 60;
        
        
    }
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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
