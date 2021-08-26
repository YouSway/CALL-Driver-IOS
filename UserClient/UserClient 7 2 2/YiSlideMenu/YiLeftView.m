//
//  YiLeftView.m
//  YiSlideMenu
//
//  Created by coderyi on 15/3/8.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "YiLeftView.h"
#import "style.h"


//

//#import "OrderListViewController.h"
@interface YiLeftView ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableView;
    
}

@end
@implementation YiLeftView
- (id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {

        float viewWidth=frame.size.width;
        float viewHeight=frame.size.height;
        
        self.backgroundColor=leftmenu_bgcolor;
        
        tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64 , viewWidth, viewHeight-64) style:UITableViewStylePlain];
        [self addSubview:tableView];
        tableView.dataSource=self;
        tableView.delegate=self;
        if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
            [tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        tableView.showsVerticalScrollIndicator=NO;
        tableView.backgroundColor=leftmenu_bgcolor;
        tableView.scrollEnabled=NO;
        UIView *line=[[UIView alloc] initWithFrame:CGRectMake(viewWidth-1, 64, 1, viewHeight-64)];
        [self addSubview:line];
        line.backgroundColor=[UIColor grayColor];
        

        
        
        UIView *titleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 64)];
        titleView.backgroundColor=title_bgcolor;
        
        UIImageView *titleIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 27, 30, 30)];
        titleIV.image=[UIImage imageNamed:@"jobs"];
        titleIV.layer.masksToBounds=YES;
        titleIV.layer.cornerRadius=20;
        [titleView addSubview:titleIV];
        
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(50, 20, 140, 40)];
        [titleView addSubview:titleLabel];
        titleLabel.text=@"功能選單";
        titleLabel.font=[UIFont boldSystemFontOfSize:16];
        titleLabel.textColor=[UIColor whiteColor];
        [self addSubview:titleView];
        
    
        
                  }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *sourcePath=[[NSBundle mainBundle] pathForResource:@"leftMenuItem" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:sourcePath];
    
    //NSLog(@"%@",[[array objectAtIndex:0] objectForKey:@"tableValue"]);
    NSString *a = [[array objectAtIndex:0] objectForKey:@"tableValue"];
    NSInteger tableValue = [a integerValue];


    return tableValue;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellId];
       
        
    }
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = leftmenuSelected_bgcolor;
    [cell setSelectedBackgroundView:bgColorView];

    
    NSString *sourcePath=[[NSBundle mainBundle] pathForResource:@"leftMenuItem" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:sourcePath];

    cell.textLabel.text=[[array objectAtIndex:indexPath.row+1] objectForKey:@"funName"];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor =leftmenu_bgcolor;
    cell.textLabel.textColor=[UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if ([_delegate respondsToSelector:@selector(leftViewDidSelectRowAtIndexPath:)]) {
        [_delegate leftViewDidSelectRowAtIndexPath:indexPath];
    }
    
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
