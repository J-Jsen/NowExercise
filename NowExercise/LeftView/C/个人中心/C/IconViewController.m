//
//  IconViewController.m
//  NowExercise
//
//  Created by mac on 17/3/23.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "IconViewController.h"

@interface IconViewController ()
@property (nonatomic , strong) UIImageView * imageV;

@end

@implementation IconViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createNavigationView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createUI];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)createUI{
    self.imageV = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.imageV.backgroundColor = [UIColor blackColor];
    self.imageV.contentMode = UIViewContentModeCenter;
    
    [self.view addSubview:self.imageV];
    
}

- (void)createNavigationView{
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 22)];
    [btn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [btn setTitle:@"个人信息" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonClick)];
    
    
    self.navigationItem.rightBarButtonItem = right;
    
    
    
    
    //关闭导航栏毛玻璃效果
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏颜色
    self.navigationController.navigationBar.barTintColor = COLOR(31, 31, 31);
    //导航栏标题
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(20)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"个人头像";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 返回
- (void)leftBarButtonClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark 修改头像按钮
- (void)rightBarButtonClick{
    [LSActionSheet showWithTitle:@"更换头像" destructiveTitle:@"保存图片" otherTitles:@[@"拍照",@"从手机相册里选择"] block:^(int index) {
        switch (index) {
            case 0://拍照
            {
                
            }
                break;
            case 1://手机相册
            {
                
            }
                break;
            case 2://保存图片
            {
                
            }
                break;
                
            default:
                break;
        }
        
        
        
    }];
    
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
