//
//  screenConditionPage.m
//  driver
//
//  Created by 倪志鹏 on 16/3/29.
//  Copyright © 2016年 倪志鹏. All rights reserved.
//

#import "screenConditionPage.h"
#import "style.h"
#import "ZHPickView.h"



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

@interface screenConditionPage ()<UITableViewDelegate,UITableViewDataSource,YiSlideMenuDelegate>{
    
    
    
    //YiSlideMenu
    UITableView *tableView;
    YiSlideMenu *slideMenu;
    //ZHPickView *pickerView;
}



@end

@implementation screenConditionPage

static BOOL click0=true;
//const BOOL click1=false;
bool btn1Setected;
bool btn2Setected;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    // [navigationArray removeAllObjects];    // This is just for remove all view controller from navigation stack.
    [navigationArray removeObjectAtIndex: 0];  // You can pass your index here
    self.navigationController.viewControllers = navigationArray;
    
    btn1Setected=NO;
    btn2Setected=NO;
    
    [self YImenuSetUP];
    [self viewItem];
    
    
}

int choosPicker=0;
NSString *btntext= @"請選擇";
NSString *btntext2= @"請選擇";


-(void)viewItem{
    
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    // Do any additional setup after loading the view.
    
    //tableView.backgroundColor=[UIColor clearColor];
    tableView.userInteractionEnabled=YES;
    //self.view.userInteractionEnabled=YES;
    //tableView.hidden=YES;
    
    slideMenu.navRightBt.hidden=NO;
    [slideMenu.navRightBt setTitle:@"完成" forState:UIControlStateNormal];
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UILabel *title=[[UILabel alloc]init];
    int titleWidth=320;
    [title setFrame:CGRectMake(aScreenRect.size.width/2-titleWidth/2, 40, titleWidth, 40)];
    title.text=@"請勾選看單條件";
    title.font = [UIFont systemFontOfSize:35];
    UIColor *color = font_titleColor;
    [title setTextColor:color];
    title.textAlignment = NSTextAlignmentCenter;
    //title.backgroundColor=[UIColor redColor];
    [tableView addSubview:title];
    
    
    
    for (int i=0; i<2; i++) {
        UITableViewCell *Mainform =[[UITableViewCell alloc]init];
        int formHeight=60;
        [Mainform setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+70+i*formHeight, 320, formHeight)];
        //Mainform.textLabel.text=@"123";
        Mainform.backgroundColor=[UIColor whiteColor];
        [tableView addSubview:Mainform];
        
        if (i==0) {
            UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:Mainform.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
            CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = Mainform.bounds;
            maskLayer.path = maskPath.CGPath;
            Mainform.layer.mask = maskLayer;
            
        }
        
        if (i==1) {
            UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:Mainform.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
            CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = Mainform.bounds;
            maskLayer.path = maskPath.CGPath;
            Mainform.layer.mask = maskLayer;
        }
        
        
        
        UIButton *chkbox=[[UIButton alloc]init];
        [chkbox setFrame:CGRectMake(Mainform.frame.origin.x+10, Mainform.frame.origin.y+16.5, 25, 25)];
        chkbox.backgroundColor=[UIColor clearColor];
        chkbox.tag=i+1000;
        
        if (chkbox.tag==1000) {
            if (btn1Setected) {
                chkbox.selected=YES;
            }
            else{
                chkbox.selected=NO;
            }
        }
        
        if (chkbox.tag==1001) {
            if (btn2Setected) {
                chkbox.selected=YES;
            }
            else{
                chkbox.selected=NO;
            }

        }
        
        [chkbox setBackgroundImage:[UIImage imageNamed:@"unckecked.png"]
                            forState:UIControlStateNormal];
        [chkbox setBackgroundImage:[UIImage imageNamed:@"checked.png"]
                            forState:UIControlStateSelected];
        [chkbox setBackgroundImage:[UIImage imageNamed:@"checked.png"]
                            forState:UIControlStateHighlighted];
        chkbox.adjustsImageWhenHighlighted=YES;
        
        
        [chkbox addTarget:self
                   action:@selector(chkboxAction:)
         forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        
        [tableView addSubview:chkbox];
        
        
        UIButton * pickResult=[[UIButton alloc]init];
        [pickResult setFrame:CGRectMake(Mainform.frame.origin.x+160, Mainform.frame.origin.y+8, 75, 40)];
        pickResult.backgroundColor=[UIColor clearColor];
        [pickResult setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        pickResult.tag=i;
        [pickResult addTarget:self
                       action:@selector(pickResultAction:)
             forControlEvents:UIControlEventTouchUpInside];
        [tableView addSubview:pickResult];
        
        switch (i) {
            case 0:
                Mainform.textLabel.text=@"      距離目前位置:                       公里內";
                NSLog(@"%@",btntext);
                [pickResult setTitle:btntext forState:UIControlStateNormal];
                break;
            case 1:
                Mainform.textLabel.text=@"      設定目的地為:                       的訂單";
                [pickResult setTitle:btntext2 forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        
    }
    
    
    
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    if (choosPicker==1) {
        //NSLog(@"click");
        //NSLog(@"RS:%@", [resultString substringToIndex:3]);
        btntext2=[resultString substringToIndex:3];
        [self viewItem];
    }
    else{
        btntext=resultString;
        [self viewItem];
    }
    
    
}

- (void)chkboxAction:(id)sender
{
    //Write a code you want to execute on buttons click event
    
    
    
    UIButton *btn = (UIButton *) sender;
    if([btn isSelected]){ [btn setSelected:NO]; }else{ [btn setSelected:YES];}
    if (btn.tag==1000) {
        if (btn.selected) {
            btn1Setected=YES;
        }
        else{
            btn1Setected=NO;
        }
    }
    if (btn.tag==1001) {
        if (btn.selected) {
            btn2Setected=YES;
        }
        else{
            btn2Setected=NO;
        }
    }

    NSLog(@"IN:%ld",(long)btn.tag);
//    switch (btn.tag) {
//        case 1000:
//             NSLog(@"chk100");
//            if([btn isSelected]){ [btn setSelected:NO]; }else{ [btn setSelected:YES];}
//            NSLog(@"tag:%ld,select:%d",btn.tag,btn.selected);
//
//            break;
//        case 1001:
//             NSLog(@"chk101");
//            if([btn isSelected]){ [btn setSelected:NO]; }else{ [btn setSelected:YES];}
//            NSLog(@"tag:%ld,select:%d",btn.tag,btn.selected);
//
//            break;
//            
//        default:
//            break;
//    }

    
}

//pickResultAction:
- (void)pickResultAction:(id)sender
{
    UIButton *btn=sender;
    switch (btn.tag) {
            
        case 1:
            
            //Write a code you want to execute on buttons click event
            //NSLog(@"pkrs");
            
            [_pickview remove];
            choosPicker = 1;
            _pickview=[[ZHPickView alloc] initPickviewWithPlistName:@"TW_city" isHaveNavControler:NO];
            _pickview.delegate = self;
            
            [tableView addSubview:_pickview];
            
            break;
            
            
        case 0:
            
            [_pickview remove];
            choosPicker = 2;
            NSMutableArray *value = [[NSMutableArray alloc] init];
            for (int i = 1; i <= 10; i++) {
                [value addObject:[NSString stringWithFormat:@"%d",i]];
            }
            NSArray *vValue = [NSArray arrayWithArray:value];
            _pickview = [[ZHPickView alloc] initPickviewWithArray:vValue isHaveNavControler:NO];
            _pickview.delegate=self;
//            [_pickview show];
             [tableView addSubview:_pickview];
            break;
    }
    
    
}



-(void)toobarCancelBtnHaveClick:(ZHPickView *)pickView{
    //choosPicker = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





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
    slideMenu.navTitleLabel.text=@"訂單篩選";
    
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



-(void)passView:(UIViewController *)passView{
    NSLog(@"ScreenConditionppage");
    [self.navigationController pushViewController:passView animated:YES];
    
}

-(void)viewDidDisappear:(BOOL)animated {

    [_pickview remove];
}


@end
