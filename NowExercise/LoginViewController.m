//
//  LoginViewController.m
//  NowExercise
//
//  Created by mac on 16/10/21.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    self.numberTF.layer.borderWidth = 1;
    self.numberTF.layer.borderColor = THEMECOLOR.CGColor;
    [self.numberTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.numberTF.layer.cornerRadius = 5;
    self.numberTF.layer.masksToBounds = YES;
    
    self.SecurityTF.layer.borderColor = THEMECOLOR.CGColor;
    self.SecurityTF.layer.borderWidth = 1;
    [self.SecurityTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.SecurityTF.layer.cornerRadius = 5;
    self.SecurityTF.layer.masksToBounds = YES;
    
    self.SecurityBtn.layer.borderWidth = 1;
    self.SecurityBtn.layer.borderColor = THEMECOLOR.CGColor;
    self.SecurityBtn.layer.cornerRadius = 5;
    self.SecurityBtn.layer.masksToBounds = YES;
    
    self.LoginBtn.layer.masksToBounds = YES;
    self.LoginBtn.layer.cornerRadius = 5;
    self.LoginBtn.layer.borderWidth = 1;
    self.LoginBtn.layer.borderColor = THEMECOLOR.CGColor;
    
    // Do any additional setup after loading the view from its nib.
}
//验证码
- (IBAction)TestGetCode:(id)sender {
    [self startWithTime:60 title:@"获取验证码" countDownTitle:@"s后重新获取" countColor:[UIColor grayColor]];
    
}
- (IBAction)ChangeRootView:(id)sender {
    
    self.LoginChangeRootView();
}
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle countColor:(UIColor *)color {
    
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //[self.getCodeBtn setTitle:title forState:UIControlStateNormal];
                self.getCodeBtn.userInteractionEnabled = YES;
                self.timeLabel.text = title;
            });
        } else {
            int allTime = (int)timeLine + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.getCodeBtn.backgroundColor = color;
//                [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                self.timeLabel.text = [NSString stringWithFormat:@"%@%@",timeStr,subTitle];
                
                self.getCodeBtn.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
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
