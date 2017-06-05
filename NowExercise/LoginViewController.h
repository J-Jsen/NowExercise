//
//  LoginViewController.h
//  NowExercise
//
//  Created by mac on 16/10/21.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginDelegate <NSObject>
@optional
- (void)changeRoot;
- (void)login;
- (void)loginSuceess;
@end

@interface LoginViewController : UIViewController

@property (nonatomic , copy) void(^LoginChangeRootView)(void);
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UITextField *SecurityTF;
@property (weak, nonatomic) IBOutlet UIButton *SecurityBtn;
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic ,assign) BOOL back;
@property (nonatomic , weak)id <LoginDelegate>delegate;


@end
