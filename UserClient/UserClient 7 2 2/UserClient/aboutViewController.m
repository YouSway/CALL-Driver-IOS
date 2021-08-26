//
//  aboutViewController.m
//  userClient
//
//  Created by 黃柏鈞 on 2016/7/2.
//  Copyright © 2016年 倪志鹏. All rights reserved.
//

#import "aboutViewController.h"
#import "style.h"

//YiSlideMenu
#import "ViewController.h"
#import "YiLeftView.h"
#import "YiRightView.h"
#import "YiSlideMenu.h"
#import "NextViewController.h"
#import "Header.h"



//toast
#import "UIView+Toast.h"

@interface aboutViewController ()<UITableViewDelegate,UITableViewDataSource,YiSlideMenuDelegate>{
    float width,height;
    
    //YiSlideMenu
    UITableView *tableView;
    YiSlideMenu *slideMenu;
    
}


@end

@implementation aboutViewController

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

    UIWebView *mainGround=[[UIWebView alloc]init];
    mainGround.backgroundColor=[UIColor whiteColor];
    [mainGround setFrame:CGRectMake(20, 20, aScreenRect.size.width-40, aScreenRect.size.height-120)];
    mainGround.layer.masksToBounds=YES;
    mainGround.layer.cornerRadius=5;
    [tableView addSubview:mainGround];
    
    NSString *urlNameInString = @"https://www.apple.com";
    NSURL *url = [NSURL URLWithString:urlNameInString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [mainGround loadRequest:urlRequest];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// YI Slide menu
-(void)YImenuSetUP{
    //YiSlideMenu
    // Do any additional setup after loading the view, typically from a nib.
   // UINavigationController *nav = nil;
   // aboutViewController *main = [[aboutViewController alloc]init];
    //nav = [[UINavigationController alloc] initWithRootViewController:main];
    
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    self.navigationController.navigationBar.hidden=YES;
    
    slideMenu = [[YiSlideMenu alloc] initWithFrame:CGRectMake(0,0, WScreen, HScreen)];
    [self.view addSubview:slideMenu];
    slideMenu.slideMenuDelegate=self;
    slideMenu.navTitleLabel.text=@"關於第一幫";
    
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
    slideMenu.navRightBt.hidden=YES;
    
    
    
    
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
