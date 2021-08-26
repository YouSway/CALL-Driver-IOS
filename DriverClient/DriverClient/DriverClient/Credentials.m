//
//  Credentials.m
//  DriverClient
//
//  Created by YouSway on 2016/7/3.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "InfLog.h"
#import "style.h"
#import "CustomView.h"
#import "Credentials.h"
#import "screenConditionPage.h"
#import "PublicController.h"
#import "MBProgressHUD.h"
#import "APIController.h"
#import "UIView+Toast.h"

@interface Credentials (){
    
    NSString *phoneSave;
    int n;
    UIImage *vehicleI;
    UIImage *idcardI;
    UIImage *licenseI;
    UIImage *businessI;
    UIImage *carI;
    UIAlertView *prompt;
    
}

@end

@implementation Credentials

- (void)viewDidLoad {
    
    self.title = @"上傳證件";
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    //完成按紐
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(complete)];
    self.navigationItem.rightBarButtonItem = right;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    n = 0;
    
    
    [self credentials];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)credentials{
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    self.navigationController.navigationBar.barTintColor = title_bgcolor;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = floor_bgcolor;
    
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

    
    
    UILabel *infverification = [[UILabel alloc] initWithFrame:CGRectMake(width/2-160, 20, 320,45)];
    infverification.backgroundColor = [UIColor whiteColor];
    infverification.layer.masksToBounds=YES;
    infverification.layer.cornerRadius = 5;
    infverification.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    infverification.text = @"  線上驗證";
    infverification.textColor = font_titleColor2;
    [self.view addSubview:infverification];
    
    
    CustomView *inf = [[CustomView alloc]initWithFrame:CGRectMake(width/2-160,infverification.frame.origin.y+40, 320, height*0.4)];
    inf.backgroundColor = [UIColor whiteColor];
    inf.layer.masksToBounds=YES;
    inf.layer.cornerRadius = 5;
    [self.view addSubview:inf];
    
    
    
    UILabel *infvehicle = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*0, inf.frame.size.width/3+20,inf.frame.size.height/5)];
    infvehicle.backgroundColor = [UIColor clearColor];
    infvehicle.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infvehicle.text = @"1.車輛行照";
    infvehicle.textColor = font_labelTitleColor;
    [inf addSubview:infvehicle];
    
    
    UILabel *infid = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*1, inf.frame.size.width/3+20,inf.frame.size.height/5)];
    infid.backgroundColor = [UIColor clearColor];
    infid.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infid.text = @"2.身份證";
    infid.textColor = font_labelTitleColor;
    [inf addSubview:infid];
    
    
    UILabel *inflicense = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*2, inf.frame.size.width/3+20,inf.frame.size.height/5)];
    inflicense.backgroundColor = [UIColor clearColor];
    inflicense.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    inflicense.text = @"3.駕照";
    inflicense.textColor = font_labelTitleColor;
    [inf addSubview:inflicense];
    
    
    UILabel *infbusiness = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*3, inf.frame.size.width/3+20,inf.frame.size.height/5)];
    infbusiness.backgroundColor = [UIColor clearColor];
    infbusiness.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infbusiness.text = @"4.營業執照";
    infbusiness.textColor = font_labelTitleColor;
    [inf addSubview:infbusiness];
    
    UILabel *infcar = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, inf.frame.size.height/5*4, inf.frame.size.width/3+35,inf.frame.size.height/5)];
    infcar.backgroundColor = [UIColor clearColor];
    infcar.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    infcar.text = @"5.車身照（含車牌）";
    infcar.textColor = font_labelTitleColor;
    [inf addSubview:infcar];
    
    
    UIImageView *camera1 = [[UIImageView alloc]initWithFrame:CGRectMake(inf.frame.size.width*0.85, inf.frame.size.height/5*0+20, 25,25)];
    camera1.backgroundColor = [UIColor clearColor];
    [camera1 setImage:[UIImage imageNamed:@"camera"]];
    [inf addSubview:camera1];
    
    
    UIImageView *camera2 = [[UIImageView alloc]initWithFrame:CGRectMake(inf.frame.size.width*0.85, inf.frame.size.height/5*1+20, 25,25)];
    camera2.backgroundColor = [UIColor clearColor];
    [camera2 setImage:[UIImage imageNamed:@"camera"]];
    [inf addSubview:camera2];
    
    UIImageView *camera3 = [[UIImageView alloc]initWithFrame:CGRectMake(inf.frame.size.width*0.85, inf.frame.size.height/5*2+20, 25,25)];
    camera3.backgroundColor = [UIColor clearColor];
    [camera3 setImage:[UIImage imageNamed:@"camera"]];
    [inf addSubview:camera3];
    
    
    UIImageView *camera4 = [[UIImageView alloc]initWithFrame:CGRectMake(inf.frame.size.width*0.85, inf.frame.size.height/5*3+20, 25,25)];
    camera4.backgroundColor = [UIColor clearColor];
    [camera4 setImage:[UIImage imageNamed:@"camera"]];
    [inf addSubview:camera4];
    
    
    UIImageView *camera5 = [[UIImageView alloc]initWithFrame:CGRectMake(inf.frame.size.width*0.85, inf.frame.size.height/5*4+20, 25,25)];
    camera5.backgroundColor = [UIColor clearColor];
    [camera5 setImage:[UIImage imageNamed:@"camera"]];
    [inf addSubview:camera5];
    
    
    UIButton *camera1Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    camera1Btn.frame = CGRectMake(inf.frame.size.width*0.85, inf.frame.size.height/5*0+20, 25,25);
    camera1Btn.backgroundColor = [UIColor clearColor];
    [camera1Btn addTarget:self action:@selector(vehicle) forControlEvents:UIControlEventTouchUpInside];
    [inf addSubview:camera1Btn];
    
    
    UIButton *camera2Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    camera2Btn.frame = CGRectMake(inf.frame.size.width*0.85, inf.frame.size.height/5*1+20, 25,25);
    camera2Btn.backgroundColor = [UIColor clearColor];
    [camera2Btn addTarget:self action:@selector(idcard) forControlEvents:UIControlEventTouchUpInside];
    [inf addSubview:camera2Btn];
    
    
    UIButton *camera3Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    camera3Btn.frame = CGRectMake(inf.frame.size.width*0.85, inf.frame.size.height/5*2+20, 25,25);
    camera3Btn.backgroundColor = [UIColor clearColor];
    [camera3Btn addTarget:self action:@selector(license) forControlEvents:UIControlEventTouchUpInside];
    [inf addSubview:camera3Btn];
    
    
    UIButton *camera4Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    camera4Btn.frame = CGRectMake(inf.frame.size.width*0.85, inf.frame.size.height/5*3+20, 25,25);
    camera4Btn.backgroundColor = [UIColor clearColor];
    [camera4Btn addTarget:self action:@selector(business) forControlEvents:UIControlEventTouchUpInside];
    [inf addSubview:camera4Btn];
    
    
    UIButton *camera5Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    camera5Btn.frame = CGRectMake(inf.frame.size.width*0.85, inf.frame.size.height/5*4+20, 25,25);
    camera5Btn.backgroundColor = [UIColor clearColor];
    [camera5Btn addTarget:self action:@selector(car) forControlEvents:UIControlEventTouchUpInside];
    [inf addSubview:camera5Btn];
    
    NSUserDefaults *phoneDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary  *phoneDictionary = [phoneDefaults valueForKey:@"phoneReg"];
    
    if(phoneDictionary)
    {
        phoneSave = [phoneDictionary valueForKey:@"phone"];
    }else
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary  *dictSave = [userDefaults valueForKey:@"userReg"];
        phoneSave = [dictSave valueForKey:@"phone"];
    }
    
    
    
    

    
}

