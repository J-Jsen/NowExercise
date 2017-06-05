//
//  AddPlaceViewController.m
//  NowExercise
//
//  Created by 朱学森 on 2017/5/9.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "AddPlaceViewController.h"
#import "NSString+Suger.h"
@interface AddPlaceViewController ()
{
    BOOL defaul;
}
@end

@implementation AddPlaceViewController

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
    titleLabel.text = @"新增地址";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick)];
    
    self.navigationItem.rightBarButtonItem = btn;
}
- (IBAction)setDefaultBtnClick:(id)sender {
    if (defaul) {
        _defaultLabel.backgroundColor = [UIColor whiteColor];
    }else{
        _defaultLabel.backgroundColor = [UIColor orangeColor];
    }
    defaul = !defaul;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = THEMECOLOR;
    _defaultLabel.layer.borderColor = MAKA_JIN_COLOR.CGColor;
    _defaultLabel.layer.borderWidth = 2;
    _defaultLabel.layer.cornerRadius = 7;
    _defaultLabel.layer.masksToBounds = YES;
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)saveClick{
    if (self.placeTF.text.length) {
        NSString * YN = @"";
        
        if (defaul) {
            YN = @"true";
        }else{
            YN = @"false";
        }
        NSString * str = [NSString CanUseString:self.placeTF.text];
        NSString * url = [NSString stringWithFormat:@"%@api/?method=address.add&address=%@&default=%@",BASEURL,str,YN];
        WeakSelf
        [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(NSDictionary *responseObject) {
            NSLog(@"新增成功");
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.delegate respondsToSelector:@selector(AddPlace)]) {
                    [self.delegate AddPlace];
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        } andfailBlock:^(NSError *error) {
            NSLog(@"新增失败");
        }];

    }else{
        [HttpRequest showAlertWithTitle:@"地址不能为空"];
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
