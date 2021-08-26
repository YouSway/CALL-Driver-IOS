//
//  FavoritePointViewController.m
//  UserClient
//
//  Created by 黃柏鈞 on 2016/7/19.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "FavoritePointViewController.h"
#import "style.h"
@interface FavoritePointViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    
    UITableView *tableView;
    
    //int titleWidth=320;
    int tableCellHeight;
    int tableValue;
}



@end

@implementation FavoritePointViewController

//int titleWidth=320;
//int tableCellHeight=60;
//int tableValue=5;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    
    //讀取PLIST
    //取得plist檔案路徑
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingString:@"/Data.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableDictionary *data;
    
    //判斷plist檔案是否存在於對應位置
    if ([fileManager fileExistsAtPath: filePath]) {
        
        //讀取存在的plist檔案，之後等待覆寫
        data = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        NSLog(@"讀取");
        
        //初始化
        // [data setValue:@"20" forKey:@"dataValue"];
    } else {
        
        //在對應位置中建立plist檔案
        data = [[NSMutableDictionary alloc] init];
        NSLog(@"建立");
        [data setValue:@"5" forKey:@"dataValue"];
    }
    
    //覆寫or設定參數值
    
    
    //將plist檔案存入Document
    if ([data writeToFile:filePath atomically: YES]) {
        NSLog(@"data update");
        //[textView setText:@"資料寫入成功！"];
    } else {
        //[textView setText:@"資料寫入失敗！"];
        NSLog(@"data update error");
    }
    
    NSString *debug=[data objectForKey:@"dataValue"];
    NSLog(@"%@",debug);
    
    //建立表格
    tableValue=[[data objectForKey:@"dataValue"] intValue];
    tableCellHeight=60;
    [self setupTableView];
    
    
}

-(void)setupTableView{
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    UILabel *bgLb=[[UILabel alloc]init];
    [bgLb setFrame:CGRectMake(aScreenRect.size.width/2-160, 20, 320, aScreenRect.size.height-140)];
    bgLb.backgroundColor=[UIColor redColor];
    bgLb.layer.masksToBounds=YES;
    bgLb.layer.cornerRadius=5;
    [self.view addSubview:bgLb];
    
    tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor=[UIColor whiteColor];
    [tableView setFrame:CGRectMake(aScreenRect.size.width/2-150, 25, 300, aScreenRect.size.height-150)];
    
    [self.view addSubview: tableView];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableValue;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return tableCellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)cellTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [cellTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //UIButton *optionBtn1 =[[UIButton alloc]init];
    UIButton *optionBtn1=[[UIButton alloc]init];
    [optionBtn1 setFrame:CGRectMake(cell.frame.origin.x+10, tableCellHeight*(indexPath.row+1)-5, 15, 15)];
    optionBtn1.backgroundColor=[UIColor redColor];
    [tableView addSubview:optionBtn1];
    
    UILabel *optionLb1=[[UILabel alloc]init];
    [optionLb1 setFrame:CGRectMake(optionBtn1.frame.origin.x+optionBtn1.frame.size.width+5, tableCellHeight*(indexPath.row+1)-5, 55,20 )];
    [optionLb1 setText:@"名稱："];
    [tableView addSubview:optionLb1];
    
    UILabel *optionLb2=[[UILabel alloc]init];
    [optionLb2 setFrame:CGRectMake(optionBtn1.frame.origin.x+optionBtn1.frame.size.width+5+optionLb1.frame.size.width, tableCellHeight*(indexPath.row+1)-5, 200,20 )];
    [optionLb2 setText:@"XXXXXX"];
    optionLb2.backgroundColor=[UIColor yellowColor];
    [tableView addSubview:optionLb2];
    
    UILabel *line=[[UILabel alloc]init];
    line.backgroundColor=floor_bgcolor;
    [line setFrame:CGRectMake(160-140, 34+tableCellHeight*(indexPath.row+1), 280, 1.5)];
    [tableView addSubview:line];
    
    
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    self.view.backgroundColor=floor_bgcolor;
    self.navigationController.navigationBar.barTintColor = title_bgcolor;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title=@"常用地點";
    
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
