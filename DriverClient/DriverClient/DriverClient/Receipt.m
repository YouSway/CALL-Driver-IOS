//
//  Receipt.m
//  DriverClient
//
//  Created by YouSway on 2016/7/15.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "Receipt.h"
#import "UIDefine.h"
#import "style.h"
#import "InvoiceProcessing.h"
#import "PJRSignatureView.h"
#import "style.h"

@interface Receipt (){
    
    CGFloat width,height;
    UIScrollView *mainView;
    
    NSDictionary *result;
    
    PJRSignatureView *signatureView;
    UIImageView* pickImage;
}

@end

@implementation Receipt


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:backColor];
//    self.navigationController.navigationBar.barTintColor = greenWord;
//    self.title = @"線上簽收";
//    self.navigationController.navigationBar.hidden=NO;

    self.view.backgroundColor=floor_bgcolor;
    self.navigationController.navigationBar.barTintColor = title_bgcolor;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title=@"線上簽收";
    /*
     self.navigationController.navigationBar.barTintColor = title_bgcolor;
     self.navigationController.navigationBar.translucent = NO;
     self.view.backgroundColor = floor_bgcolor;
     */
    
    
    //取消按紐
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"清除" style:UIBarButtonItemStylePlain target:self action:@selector(clearview)];
    self.navigationItem.rightBarButtonItem = right;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    width = aScreenRect.size.width;
    height = aScreenRect.size.height;
    
    [self receipt];
    
    //    NSLog(@"%@",result);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)receipt{
    
    signatureView= [[PJRSignatureView alloc] initWithFrame:CGRectMake(0, 0, width, height*0.8)];
    [self.view addSubview:signatureView];
    
    
    UIButton *receiptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    receiptBtn.frame = CGRectMake(width*0.15,signatureView.frame.origin.y+signatureView.frame
                                  .size.height+20,width*0.7,height*0.1-20);
    receiptBtn.layer.cornerRadius = 5;
    receiptBtn.backgroundColor = button_bgcolor;
    [receiptBtn setTitle:@"完成簽收" forState:UIControlStateNormal];
    [receiptBtn addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:receiptBtn];
    
}

-(void)clearview{
    
    [signatureView clearSignature];
    
}

-(void)complete{
    
    //保存瞬间把view上的所有按钮的Alpha值改为０
    //[[self.view subviews] makeObjectsPerformSelector:@selector (setAlpha:)];
    
    UIGraphicsBeginImageContext(signatureView.bounds.size);
    
    [signatureView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage* image=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    //遍历view全部按钮在把他们改为１
    /*for (UIView* temp in [self.view subviews])
    {
        [temp setAlpha:1.0];
    }*/

    
    
    InvoiceProcessing *nVI = [[InvoiceProcessing alloc]init];
    [self.navigationController pushViewController:nVI animated:YES];

    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image=[[info objectForKey:UIImagePickerControllerEditedImage] retain];
    //延时
    [self performSelector:@selector(saveImage:) withObject:image afterDelay:0.5];

    
}


-(void)saveImage:(id)sender
{
    
    if (pickImage!=nil)
    {
        [pickImage removeFromSuperview];
        [pickImage initWithImage:sender];
        pickImage.frame=CGRectMake(40, 40, 200, 200);
        
        [self.view insertSubview:pickImage atIndex:2];
        //[self.view sendSubviewToBack:pickImage];//添加到最后一层
        //self.view.backgroundColor=[UIColor clearColor];
        //self.view.alpha=0;
        //[self.view addSubview:pickImage];
        
        
        
    }
    else
    {
        pickImage=[[UIImageView alloc] initWithImage:sender];
        pickImage.frame=CGRectMake(40, 40, 200, 200);
        
        [self.view insertSubview:pickImage atIndex:2];
        //[self.view sendSubviewToBack:pickImage];//添加到最后一层
        //self.view.backgroundColor=[UIColor clearColor];
        //self.view.alpha=0;
        ///[self.view addSubview:pickImage];
    }
}



- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



//電話打入等事件取消時
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    //initData
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}

@end