-(void)complete{
    

 
    screenConditionPage *nVS = [[screenConditionPage alloc]init];
    //nVC.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:nVS animated:YES];
    
 
}

-(void)vehicle{
    
    n = 1;
    prompt = [[UIAlertView alloc] initWithTitle:@""
                                              message:@"請選擇要使用圖Ｘ庫\n或是立即Ｘ照" // IMPORTANT
                                             delegate:self
                                    cancelButtonTitle:@"取消"
                                    otherButtonTitles:@"圖Ｘ",@"Ｘ照", nil];
    
    
    // set place
    [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
    [prompt show];
    
    
}



-(void)idcard{
    
    n = 2;
    prompt = [[UIAlertView alloc] initWithTitle:@""
                                        message:@"請選擇要使用圖Ｘ庫\n或是立即Ｘ照" // IMPORTANT
                                       delegate:self
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:@"圖Ｘ",@"Ｘ照", nil];
    
    
    // set place
    [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
    [prompt show];
    
}

-(void)license{
    
    n = 3;
    prompt = [[UIAlertView alloc] initWithTitle:@""
                                        message:@"請選擇要使用圖Ｘ庫\n或是立即Ｘ照" // IMPORTANT
                                       delegate:self
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:@"圖Ｘ",@"Ｘ照", nil];
    
    
    // set place
    [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
    [prompt show];
    
}

-(void)business{
    
    n = 4;
    prompt = [[UIAlertView alloc] initWithTitle:@""
                                        message:@"請選擇要使用圖Ｘ庫\n或是立即Ｘ照" // IMPORTANT
                                       delegate:self
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:@"圖Ｘ",@"Ｘ照", nil];
    
    
    // set place
    [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
    [prompt show];
    
}

-(void)car{
    n = 5;
    prompt = [[UIAlertView alloc] initWithTitle:@""
                                        message:@"請選擇要使用圖Ｘ庫\n或是立即Ｘ照" // IMPORTANT
                                       delegate:self
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:@"圖Ｘ",@"Ｘ照", nil];
    
    
    // set place
    [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
    [prompt show];
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    switch (n) {
        case 1:
            //取得剛拍攝的相片(或是由相簿中所選擇的相片)
            vehicleI = [info objectForKey:UIImagePickerControllerEditedImage];
            [picker dismissViewControllerAnimated:YES completion:^{}];
            break;
        case 2:
            //取得剛拍攝的相片(或是由相簿中所選擇的相片)
            idcardI = [info objectForKey:UIImagePickerControllerEditedImage];
            [picker dismissViewControllerAnimated:YES completion:^{}];
            break;
        case 3:
            //取得剛拍攝的相片(或是由相簿中所選擇的相片)
            licenseI = [info objectForKey:UIImagePickerControllerEditedImage];
            [picker dismissViewControllerAnimated:YES completion:^{}];
            break;
        case 4:
            //取得剛拍攝的相片(或是由相簿中所選擇的相片)
            businessI = [info objectForKey:UIImagePickerControllerEditedImage];
            [picker dismissViewControllerAnimated:YES completion:^{}];
            break;
        case 5:
            //取得剛拍攝的相片(或是由相簿中所選擇的相片)
            carI = [info objectForKey:UIImagePickerControllerEditedImage];
            [picker dismissViewControllerAnimated:YES completion:^{}];
            break;
            
        default:
            break;
    }
    
    
    
}


-(void)upload{
    
    NSString *photo1 = [PublicController encodeToBase64String:vehicleI];
    NSString *photo2 = [PublicController encodeToBase64String:idcardI];
    NSString *photo3 = [PublicController encodeToBase64String:licenseI];
    NSString *photo4 = [PublicController encodeToBase64String:businessI];
    NSString *photo5 = [PublicController encodeToBase64String:carI];
    NSDictionary *dict = @{@"phone":phoneSave,@"credentials_photo1":photo1,@"credentials_photo2":photo2,@"credentials_photo3":photo3,@"credentials_photo4":photo4,@"credentials_photo5":photo5};
    NSDictionary *result = [APIController Upload_credentials:dict];
    NSString *status = [NSString stringWithFormat:@"%@",[result objectForKey:@"status"]];
    if ([status isEqualToString:@"fail"]) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.view makeToast:@"照片上傳錯誤，請重新上傳！"];
    }else{
        NSLog(@"%@",status);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    

    switch (buttonIndex) {
        case 0:
            NSLog(@"Cancel Button Pressed");
            break;
        case 1:
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            //設定影像來源為圖
            imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            //顯示UIImagePickerController
            [self presentViewController:imagePicker animated:YES completion:^{}];
            break;
        }
        case 2:
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            
            //檢查是否支援此Source Type(相機)
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                //設定影像來源為相機
                imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                
                //顯示UIImagePickerController
                [self presentViewController:imagePicker animated:YES completion:^{}];
            }
            else {
                
                [self.view makeToast:@"此手機Ｘ支援照相功能，將改用圖Ｘ庫圖像"];
                
                imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                //顯示UIImagePickerController
                [self presentViewController:imagePicker animated:YES completion:^{}];
            }
            break;
        }
            
                
    }

    
    
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    //initData
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}

-(void)backBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

