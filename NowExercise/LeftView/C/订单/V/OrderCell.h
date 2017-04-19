//
//  OrderCell.h
//  NowExercise
//
//  Created by mac on 17/3/29.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    OrderStatusCoachGo,
    OrderStatusFinish,
    OrderStatusCancel,
    OrderStatusNotPay,
} OrderStatus;

@interface OrderCell : UITableViewCell

@property (nonatomic , assign) NSInteger index_row;

@end
