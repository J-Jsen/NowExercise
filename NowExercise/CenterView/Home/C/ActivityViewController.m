//
//  ActivityViewController.m
//  NowExercise
//
//  Created by 朱学森 on 2017/5/11.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "ActivityViewController.h"

@interface ActivityViewController ()
{
    UIWebView * web;
}
@end

@implementation ActivityViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    //关闭导航栏毛玻璃效果
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏颜色
    self.navigationController.navigationBar.barTintColor = COLOR(31, 31, 31);
    //导航栏标题
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(20)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"活动";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStyleDone target:self action:@selector(BackBtnClick:)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = THEMECOLOR;
    web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64)];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [web loadRequest:request];
    [self.view addSubview:web];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)BackBtnClick:(UIBarButtonItem *)item{
    if ([web canGoBack]) {
        [web goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
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
