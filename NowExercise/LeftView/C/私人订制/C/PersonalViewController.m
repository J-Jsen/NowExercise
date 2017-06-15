//
//  PersonalViewController.m
//  NowExercise
//
//  Created by mac on 17/1/21.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "PersonalViewController.h"

@interface PersonalViewController ()
{
    UIWebView * web;
}
@end

@implementation PersonalViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createNavigationView];
}
//自定制导航栏
- (void)createNavigationView{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
    //关闭导航栏毛玻璃效果
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏颜色
    self.navigationController.navigationBar.barTintColor = COLOR(31, 31, 31);
    //导航栏标题
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(20)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"私人订制";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = THEMECOLOR;
    NSString * url = [NSString stringWithFormat:@"%@api/?method=diary.personal_list",BASEURL];
    WeakSelf
    [HttpRequest GetHttpwithUrl:url parameters:nil andsuccessBlock:^(NSDictionary *responseObject) {
        if ([[responseObject objectForKey:@"rc"] integerValue] == 0) {
            NSArray * arr = responseObject[@"data"];
            if (arr.count) {
                NSDictionary * dic = arr[0];
                NSString * person_id = dic[@"package_id"];
                [Default setObject:person_id forKey:@"person_id"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf loadWeb];
                });
            }else{
                [Default setObject:@"" forKey:@"person_id"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [HttpRequest showAlertWithTitle:@"您还没有私人订制套餐"];
                    return;
                });
            }
        }else{
            
        }
    } andfailBlock:^(NSError *error) {
        
    }];

    // Do any additional setup after loading the view from its nib.
}
- (void)loadWeb{
    web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64)];
    NSString * person = [Default objectForKey:@"person_id"];
    NSString * url = [NSString stringWithFormat:@"%@personal/%@/",BASEURL,person];
    web.backgroundColor = THEMECOLOR;
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [web loadRequest:request];
    
    [self.view addSubview:web];

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
