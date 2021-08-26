//
//  suggestionViewController.m
//  DriverClient
//
//  Created by 黃柏鈞 on 2016/7/5.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "suggestionViewController.h"
#import "style.h"
@interface suggestionViewController ()<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>{
    UIScrollView* scrollView;
}

@end

@implementation suggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=floor_bgcolor;
    self.navigationController.navigationBar.barTintColor = title_bgcolor;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title=@"提供意見";
    
    
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
    

    
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    //nav btn
    UIBarButtonItem *submitButton = [[UIBarButtonItem alloc] initWithTitle:@"送出" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    submitButton.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = submitButton;
    
    

    //
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor = floor_bgcolor;
    scrollView.scrollEnabled = YES;
    //scrollView.pagingEnabled = YES;
    //scrollView.showsVerticalScrollIndicator = YES;
    //scrollView.showsHorizontalScrollIndicator = YES;
    
    //
    int scHeight=560;//螢幕最小長度
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
    [Mainform setFrame:CGRectMake(aScreenRect.size.width/2-titleWidth/2, 40+60, titleWidth, 60*6)];
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
    [scrollView addSubview:title];
    
    for (int i=0; i<3; i++) {
        // int formHeight=60;
        UILabel*title=[[UILabel alloc]init];
        //title.text=@"聯絡人名稱：";
        title.backgroundColor=[UIColor whiteColor];
        [title setFrame:CGRectMake(aScreenRect.size.width/2-titleWidth/2, 90+formHeight*i, 320, formHeight)];
        title.layer.masksToBounds = YES;
        title.layer.cornerRadius=5;
        [scrollView addSubview:title];
        
        if (i!=2) {
        UITextField*intputData=[[UITextField alloc]init];
        [intputData setFrame:CGRectMake(aScreenRect.size.width/2-titleWidth/2+125, 90+formHeight*i, 320-125, formHeight)];
        intputData.backgroundColor=[UIColor whiteColor];
        intputData.returnKeyType=UIReturnKeyDone;
        intputData.tag=i;
        intputData.layer.cornerRadius=5;
        [scrollView addSubview:intputData];
        intputData.delegate=self;
        [intputData addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
        }
        
        if(i>0){
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((aScreenRect.size.width-320+40)/2,90+formHeight*i, 320-40, 1)];
            lineView.backgroundColor = floor_bgcolor;
            [scrollView addSubview:lineView];
        }

        
        switch (i) {
            case 0:
                title.text=@"       聯絡人名稱：";
                break;
            case 1:
                title.text=@"       電話/電郵：";
                break;
            case 2:
                title.text=@"       意見：";
                
            default:
                break;
        }
        
       
    }
    
    UITextView *inputData2=[[UITextView alloc]init];
    [inputData2 setFrame:CGRectMake(aScreenRect.size.width/2-135, 90+formHeight*3.2, 270, 160)];
    inputData2.backgroundColor=[UIColor whiteColor];
    inputData2.returnKeyType=UIReturnKeyDone;
    inputData2.layer.cornerRadius=5;
    inputData2.layer.borderWidth=1.5f;
    inputData2.layer.borderColor=floor_bgcolor.CGColor;
    inputData2.delegate=self;
    
    [scrollView addSubview:inputData2];
    
    
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
