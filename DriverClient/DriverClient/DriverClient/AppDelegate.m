//
//  AppDelegate.m
//  DriverClient
//
//  Created by YouSway on 2016/7/1.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "AppDelegate.h"
#import "UIDefine.h"
#import "ViewController.h"
#import "style.h"

#import "funcChoosePage.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *nav = nil;
    
    //登入界面
    //[[UINavigationBar appearance] setBarTintColor:title_bgcolor];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictSave = [userDefaults valueForKey:@"userReg"];
    
    
    if (!dictSave) {
        NSLog(@"%@",dictSave);

        funcChoosePage *main = [[funcChoosePage alloc]init];
        nav = [[UINavigationController alloc] initWithRootViewController:main];
        self.window.rootViewController = nav;
      
        [nav setNavigationBarHidden:NO];
        
        [self.window makeKeyAndVisible];
        
        
       
        
        
        return YES;

    }else{
        

        
        NSLog(@"沒有");
        ViewController *loginController = [[ViewController alloc] init];
        nav = [[UINavigationController alloc] initWithRootViewController:loginController];
        self.window.rootViewController = nav;
        [nav setNavigationBarHidden:NO];
        
        [self.window makeKeyAndVisible];
        return YES;


    }
    
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end