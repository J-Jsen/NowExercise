//
//  NameViewController.m
//  NowExercise
//
//  Created by 朱学森 on 2017/5/8.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "NameViewController.h"
#import "NSString+Suger.h"
@interface NameViewController ()
{
    UITextView * textView;
}
@end

@implementation NameViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //关闭导航栏毛玻璃效果
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏颜色
    self.navigationController.navigationBar.barTintColor = COLOR(31, 31, 31);
    //导航栏标题
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(20)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"用户名";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick)];

    self.navigationItem.rightBarButtonItem = btn;
}
- (void)saveClick{
    WeakSelf;
    if (self.nameTF.text == nil) {
        [HttpRequest showAlertWithTitle:@"用户名不能为空"];
    }else{
        NSString * string = [self.nameTF.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet illegalCharacterSet]];
        NSString * url = [NSString stringWithFormat:@"%@api/?method=user.set_userinfo&nickname=%@",BASEURL,string];
        [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(NSDictionary *responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [HttpRequest showAlertWithTitle:@"修改成功"];
                if ([weakSelf.delegate respondsToSelector:@selector(NameStr:)]) {
                    [self.delegate NameStr:weakSelf.nameTF.text];
                }
            });
        } andfailBlock:^(NSError *error) {
           
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = THEMECOLOR;
    self.nameTF.text = self.name;
    self.nameTF.leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.nameTF.leftViewMode = UITextFieldViewModeAlways;
    // Do any additional setup after loading the view from its nib.
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
