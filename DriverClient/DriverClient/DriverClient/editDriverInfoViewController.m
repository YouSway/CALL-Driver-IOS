//
//  suggestionViewController.m
//  DriverClient
//
//  Created by 黃柏鈞 on 2016/7/5.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "editDriverInfoViewController.h"
#import "style.h"
@interface editDriverInfoViewController ()<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>{
    UIScrollView* scrollView;
}

@end

@implementation editDriverInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=floor_bgcolor;
    self.navigationController.navigationBar.barTintColor = title_bgcolor;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title=@"編輯司機資訊";
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    //nav btn
    UIBarButtonItem *submitButton = [[UIBarButtonItem alloc] initWithTitle:@"送出" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    submitButton.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = submitButton;
    
    
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
    
    
    //
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor = floor_bgcolor;
    scrollView.scrollEnabled = YES;
    //scrollView.pagingEnabled = YES;
    //scrollView.showsVerticalScrollIndicator = YES;
    //scrollView.showsHorizontalScrollIndicator = YES;
    
    //
    int scHeight=1000;//螢幕最小長度
    if (self.view.frame.size.height<scHeight) {
        scHeight=scHeight;
    }
    else{
        scHeight=self.view.frame.size.height;
    }
    
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, scHeight);
    NSLog(@"%f",self.view.bounds.size.height);
    [self.view addSubview:scrollView];
    
    
    //遮瑕用
    UITableViewCell *Mainform =[[UITableViewCell alloc]init];
    int formHeight=60;
    int titleWidth=320;
    [Mainform setFrame:CGRectMake(aScreenRect.size.width/2-titleWidth/2, 60, titleWidth, 40*22)];
    //Mainform.textLabel.text=@"123";
    Mainform.backgroundColor=[UIColor whiteColor];
    Mainform.layer.cornerRadius=5;
    [scrollView addSubview:Mainform];
    
    
    
    //主體內容
    UILabel *title=[[UILabel alloc]init];
    [title setFrame:CGRectMake(aScreenRect.size.width/2-titleWidth/2, 40, titleWidth, 40)];
    title.text=@"請留下寶貴的意見";
    title.font = [UIFont systemFontOfSize:30];
    UIColor *color = font_titleColor;
    [title setTextColor:color];
    title.textAlignment = NSTextAlignmentCenter;
    //title.backgroundColor=[UIColor redColor];
    //[scrollView addSubview:title];
    
    UIImageView *personPhoto=[[UIImageView alloc]init];
    [personPhoto setFrame:CGRectMake(20, 40, 75, 75)];
    personPhoto.backgroundColor=[UIColor grayColor];
    personPhoto.layer.cornerRadius=5;
    [Mainform  addSubview:personPhoto];
    
    //星星
    for (int i=0; i<5; i++) {
        UIImageView *score=[[UIImageView alloc]init];
        [score setFrame:CGRectMake(personPhoto.frame.origin.x+75+20+i*30, 40, 20, 20)];
        score.backgroundColor=[UIColor clearColor];
        score.tag=i;
        [Mainform  addSubview:score];
        
        UIImage*star=[UIImage imageNamed:@"aStar_orange.png"];
        [score setImage:star];
    }
    
    //跑單詳細
    UILabel *detail=[[UILabel alloc]init];
    [detail setFrame:CGRectMake(personPhoto.frame.origin.x+75+20, 65, 95, 20)];
    detail.text=@"目前接單數：";
    detail.font=[detail.font fontWithSize:10];
//    detail.backgroundColor=[UIColor redColor];
    [Mainform addSubview:detail];
    
    UILabel *detail2=[[UILabel alloc]init];
    [detail2 setFrame:CGRectMake(personPhoto.frame.origin.x+75+20, 65+30, 95, 20)];
    detail2.text=@"訂單完成率：";
    detail2.font=[detail2.font fontWithSize:10];
//    detail2.backgroundColor=[UIColor redColor];
    [Mainform addSubview:detail2];
    
    UILabel *detail3=[[UILabel alloc]init];
    [detail3 setFrame:CGRectMake(personPhoto.frame.origin.x+75+20+110, 65, 95, 20)];
    detail3.text=@"目前接單數：";
    detail3.font=[detail3.font fontWithSize:10];
