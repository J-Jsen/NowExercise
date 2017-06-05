//
//  OrderModel.h
//  NowExercise
//
//  Created by Suger on 17/5/4.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject
//课程订单
STRING_PROPERTY(course)
STRING_PROPERTY(order_id)
STRING_PROPERTY(name)
STRING_PROPERTY(order_status)
STRING_PROPERTY(number)
STRING_PROPERTY(place)
STRING_PROPERTY(pre_time_area)
INTEGER_PROPERTY(pre_time)
STRING_PROPERTY(type)
INTEGER_PROPERTY(gd_status)
@property (nonatomic , strong) NSMutableDictionary * coach_info;
//套餐订单
STRING_PROPERTY(package_name)
STRING_PROPERTY(pay_status)
INTEGER_PROPERTY(pay_amount)
STRING_PROPERTY(package_content)

@end
