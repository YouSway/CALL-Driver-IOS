//
//  aboutViewController.m
//  userClient
//
//  Created by 黃柏鈞 on 2016/7/2.
//  Copyright © 2016年 倪志鹏. All rights reserved.
//

#import "ConsumerSupportViewController.h"
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

#import "suggestionViewController.h"

//toast
#import "UIView+Toast.h"

#import "contrastViewController.h"
#import "GeneralQuestionViewController.h"
@interface ConsumerSupportViewController ()<UITableViewDelegate,UITableViewDataSource,YiSlideMenuDelegate>{
    float width,height;
    
    //YiSlideMenu
    UITableView *tableView;
    YiSlideMenu *slideMenu;
    
}


@end

@implementation ConsumerSupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=floor_bgcolor;
    
    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    // [navigationArray removeAllObjects];    // This is just for remove all view controller from navigation stack.
    [navigationArray removeObjectAtIndex: 0];  // You can pass your index here
    self.navigationController.viewControllers = navigationArray;
    
    [self YImenuSetUP];
    // Do any additional setup after loading the view.
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    
    UITableViewCell *Mainform =[[UITableViewCell alloc]init];
    int formHeight=180;
    [Mainform setFrame:CGRectMake(aScreenRect.size.width/2-320/2,60, 320, formHeight)];
    //Mainform.textLabel.text=@"123";
    Mainform.backgroundColor=[UIColor whiteColor];
    Mainform.layer.cornerRadius=5;
    [tableView addSubview:Mainform];
    
    
    for (int i=0; i<3; i++) {
        UITableViewCell *Mainform =[[UITableViewCell alloc]init];
        int formHeight=60;
        [Mainform setFrame:CGRectMake(aScreenRect.size.width/2-320/2,formHeight+i*(formHeight), 320, formHeight)];
        //Mainform.textLabel.text=@"123";
        Mainform.backgroundColor=[UIColor clearColor];
        [tableView addSubview:Mainform];
        
        UIButton *chkbox=[[UIButton alloc]init];
        [chkbox setFrame:CGRectMake(Mainform.frame.origin.x, Mainform.frame.origin.y, 320, 60)];
        chkbox.backgroundColor=[UIColor whiteColor];
        chkbox.tag=i;
        [chkbox addTarget:self
                   action:@selector(chkboxAction:)
         forControlEvents:UIControlEventTouchUpInside];
        //chkbox.layer.cornerRadius=5;
        chkbox.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [tableView addSubview:chkbox];
        
        

        UIImageView *imgFrame=[[UIImageView alloc]init];
        [imgFrame setImage:[UIImage imageNamed:@"rightArrows"]];
        [imgFrame setFrame:CGRectMake(Mainform.frame.origin.x+280, Mainform.frame.origin.y+20, 20, 20)];
        [tableView addSubview:imgFrame];
        
        if(i>0){
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((aScreenRect.size.width-320+40)/2,formHeight+formHeight*i, 320-40, 1)];
            lineView.backgroundColor = floor_bgcolor;
            [tableView addSubview:lineView];
        }
        
        
        [chkbox setTitleColor:font_labelTitleColor forState:UIControlStateNormal];
        switch (i) {
            case 0:
                [chkbox setTitle:@"     常見問題" forState:UIControlStateNormal];
                chkbox.layer.cornerRadius=5;
                
                break;
            case 1:
                [chkbox setTitle:@"     會員條款" forState:UIControlStateNormal];
                break;
            case 2:
                [chkbox setTitle:@"     提供意見" forState:UIControlStateNormal];
                chkbox.layer.cornerRadius=5;
                break;
                
            default:
                break;
        }
        
    }
    
    UILabel *ps =[[UILabel alloc]init];
    [ps setFrame:CGRectMake(50, 280, 150, 20)];
    ps.text=@"以電郵聯絡我們";
    ps.textColor=[UIColor grayColor];
    //myLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:8.0];
    [tableView addSubview:ps];
    
    UILabel *ps2 =[[UILabel alloc]init];
    [ps2 setFrame:CGRectMake(50, 280+25, 150, 20)];
    ps2.text=@"Templar@dmd.com";
    ps2.textColor=RGBACOLOR(113, 163, 191, 1);
    [tableView addSubview:ps2];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)chkboxAction:(id)sender
{
    UIButton *btn=sender;
    UIViewController *selectPage;
    switch (btn.tag) {
        case 0:
            selectPage=[[GeneralQuestionViewController alloc]init];
            [self.navigationController pushViewController:selectPage animated:YES];
            break;
            
        case 1:
            selectPage=[[contrastViewController alloc]init];
            
            [self.navigationController pushViewController:selectPage animated:YES];
            break;
            
        case 2:
            
            selectPage=[[suggestionViewController alloc]init];
            
            [self.navigationController pushViewController:selectPage animated:YES];
            
            break;
            
        default:
            break;
    }
}


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
    slideMenu.navTitleLabel.text=@"客戶支援";
    
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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
