//
//  YiSlideMenu.m
//  YiSlideMenu
//
//  Created by apple on 15/3/9.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "YiSlideMenu.h"
#import "YiLeftView.h"
#import "YiRightView.h"
#import "style.h"
#define LeftWidth ([[UIScreen mainScreen] bounds].size.width/2.0+50)
#define RightWidth ([[UIScreen mainScreen] bounds].size.width/2.0+50)

#import "funcChoosePage.h"


#import "ConsumerSupportViewController.h"
#import "newNewsViewController.h"
#import "aboutViewController.h"
#import "myAccountViewController.h"
#import "pastBillViewController.h"

#import "UIView+Toast.h"


//#define RightWidth ([[UIScreen mainScreen] bounds].size.width/2.0+50)


@interface YiSlideMenu ()<UIScrollViewDelegate,YiLeftViewDelegate,YiRightViewDelegate>{
    //@interface YiSlideMenu ()<UIScrollViewDelegate,YiLeftViewDelegate>{


    UIView *leftBgView;
     UIView *centerBgView;
    UIView *rightBgView;
    float viewWidth;
    float viewHeight;

}

@property (strong, nonatomic) funcChoosePage *funcCP;
//@property (strong, nonatomic) screenConditionPage *screenCP;
//@property (strong, nonatomic) waitForRunViewController *waitFRVC;
//@property (strong, nonatomic) pastBillViewController *pastBVC;
@property (strong, nonatomic) ConsumerSupportViewController *consumerSVC;
@property (strong, nonatomic) newNewsViewController *newwSVC;
@property (strong, nonatomic) aboutViewController *aboutVC;
@property (strong, nonatomic) myAccountViewController *myAVC;
@property (strong, nonatomic) pastBillViewController *pastVC;

@end

