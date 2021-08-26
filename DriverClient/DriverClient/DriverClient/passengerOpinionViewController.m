//
//  passengerOpinionViewController.m
//  DriverClient
//
//  Created by 黃柏鈞 on 2016/7/8.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "passengerOpinionViewController.h"
#import "style.h"
@interface passengerOpinionViewController (){

UIScrollView* scrollView;
}

@end

@implementation passengerOpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=floor_bgcolor;
    self.navigationController.navigationBar.barTintColor = title_bgcolor;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title=@"乘客評語";
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIImage *navImg=[UIImage imageNamed:@"arrows.png"];
    int navBtnWdith=40;
    int navBtnHeight=40;
    UIGraphicsBeginImageContext(CGSizeMake(navBtnWdith, navBtnHeight));
    [navImg drawInRect:CGRectMake(0, 0, navBtnWdith, navBtnHeight)];
    UIImage *resizeImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIBarButtonItem *navLeftbtn=[[UIBarButtonItem alloc]initWithImage:resizeImage
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(backBtnPressed)];
    
    self.navigationItem.leftBarButtonItem = navLeftbtn;
    
    
    
    //多少東西
    int tableValue=50;
    int tableHeight=100;
    
    
    //滑滑滑
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor = floor_bgcolor;
    scrollView.scrollEnabled = YES;
    int scHeight=tableValue*tableHeight+200;//螢幕最小長度
    if (self.view.frame.size.height<scHeight) {
        scHeight=scHeight;
    }
    else{
        scHeight=self.view.frame.size.height;
    }
    
    scrollView.contentSize = CGSizeMake(320, scHeight);
    //scrollView.backgroundColor=[UIColor redColor];
    //NSLog(@"%f",self.view.bounds.size.height);
    [self.view addSubview:scrollView];

   
    //打底
    
    UILabel *mainForm=[[UILabel alloc]init];
    [mainForm setFrame:CGRectMake(aScreenRect.size.width/2-160, 40, 320, tableHeight*tableValue+30+20)];
    mainForm.backgroundColor=[UIColor whiteColor];
    mainForm.layer.masksToBounds = YES;
    mainForm.layer.cornerRadius=5;
    [scrollView addSubview:mainForm];
    
   
    
    //標題
    UILabel *title=[[UILabel alloc]init];
    [title setFrame:CGRectMake(10, 10, 320, 20)];
    title.backgroundColor=[UIColor whiteColor];
    title.text=@"乘客評語:";
    title.textColor=font_labelTitleColor;
    [mainForm addSubview:title];
    
   
    //評語
    for (int i=0; i<tableValue; i++) {
        UILabel *passengerSay=[[UILabel alloc]init];
        [passengerSay setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+40+i*tableHeight, 320, 20)];
        passengerSay.backgroundColor=[UIColor whiteColor];
        passengerSay.text=@"乘客說";
        [mainForm addSubview:passengerSay];
        
        UILabel *passengerSay2=[[UILabel alloc]init];
        [passengerSay2 setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+60+i*tableHeight+30, 320, 20)];
        passengerSay2.backgroundColor=[UIColor whiteColor];
        passengerSay2.text=@"服務很好";
        [mainForm addSubview:passengerSay2];
        
        UILabel *scoreDate=[[UILabel alloc]init];
        [scoreDate setFrame:CGRectMake(title.frame.origin.x+100, title.frame.origin.y+40+i*tableHeight, 320, 20)];
        scoreDate.backgroundColor=[UIColor whiteColor];
        scoreDate.text=@"yyyy/mm/dd";
        [mainForm addSubview:scoreDate];
        
        for (int j=0; j<5; j++) {
            UIImageView *score=[[UIImageView alloc]init];
            [score setFrame:CGRectMake(title.frame.origin.x+250+j*18, scoreDate.frame.origin.y+40, 15, 15)];
//            score.backgroundColor=[UIColor redColor];
            score.tag=i;
            [scrollView  addSubview:score];
            
            UIImage*star=[UIImage imageNamed:@"aStar_orange.png"];
            [score setImage:star];

        }

        
        
        if(i>0){
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(mainForm.frame.size.width/2-(320-40)/2,passengerSay.frame.origin.y-10, 320-40, 1)];
            lineView.backgroundColor = floor_bgcolor;
            [mainForm addSubview:lineView];
        }

    }
    
    

}

-(void)backBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    //initData
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
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
