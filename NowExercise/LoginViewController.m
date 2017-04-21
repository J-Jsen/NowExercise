//
//  LoginViewController.m
//  NowExercise
//
//  Created by mac on 16/10/21.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "LoginViewController.h"
#import "NSString+Suger.h"
@interface LoginViewController ()<UITextFieldDelegate>

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
    if ([HttpRequest phoneValidateNumber:self.numberTF.text]) {
        [self.SecurityTF resignFirstResponder];
        /***************网络请求token值*********************/
        
        [self startWithTime:60 title:@"获取验证码" countDownTitle:@"s后重新获取" countColor:[UIColor grayColor]];
        
    }else{
        [SRAlertView sr_showAlertViewWithTitle:@"提  示" message:@"请正确输入您的手机号码" leftActionTitle:@"确定" rightActionTitle:@"" animationStyle:AlertViewAnimationZoom selectAction:nil];
    }
    
}
- (IBAction)ChangeRootView:(id)sender {
    if ([HttpRequest phoneValidateNumber:self.numberTF.text]) {
        [SRAlertView sr_showAlertViewWithTitle:@"提  示" message:@"请正确输入您的手机号码" leftActionTitle:@"确定" rightActionTitle:@"" animationStyle:AlertViewAnimationZoom selectAction:nil];
    }else{
        if (self.SecurityTF.text.length == 0) {
            [SRAlertView sr_showAlertViewWithTitle:@"提  示" message:@"验证码不能为空,请重新输入" leftActionTitle:@"确定" rightActionTitle:@"" animationStyle:AlertViewAnimationZoom selectAction:nil];
        }else{
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            [SVProgressHUD setBackgroundColor:MAKA_JIN_COLOR];
            [SVProgressHUD setStatus:@"正在登录"];
            [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
            
            NSDictionary * dic = @{@"number"       : self.numberTF.text,
                                   @"code"         : self.SecurityTF.text,
                                   @"registerID"   : [JPUSHService registrationID]?[JPUSHService registrationID]:@""};
            NSString * loginUrl = [NSString stringWithFormat:@"%@userlogin/",BASEURL];
            [HttpRequest PostHttpwithUrl:loginUrl andparameters:dic andProgress:nil andsuccessBlock:^(NSDictionary *responseObject) {
                [Default setBool:YES forKey:@"login"];
                [Default setObject:self.numberTF.text forKey:@"phone"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.LoginChangeRootView();
                });
            } andfailBlock:^(NSError *error) {
                [HttpRequest showAlert];
            }];
        }
    }
    
}
//网络请求token值
- (void)getTokenStr{
    NSString* getTokenUrl = [NSString stringWithFormat:@"%@token/?number=%@", BASEURL, self.numberTF.text];
    [HttpRequest PostHttpwithUrl:getTokenUrl andparameters:nil andProgress:nil andsuccessBlock:^(NSDictionary * responseObject) {
        /*
         请求参数：number=18618265727&timestamp=12456&sign=e1a4b2dd5816ff40d125f836669652eb
         app_kye = guodongapps
         number 电话号码， timestamp： 时间戳  sign：签名
         将 number timestamp sign 参数值排序好 加上 app_key 得到 src_str
         
         签名= md5(src_str)
         */
        
        NSMutableArray * tokenArray            = [NSMutableArray array];
        //用户手机号
        NSString* photoNumber = self.numberTF.text;
        
        //当前时间戳
        NSString* timeString  = [NSString stringWithFormat:@"%ld",
                                 (long)[[NSDate date] timeIntervalSince1970]];
        // 将手机号和时间戳放入token数组
        [tokenArray addObject:photoNumber];
        [tokenArray addObject:timeString];
        // 接收token值
        if ([[responseObject allKeys] containsObject:@"token"]) {
            NSString *token = [responseObject objectForKey:@"token"];
            [tokenArray addObject:token];
        }
        // 数组排序
        NSMutableArray *sortedArray = (NSMutableArray *)[tokenArray sortedArrayUsingSelector:@selector(compare:)];
        // 遍历数组 将数组元素组成字符串
        NSString *sortedString = @"";
        for (int a = 0; a < [sortedArray count]; a++) {
            NSString *string = [sortedArray objectAtIndex:a];
            sortedString     = [NSString stringWithFormat:@"%@%@",sortedString,string];
        }
        
        NSString *tokenString = [NSString stringWithFormat:@"%@guodongapps",sortedString];
        NSString *MDString    = [tokenString md5:tokenString];
        
        
        /***************网络请求验证码*********************/
        
        NSString* getMessageUrl = [NSString stringWithFormat:@"%@sendcode/", BASEURL];
        NSDictionary* messagedict = @{ @"number" : self.numberTF.text,
                                       @"sign" : MDString,
                                       @"time" : timeString
                                       };
        [HttpRequest PostHttpwithUrl:getMessageUrl andparameters:messagedict andProgress:nil andsuccessBlock:^(NSDictionary * responseObject) {
            
        } andfailBlock:^(NSError *error) {
            [HttpRequest showAlert];
        }];
        
    } andfailBlock:^(NSError *error) {
        [HttpRequest showAlert];
    }];
    

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
                self.getCodeBtn.userInteractionEnabled = YES;
                self.timeLabel.text = title;
            });
        } else {
            int allTime = (int)timeLine + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.getCodeBtn.backgroundColor = color;
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
