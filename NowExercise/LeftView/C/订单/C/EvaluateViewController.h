//
//  EvaluateViewController.h
//  NowExercise
//
//  Created by 朱学森 on 2017/5/12.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
@protocol EvaluateViewControllerDelegate <NSObject>

- (void)EvaluateSuceess:(NSUInteger)index;

@end

@interface EvaluateViewController : UIViewController
@property (nonatomic , strong) OrderModel * model;


STRING_PROPERTY(order_id)
INTEGER_PROPERTY(index)
@property (nonatomic , weak) id<EvaluateViewControllerDelegate> delegate;
@end
