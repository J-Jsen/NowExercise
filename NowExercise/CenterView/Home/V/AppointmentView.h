//
//  AppointmentView.h
//  NowExercise
//
//  Created by mac on 17/2/16.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentView : UIView

/**
 名字
 */
@property (nonatomic , strong) UITextField * nameTF;
/**
 电话
 */
@property (nonatomic , strong) UITextField * telTF;
/**
 日期
 */
@property (nonatomic , strong) UIButton * dateBtn;
/**
 时间
 */
@property (nonatomic , strong) UIButton * timeBtn;
/**
 地点
 */
@property (nonatomic , strong) UITextField * placeTF;
/**
 下单
 */
@property (nonatomic , strong) UIButton * BuyBtn;

- (void)showAppoinmentViewWithViewController:(UIViewController *)ViewController;

@end
