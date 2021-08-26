//
//  aboutViewController.m
//  userClient
//
//  Created by 黃柏鈞 on 2016/7/2.
//  Copyright © 2016年 倪志鹏. All rights reserved.
//

#import "newNewsViewController.h"
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

#import "aboutViewController.h"
#import "myAccountViewController.h"
#import "newNewsSvcViewController.h"
//toast
#import "UIView+Toast.h"

@interface newNewsViewController  ()<UITableViewDelegate,UITableViewDataSource,YiSlideMenuDelegate>{
    float width,height;
    
    //YiSlideMenu
    UITableView *YItableView;
    YiSlideMenu *slideMenu;
    
}


@end

@implementation newNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=floor_bgcolor;
    
    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    // [navigationArray removeAllObjects];    // This is just for remove all view controller from navigation stack.
    [navigationArray removeObjectAtIndex: 0];  // You can pass your index here
    self.navigationController.viewControllers = navigationArray;
    
    [self YImenuSetUP];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];

    self.navigationController.navigationBar.hidden=YES;
    

    
    UILabel *bgView=[[UILabel alloc]init];
    bgView.backgroundColor=[UIColor whiteColor];
    [bgView setFrame:CGRectMake(aScreenRect.size.width/2-160, 20 , 320, aScreenRect.size.height-120)];
    bgView.layer.masksToBounds=YES;
    bgView.layer.cornerRadius=5;
    
    
    slideMenu = [[YiSlideMenu alloc] initWithFrame:CGRectMake(0,0, WScreen, HScreen)];
    [self.view addSubview:slideMenu];
    slideMenu.slideMenuDelegate=self;
    slideMenu.navTitleLabel.text=@"最新通知";
    
    YItableView=[[UITableView alloc] initWithFrame:CGRectMake(aScreenRect.size.width/2-150, 20 , 300, aScreenRect.size.height-130) style:UITableViewStylePlain];
    
    [slideMenu.centerView addSubview:bgView];
    [slideMenu.centerView addSubview:YItableView];
    
    
        YItableView.rowHeight=aScreenRect.size.height*2;
    YItableView.dataSource=self;
    YItableView.delegate=self;
    
    if (iOS7) {
        [YItableView setSeparatorInset:UIEdgeInsetsZero];
    }
    YItableView.showsVerticalScrollIndicator=NO;
    
    YItableView.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=floor_bgcolor;
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
//設定表格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellId];
        
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    cell.textLabel.text=slideMenu.navTitleLabel.text;
    cell.detailTextLabel.text=@"newNews";
    cell.detailTextLabel.numberOfLines=0;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    newNewsSvcViewController *nsVc=[[newNewsSvcViewController alloc]init];
    [self.navigationController pushViewController:nsVc animated:YES ];
    
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
