//
//  AboutUsViewController.m
//  NowExercise
//
//  Created by mac on 17/4/5.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createNavigationView];
}

//自定制导航栏
- (void)createNavigationView{
    self.navigationController.navigationBarHidden = NO;
    //关闭导航栏毛玻璃效果
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏颜色
    self.navigationController.navigationBar.barTintColor = COLOR(31, 31, 31);
    //导航栏标题
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(20)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"关于立炼";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)Call:(id)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:010-65460058"]]) {
        UIWebView * callWeb = [[UIWebView alloc]init];
        [callWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel:010-65460058"]]];
        [self.view addSubview:callWeb];
    }
}
- (IBAction)GuoDongWang:(id)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mailto:admin@guodong117.com"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:admin@guodong117.com"] options:@{} completionHandler:nil];
//        [[UIApplication sharedApplication] OpenURL:[NSURL URLWithString:@"http://www.baidu.com"]];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