//    detail3.backgroundColor=[UIColor redColor];
    [Mainform addSubview:detail3];
    
    UILabel *detail4=[[UILabel alloc]init];
    [detail4 setFrame:CGRectMake(personPhoto.frame.origin.x+75+20+110, 65+30, 95, 20)];
    detail4.text=@"訂單完成率：";
    detail4.font=[detail2.font fontWithSize:10];
//    detail4.backgroundColor=[UIColor redColor];
    [Mainform addSubview:detail4];
    
    
    
    
    for (int i=0; i<5; i++) {
        // int formHeight=60;
        UILabel*title=[[UILabel alloc]init];
        //title.text=@"聯絡人名稱：";
        title.backgroundColor=[UIColor whiteColor];
        [title setFrame:CGRectMake(aScreenRect.size.width/2-titleWidth/2, 90+formHeight*i+120, 320, formHeight)];
        title.layer.masksToBounds = YES;
        title.layer.cornerRadius=5;
        title.textColor=font_labelTitleColor;
        [scrollView addSubview:title];
        
        if (i!=4) {
            UITextField*intputData=[[UITextField alloc]init];
            [intputData setFrame:CGRectMake(aScreenRect.size.width/2-titleWidth/2+125, 90+formHeight*i+120, 320-125, formHeight)];
            intputData.backgroundColor=[UIColor whiteColor];
            intputData.returnKeyType=UIReturnKeyDone;
            intputData.tag=i;
            intputData.layer.cornerRadius=5;
            [scrollView addSubview:intputData];
            intputData.delegate=self;
            [intputData addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
        }
        
        if(i>0){
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((aScreenRect.size.width-320+40)/2,90+formHeight*i+120, 320-40, 1)];
            lineView.backgroundColor = floor_bgcolor;
            [scrollView addSubview:lineView];
        }
        
        
        switch (i) {
            case 0:
                title.text=@"       姓       名：";
                break;
            case 1:
                title.text=@"       車       牌：";
                break;
            case 2:
                title.text=@"       廠牌型號：";
                break;
            case 3:
                title.text=@"       服務特色：";
                break;
            case 4:
                title.text=@"       介紹與備註：";
                break;
                
                
                
            default:
                break;
        }
        
        
    }
    
    UITextView *inputData2=[[UITextView alloc]init];
    [inputData2 setFrame:CGRectMake(aScreenRect.size.width/2-135, 90+formHeight*5.2+120, 270, 160)];
    inputData2.backgroundColor=[UIColor whiteColor];
    inputData2.returnKeyType=UIReturnKeyDone;
    inputData2.layer.cornerRadius=5;
    inputData2.layer.borderWidth=1.5f;
    inputData2.layer.borderColor=floor_bgcolor.CGColor;
    inputData2.delegate=self;
    
    [scrollView addSubview:inputData2];
    
    
    UILabel*title2=[[UILabel alloc]init];
    title2.text=@"      愛車照片：";
    title2.textColor=font_labelTitleColor;
    title2.backgroundColor=[UIColor whiteColor];
    [title2 setFrame:CGRectMake(aScreenRect.size.width/2-160, inputData2.frame.origin.y+160, 320, formHeight)];
    title2.layer.masksToBounds = YES;
    title2.layer.cornerRadius=5;
    
    [scrollView addSubview:title2];
    
    UIImageView*carPhoto=[[UIImageView alloc]init];
    [carPhoto setFrame:CGRectMake(aScreenRect.size.width/2-135, title2.frame.origin.y+60, 270, 160)];
    carPhoto.backgroundColor=[UIColor grayColor];
    [scrollView addSubview:carPhoto];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)submit{
    NSLog(@"submit");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    //initData
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}


//textfiled

-(void)textFieldDone:(UITextField*)textField
{
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"START EDIT");
    CGPoint position = CGPointMake(0, 216);
    [scrollView setContentOffset:position animated:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField*)textField {
    
    CGPoint position = CGPointMake(0, 0);
    [scrollView setContentOffset:position animated:YES];
    
    NSLog(@"END EDIT");
}

//textView
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textField {
    NSLog(@"START EDIT");
    CGPoint position = CGPointMake(0, 216);
    [scrollView setContentOffset:position animated:YES];
    [UIView commitAnimations];
}


- (void)textViewDidEndEditing:(UITextView*)textField {
    NSLog(@"END EDIT");
    CGPoint position = CGPointMake(0, 0);
    [scrollView setContentOffset:position animated:YES];
    [UIView commitAnimations];
}


-(void)backBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
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