@implementation YiSlideMenu
@synthesize centerView,navLeftBt,navRightBt,navTitleLabel;
- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        //        添加界面元素。
        
         viewWidth=frame.size.width;
         viewHeight=frame.size.height;
       
        self.alwaysBounceHorizontal=YES;
        self.bounces = YES;
        self.pagingEnabled = YES;
        self.delegate=self;
        self.userInteractionEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        
        
        leftBgView=[[UIView alloc] init];
        leftBgView.frame = CGRectMake((viewWidth * 0) , 0, viewWidth, viewHeight);
        leftBgView.clipsToBounds=YES;
        //leftBgView.backgroundColor=floor_bgcolor;
        [self addSubview:leftBgView];
        
        YiLeftView *leftView=[[YiLeftView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-LeftWidth , 0, LeftWidth, viewHeight)];
        leftView.clipsToBounds=YES;
        leftView.delegate=self;
        //leftView.backgroundColor=floor_bgcolor;
        [leftBgView addSubview:leftView];
        
        
        
        centerBgView=[[UIView alloc] init];
        centerBgView.frame = CGRectMake(viewWidth , 0, viewWidth, viewHeight);
        centerBgView.clipsToBounds=YES;
        [self addSubview:centerBgView];
        
        centerView=[[UIView alloc] init];
        centerView.frame = CGRectMake(0 , 64, viewWidth, viewHeight-64);
        [centerBgView addSubview:centerView];
        //centerView.backgroundColor=floor_bgcolor;
        
        UIView *navBar=[[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 64)];
        navBar.backgroundColor=title_bgcolor;
        [centerBgView addSubview:navBar];
        
        
        UIImage *navLeftbtnImage = [UIImage imageNamed:@"three.png"];
        
        navLeftBt=[UIButton buttonWithType:UIButtonTypeCustom];
        [navBar addSubview:navLeftBt];
        navLeftBt.frame=CGRectMake(10, 22+5, 28, 28);
        [navLeftBt setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
        navLeftBt.layer.masksToBounds=YES;
        //navLeftBt.layer.cornerRadius=15;
        navLeftBt.backgroundColor=[UIColor clearColor];
        [navLeftBt setImage:navLeftbtnImage forState:UIControlStateNormal];
        [navLeftBt addTarget:self action:@selector(navLeftBtAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        navRightBt=[UIButton buttonWithType:UIButtonTypeCustom];
        [navBar addSubview:navRightBt];
        navRightBt.frame=CGRectMake(viewWidth-40, 22, 40, 40);
        [navRightBt setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
        //navRightBt.backgroundColor=[UIColor redColor];
        [navRightBt addTarget:self action:@selector(navRightBtAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        navTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake((viewWidth-120)/2, 20, 120, 44)];
        [navBar addSubview:navTitleLabel];
        navTitleLabel.font=[UIFont boldSystemFontOfSize:19];
        navTitleLabel.textAlignment=UITextAlignmentCenter;
        navTitleLabel.textColor=[UIColor whiteColor];
        
        
        
        rightBgView=[[UIView alloc] init];
        rightBgView.frame = CGRectMake((viewWidth * 2), 0, viewWidth, viewHeight);
        rightBgView.clipsToBounds=YES;
        [self addSubview:rightBgView];
        rightBgView.backgroundColor=[UIColor whiteColor];

        
        
        YiRightView *rightView=[[YiRightView alloc] initWithFrame:CGRectMake(0 , 0, RightWidth, viewHeight)];
        rightView.clipsToBounds=YES;
        rightView.delegate=self;
        [rightBgView addSubview:rightView];
        
        
        
        [self setContentSize:CGSizeMake(viewWidth * (2), 0)];
        [self scrollRectToVisible:CGRectMake(viewWidth,0,viewWidth,viewHeight) animated:NO];
        [self setContentOffset:CGPointMake(viewWidth,0)];
        
        
        
    }
    return self;
}
-(void)navLeftBtAction{

    if (self.contentOffset.x<=(viewWidth-LeftWidth)) {
         [self setContentOffset:CGPointMake(viewWidth,0) animated:YES];
        
       

    }else if (self.contentOffset.x>=([[UIScreen mainScreen] bounds].size.width+0)){
             [self setContentOffset:CGPointMake(viewWidth-LeftWidth,0) animated:YES];


    }
    
    //NSLog(@"left menu btn click");
}
-(void)navRightBtAction{
    /*
    if (self.contentOffset.x>=(viewWidth+RightWidth)) {
        [self scrollRectToVisible:CGRectMake(viewWidth+0,0,viewWidth,viewHeight-64) animated:YES];
        [self setContentOffset:CGPointMake(viewWidth,0) animated:YES];

        
    }else if (self.contentOffset.x<=(viewWidth+0)){
        [self scrollRectToVisible:CGRectMake(viewWidth+RightWidth,0,viewWidth,viewHeight-64) animated:YES];
        [self setContentOffset:CGPointMake(viewWidth+RightWidth,0) animated:YES];

        
        
    }
     */
    
    NSLog(@"click");
}

//只要滚动了就会触发

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{


    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    //NSLog(@"%f",aScreenRect.size.width);
        if (scrollView.contentOffset.x<(viewWidth-LeftWidth)) {
            scrollView.contentOffset=CGPointMake(viewWidth-LeftWidth, 0);
          

        }
        else if (scrollView.contentOffset.x>(aScreenRect.size.width)){
            scrollView.contentOffset=CGPointMake(aScreenRect.size.width, 0);
            scrollView.scrollEnabled=NO;
}
      scrollView.scrollEnabled=YES;
    //scrollView.contentOffset=CGPointMake(aScreenRect.size.width, 0);
}





- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.frame.size.width;
    int currentPage= floor((self.contentOffset.x - pagewidth/ (3)) / pagewidth) +1;


    if (currentPage==0)
    {
       
        [self scrollRectToVisible:CGRectMake(viewWidth-LeftWidth,0,viewWidth,viewHeight-64) animated:NO]; // 最后+1,循环第1页
    }
    else if (currentPage==(2))
    {
        
        //[self scrollRectToVisible:CGRectMake(viewWidth+RightWidth,0,viewWidth,viewHeight-64) animated:NO]; // 序号0 最后1页
    }
 
}


-(void)leftViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        //slideMenu.navTitleLabel.text=[NSString stringWithFormat:@"Menu%ld",(long)indexPath.row];
//        slideMenu.navTitleLabel.text=[[array objectAtIndex:indexPath.row+1] objectForKey:@"funName"];


    UIViewController *selectPage;
    
    
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
   
    switch (indexPath.row) {
        case 0:
            if (!_funcCP) {
                _funcCP = [[funcChoosePage alloc]init];
            }
            selectPage = _funcCP;
            
            break;
        case 1:
            if (!_pastVC) {
                _pastVC=[[pastBillViewController alloc]init];
            }
            selectPage=_pastVC;
            
            break;
            
        case 2:
            if (!_consumerSVC) {
                _consumerSVC=[[ConsumerSupportViewController alloc]init];
            }
            selectPage=_consumerSVC;

            break;
            
        case 3:
            if (!_newwSVC) {
                _newwSVC=[[newNewsViewController alloc]init];
            }
            selectPage=_newwSVC;

            break;
            
        case 4:
            break;
            
        case 5:
            if (!_aboutVC) {
                _aboutVC=[[aboutViewController alloc]init];
            }
            selectPage=_aboutVC;
            break;
            
        case 6:
            [self shareEvent];
            return;
            break;
        case 7:
            if (!_myAVC) {
                _myAVC=[[myAccountViewController alloc]init];
            }
            selectPage=_myAVC;
            break;
            
        case 8:
            [window.viewForBaselineLayout makeToast:@"功能即將開放，敬請期待！"];
            return;
            break;
            
       
        default:
            break;
    }
    
    [self navLeftBtAction];
//  [YiSlidetableView reloadData];
            
    if ([_slideMenuDelegate respondsToSelector:@selector(passView:)]) {
        [_slideMenuDelegate passView:selectPage];
        
   }
    
                
//    [self.navigationController pushViewController:selectPage animated:YES];
    
//    if ([_slideMenuDelegate respondsToSelector:@selector(didSelectRowAtIndexPath:slide:)]) {
//        [_slideMenuDelegate didSelectRowAtIndexPath:indexPath slide:YiLeftDirection];
//    }
    //NSLog(@"%ld",(long)indexPath.row);
    
    
}

-(void)shareEvent{
    NSLog(@"share");
    NSURL *url=[NSURL URLWithString:@"http://tw.yahoo.com"];
    
    UIActivityViewController *act=[[UIActivityViewController alloc]initWithActivityItems:@[url] applicationActivities:nil];
   
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    [window.rootViewController presentViewController:act animated:YES completion:nil];
    //[[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:act animated:YES completion:nil];
}


-(void)rightDidSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_slideMenuDelegate respondsToSelector:@selector(didSelectRowAtIndexPath:slide:)]) {
        [_slideMenuDelegate didSelectRowAtIndexPath:indexPath slide:YiRightDirection];
       
    }
  
}


@end
