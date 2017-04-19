//
//  PayViewController.h
//  NowExercise
//
//  Created by mac on 17/3/27.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PayTypeWithAliPay,
    PayTypeWithWechatPay,
    PayTypeWithYinlianPay,
} PayType;


@interface PayViewController : UIViewController

@property (nonatomic , assign) BOOL ispay_money;

@property (nonatomic , assign) PayType paytype;

@property (nonatomic , copy) void(^payback)(void);

@end
