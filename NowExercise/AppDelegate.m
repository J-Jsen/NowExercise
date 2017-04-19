//
//  AppDelegate.m
//  NowExercise
//
//  Created by mac on 16/10/21.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginViewController.h"

#import "HomeViewController.h"
#import "LeftViewController.h"

#import "WelcomeViewController.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*****************统一设置app一些样式*******************/
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //导航栏上的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0,-60) forBarMetrics:UIBarMetricsDefault];
    /**************************初始化app*********************/
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
#pragma mark 判断是否是新版本
    NSUserDefaults * defaul                = [NSUserDefaults standardUserDefaults];
    NSDictionary * infoDictionary          = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    //获取app版本
    NSString * app_version                 = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //储存的app版本
    NSString * save_app_version            = [defaul objectForKey:@"app_version"];
    //判断是否是新版本
    if ([app_version isEqualToString:save_app_version]) {
        //是当前版本,直接进入主页面
        self.window.rootViewController     = [self mmdrawerView];
        
    }else{
        //进入欢迎页
        WelcomeViewController * welcomeView = [[WelcomeViewController alloc]init];
        self.window.rootViewController      = welcomeView;
        LoginViewController * loginView     = [[LoginViewController alloc]init];
        welcomeView.WelcomeChangeRootView   = ^{
            self.window.rootViewController  = loginView;
            [defaul setObject:app_version forKey:@"app_version"];
        };
        loginView.LoginChangeRootView       = ^{
            self.window.rootViewController  = [[UINavigationController alloc]initWithRootViewController:[self mmdrawerView]];
            [self.window makeKeyAndVisible];
        };
    }
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}

- (MMDrawerController *)mmdrawerView{
    HomeViewController * homeView = [[HomeViewController alloc]init];
    LeftViewController * leftView = [[LeftViewController alloc]init];
    UINavigationController * homeNav = [[UINavigationController alloc]initWithRootViewController:homeView];
    leftView.delegate = homeView;
    
    MMDrawerController * drawerController = [[MMDrawerController alloc]initWithCenterViewController:homeNav leftDrawerViewController:leftView];
    
    drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    drawerController.maximumLeftDrawerWidth = WIDTH_6(MENU_WIDTH);
    return drawerController;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//矛盾说 我从来不梦想,我只是在努力认识现实
//戏剧家洪深说 我的梦想是明年吃苦的能力比今年更强
//鲁迅说 人生最大的痛苦是 梦醒了无路可走
//苏格拉底说 人类的幸福和欢乐在于奋斗 而最有价值的是 为理想而奋斗
//不拍万人阻挡 只怕自己投降

@end
