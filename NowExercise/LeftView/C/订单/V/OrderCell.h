//
//  OrderCell.h
//  NowExercise
//
//  Created by mac on 17/3/29.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
typedef enum : NSUInteger {
    OrderStatusCoachGo,
    OrderStatusFinish,
    OrderStatusCancel,
    OrderStatusNotPay,
} OrderStatus;
@protocol OrderDelegate <NSObject>

- (void)deleteOrderWithIndexRow:(NSInteger )index_row;
- (void)evaluateOrderWithIndexRow:(NSInteger)index_row;
@end

@interface OrderCell : UITableViewCell

@property (nonatomic , assign) NSInteger index_row;

@property (nonatomic , weak) id <OrderDelegate> delegate;
- (void)createCellWithModel:(OrderModel *)model;
@end
