//
//  ClassViewController.m
//  NowExercise
//
//  Created by mac on 17/2/15.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "ClassViewController.h"
#import "SUplayer.h"
#import "PayViewController.h"
#import "SugerAlertView.h"
@interface ClassViewController ()<SugerAlertViewDelegate,SUplayerDelegate>
{
    SUplayer * player;
}
@end

@implementation ClassViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [UIApplication sharedApplication].statusBarHidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    player = [[SUplayer alloc]initWithFrame:[UIScreen mainScreen].bounds];
    player.delegate = self;
    [player updatePlayerWith:[NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"]];

    [self.view addSubview:player];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 隐藏状态栏

 @return 默认是NO表示不隐藏
 */

#pragma mark 播放器代理
- (void)ShowAddOrderView{
    
    [SugerAlertView sr_showAlertViewWithPlaceOrType:ClassTypeWithClass Delegate:self model:nil];
    [player pause];
}

- (void)Back{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 下单按钮代理
- (void)orderWithName:(NSString *)name tel:(NSString *)tel date:(NSString *)date time:(NSString *)time place:(NSString *)place classname:(NSString *)classname{
        PayViewController * pay = [[PayViewController alloc]init];
        pay.payback = ^{
            [player play];
        };
        //pay.ispay_money = NO;
        [self.navigationController pushViewController:pay animated:YES];
    
    
}
- (void)SRAlertDismiss{
    [player play];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [player pause];
    [UIApplication sharedApplication].statusBarHidden = NO;
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
