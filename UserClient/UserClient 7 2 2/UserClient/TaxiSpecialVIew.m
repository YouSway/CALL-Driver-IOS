//
//  TaxiSpecialVIew.m
//  UserClient
//
//  Created by DSL on 2016/7/24.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "TaxiSpecialVIew.h"
#import "style.h"
@implementation TaxiSpecialVIew

-(void)setTaxiSpecialVIew{
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    self.frame=CGRectMake(0, 0, aScreenRect.size.width, aScreenRect.size.height);
    self.backgroundColor=RGBACOLOR(0, 0, 0, 0.5);
    
    UILabel *mainMenu=[[UILabel alloc]init];
    [mainMenu setFrame:CGRectMake(aScreenRect.size.width/2-160, 80, 320, 300)];
    mainMenu.backgroundColor=[UIColor whiteColor];
    [self addSubview:mainMenu];
    
    UIButton *cancel=[[UIButton alloc]init];
    [cancel setFrame:CGRectMake(mainMenu.frame.origin.x, mainMenu.frame.origin.y+mainMenu.frame.size.height,160, 40)];
    cancel.backgroundColor=[UIColor redColor];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(distorySelf) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancel];
    
    UIButton *ok=[[UIButton alloc]init];
    [ok setFrame:CGRectMake(cancel.frame.origin.x+cancel.frame.size.width, cancel.frame.origin.y, 160, 40)];
    ok.backgroundColor=[UIColor blueColor];
    [ok setTitle:@"確認" forState:UIControlStateNormal];
    [self addSubview:ok];
    
}

-(void)distorySelf{
    [self removeFromSuperview];
}

@end
