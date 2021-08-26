//
//  aboutViewController.m
//  userClient
//
//  Created by 黃柏鈞 on 2016/7/2.
//  Copyright © 2016年 倪志鹏. All rights reserved.
//

#import "myAccountViewController.h"
#import "style.h"
#import "MBProgressHUD.h"
#import "APIController.h"
#import "PublicController.h"
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
#import "Cydia.h"
#import "InfLog.h"
#import "Credentials.h"

//toast
#import "UIView+Toast.h"

#import "editPwdViewController.h"
#import "editDriverInfoViewController.h"
#import "passengerOpinionViewController.h"
#import "RecommendFriends.h"
@interface myAccountViewController ()<UITableViewDelegate,UITableViewDataSource,YiSlideMenuDelegate>{
    float width,height;
    
    
    
    //YiSlideMenu
    UITableView *tableView;
    YiSlideMenu *slideMenu;
    
}


@end

@implementation myAccountViewController

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
    int formHeight=60*6;
    [Mainform setFrame:CGRectMake(aScreenRect.size.width/2-320/2,20, 320, formHeight+60)];
    //Mainform.textLabel.text=@"123";
    Mainform.backgroundColor=[UIColor whiteColor];
    Mainform.layer.cornerRadius=5;
    [tableView addSubview:Mainform];
    
    
    for (int i=0; i<7; i++) {
        UITableViewCell *Mainform =[[UITableViewCell alloc]init];
        int formHeight=60;
        [Mainform setFrame:CGRectMake(aScreenRect.size.width/2-320/2,formHeight+i*(formHeight)-40, 320, formHeight)];
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
        chkbox.layer.cornerRadius=5;
        chkbox.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [tableView addSubview:chkbox];
        
        if(i>0){
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((aScreenRect.size.width-320+40)/2,formHeight+formHeight*i-40, 320-40, 1)];
            lineView.backgroundColor = floor_bgcolor;
            [tableView addSubview:lineView];
        }
        
        
        [chkbox setTitleColor:font_labelTitleColor forState:UIControlStateNormal];
        switch (i) {
            case 0:
                [chkbox setTitle:@"     修改密碼" forState:UIControlStateNormal];
                break;
            case 1:
                [chkbox setTitle:@"     編輯司機資料" forState:UIControlStateNormal];
                break;
            case 2:
                [chkbox setTitle:@"     客戶評語" forState:UIControlStateNormal];
                break;
            case 3:
                [chkbox setTitle:@"     選擇身份" forState:UIControlStateNormal];
                break;
            case 4:
                [chkbox setTitle:@"     司機登錄" forState:UIControlStateNormal];
                break;
            case 5:
                [chkbox setTitle:@"     上傳證件及資料" forState:UIControlStateNormal];
                break;
            case 6:
                [chkbox setTitle:@"     我推薦的好友" forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
        
    }
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)chkboxAction:(id)sender
{
    //Write a code you want to execute on buttons click event
    //NSLog(@"chk");
    UIButton *btn=sender;
    UIViewController *selectPage;
    switch (btn.tag) {
        case 0:
            
        {

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"請輸入密碼" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];

            alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            
            [alert show];
            

        }
            break;
            
        case 1:
            selectPage=[[editDriverInfoViewController alloc]init];
            break;
            
        case 2:
            selectPage=[[passengerOpinionViewController alloc]init];
            break;
            
        case 3:
            selectPage=[[Cydia alloc]init];
            break;
            
        case 4:
            selectPage=[[InfLog alloc]init];
            break;
            
        case 5:
            selectPage=[[Credentials alloc]init];
            break;
        case 6:
            selectPage=[[RecommendFriends alloc]init];
            break;
            
        default:
            break;
            
    }
    [self.navigationController pushViewController:selectPage animated:YES];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 1:
        {
            
            //得到输入框
            UITextField *tf=[alertView textFieldAtIndex:0];
            NSLog(@"%@",tf.text);
            
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSDictionary  *dictSave = [userDefaults valueForKey:@"userReg"];
            NSString *phoneSave = [dictSave valueForKey:@"phone"];
            
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSString *phone = phoneSave;
            NSString *old_password = tf.text;
            NSString *opass = [PublicController md5:old_password];
            NSDictionary *dict = @{@"phone":phone,@"old_password":opass};
            NSDictionary *result = [APIController AccountCheck:dict];
            NSString *status = [NSString stringWithFormat:@"%@",[result objectForKey:@"status"]];
            if ([status isEqualToString:@"fail"]) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [self.view makeToast:@"密碼輸入錯誤！"];
                NSLog(@"%@",result);
                
            }else{
                NSLog(@"%@",result);
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
                editPwdViewController *nVE = [[editPwdViewController alloc]init];
                [self.navigationController pushViewController:nVE animated:YES];
                
            }
            
            
        }
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
    slideMenu.navTitleLabel.text=@"我的帳戶";
    
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
