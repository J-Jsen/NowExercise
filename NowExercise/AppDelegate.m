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

#import "Reachability.h"

// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import <CoreLocation/CLLocationManagerDelegate.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate ()<JPUSHRegisterDelegate>
{
    CLLocationManager *_locationManager;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*****************统一设置app一些样式*******************/
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //导航栏上的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0,-60) forBarMetrics:UIBarMetricsDefault];
    /*****************开启定位设置*******************/
    //定位管理器
    _locationManager = [[CLLocationManager alloc] init];
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];
    }
    /********************** Jpush 推送 ****************************/
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加 定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    //NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    //Required
    //    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
    //                                                      UIUserNotificationTypeSound |
    //                                                      UIUserNotificationTypeAlert)
    //                                          categories:nil];
    
    [JPUSHService setupWithOption:launchOptions appKey:JpushAppKey
                          channel:@"channel"
                 apsForProduction:FALSE
            advertisingIdentifier:nil];
    
#pragma mark 添加网络监控通知
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(reachabilityChanged:)
     
                                                 name:kReachabilityChangedNotification
     
                                               object:nil];
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.guodongwl.com"];
    
    [reach startNotifier];

    /**************************初始化app*********************/
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
#pragma mark 判断是否是新版本
    WeakSelf
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
        loginView.back = YES;
        welcomeView.WelcomeChangeRootView   = ^{
            [defaul setObject:app_version forKey:@"app_version"];
            //判断更新后是否登录
            if ([HttpRequest judgeWhetherUserLogin]) {
                weakSelf.window.rootViewController = [self mmdrawerView];
            }else{
                weakSelf.window.rootViewController  = loginView;
            }
        };
        loginView.LoginChangeRootView       = ^{
            weakSelf.window.rootViewController  = [self mmdrawerView];
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
- (void)application:(UIApplication*)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
    // NSLog(@"regusterId %@",[JPUSHService registrationID]);
}
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    // JPush
    [JPUSHService handleRemoteNotification:userInfo];
}
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    /*
     aps =     {
     alert = "\U8fd0\U52a8\U5185\U5bb9\U53ca\U5f3a\U5ea6\U5efa\U8bae";
     badge = 1;
     sound = default;
     };
     img = "http://192.168.1.90:8080/img/pic_folder/notice/panda1_WJ5CDjg.png";
     type = hold;[userInfo objectForKey:@"img"]
     */
    
    
    [JPUSHService handleRemoteNotification:userInfo];
}
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    // NSLog(@"ERROR   %@",error);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

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
#pragma mark 实现网络监控方法
-(void)reachabilityChanged:(NSNotification *)notification
{
    Reachability *reach = [notification object];
    
    if([reach isKindOfClass:[Reachability class]]){
        
        NetworkStatus statuWetwork = [reach currentReachabilityStatus];
        
        NSLog(@"statuWetwork  %ld",(long)statuWetwork);
        switch (statuWetwork) {
            case 0:
            {
                [HttpRequest showAlertWithTitle:@"网络连接中断"];
            }
                break;
                
            default:
                break;
        }
        //Insert your code here
        
    }
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [UIApplication sharedApplication].applicationIconBadgeNumber++;

    }
    completionHandler();  // 系统要求执行这个方法
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
