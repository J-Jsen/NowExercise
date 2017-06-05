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
//是否是课程支付界面(回调播放器用)
@property (nonatomic , assign) BOOL pay_class;

//@property (nonatomic , assign) BOOL ispay_money;

@property (nonatomic , assign) PayType paytype;
//是否是套餐支付
@property (nonatomic , assign) BOOL ispackage;
//课程id,套餐id
@property (nonatomic , copy) NSString * class_id;
//订单id(课程支付的时候用)
@property (nonatomic , copy) NSString * order_id;

@property (nonatomic , copy) void(^payback)(void);
//课程或套餐名字
@property (nonatomic , copy) NSString * name;

@property (nonatomic , assign) NSInteger price;

@end
