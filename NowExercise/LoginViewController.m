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
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.navigationController.navigationBarHidden = YES;
    
    [self.numberTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 40)];
    imageV.image = [UIImage imageNamed:@"手机号.png"];
    [self.numberTF setLeftView:imageV];
    self.numberTF.leftViewMode = UITextFieldViewModeAlways;
    imageV.contentMode = UIViewContentModeLeft;
    [self.SecurityTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    UIImageView * imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 40)];
    imageV1.contentMode = UIViewContentModeLeft;
    imageV1.image = [UIImage imageNamed:@"验证码.png"];
    [self.SecurityTF setLeftView:imageV1];
    self.SecurityTF.leftViewMode = UITextFieldViewModeAlways;

    self.SecurityBtn.layer.cornerRadius = 17.5;
    self.SecurityBtn.layer.masksToBounds = YES;
    
    self.LoginBtn.layer.masksToBounds = YES;
    self.LoginBtn.layer.cornerRadius = 22;
    self.timeLabel.layer.cornerRadius = 17.5;
    self.timeLabel.layer.masksToBounds = YES;
    if (self.back) {
        self.backBtn.hidden = YES;
    }else{
        self.backBtn.hidden = NO;
    }
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)SelfDisMiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//验证码
- (IBAction)TestGetCode:(id)sender {
    if ([HttpRequest phoneValidateNumber:self.numberTF.text]) {
        [self.SecurityTF becomeFirstResponder];
        /***************网络请求token值*********************/
        [self getTokenStr];
        
    }else{
        [SRAlertView sr_showAlertViewWithTitle:@"提  示" message:@"请正确输入您的手机号码" leftActionTitle:@"确定" rightActionTitle:nil animationStyle:AlertViewAnimationZoom selectAction:nil];
    }
    
}
- (IBAction)ChangeRootView:(id)sender {
    if (![HttpRequest phoneValidateNumber:self.numberTF.text]) {
        [SRAlertView sr_showAlertViewWithTitle:@"提  示" message:@"请正确输入您的手机号码" leftActionTitle:@"确定" rightActionTitle:nil animationStyle:AlertViewAnimationZoom selectAction:nil];
    }else{
        if (self.SecurityTF.text.length == 0) {
            [SRAlertView sr_showAlertViewWithTitle:@"提  示" message:@"验证码不能为空,请重新输入" leftActionTitle:@"确定" rightActionTitle:nil animationStyle:AlertViewAnimationZoom selectAction:nil];
        }else{
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            [SVProgressHUD setBackgroundColor:MAKA_JIN_COLOR];
            [SVProgressHUD setStatus:@"正在登录"];
            [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
            
            NSDictionary * dic = @{@"number"       : self.numberTF.text,
                                   @"code"         : self.SecurityTF.text,
                                   @"registerID"   : [JPUSHService registrationID]?[JPUSHService registrationID]:@""};
            NSString * loginUrl = [NSString stringWithFormat:@"%@userlogin/",BASEURL];
            WeakSelf
            [HttpRequest postHttpwithUrl:loginUrl andparameters:dic andProgress:nil andsuccessBlock:^(NSDictionary *responseObject) {
                [Default setBool:YES forKey:@"login"];
                [Default setObject:weakSelf.numberTF.text forKey:@"phone"];
                
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                [dict setObject:@"ture" forKey:@"login"];
//                NSLog(@"%@",responseObject);
                // NSHomeDirectory() 沙盒根目录的路径
                NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/d.plist"];
                [dict writeToFile:path atomically:YES];
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGIN" object:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (weakSelf.back) {
                        weakSelf.LoginChangeRootView();
                        
                    }else{
                        if ([weakSelf.delegate respondsToSelector:@selector(login)]) {
                            [weakSelf.delegate login];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGIN" object:nil];

//                            [HttpRequest judgeWhetherUserLogin];
                        }
                        [weakSelf dismissViewControllerAnimated:YES completion:nil];
                        
                    }
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
    [HttpRequest PostHttpwithUrl:getTokenUrl andparameters:nil andProgress:nil andsuccessBlock:^(id responseObject) {
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
//        NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
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
        [HttpRequest postHttpwithUrl:getMessageUrl andparameters:messagedict andProgress:^(NSProgress *progress) {
            
        } andsuccessBlock:^(NSDictionary * responseObject) {
            NSLog(@"%@",responseObject);
            [self startWithTime:60 title:@"获取验证码" countDownTitle:@"s" countColor:[UIColor grayColor]];
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.numberTF resignFirstResponder];
    [self.SecurityBtn resignFirstResponder];
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
