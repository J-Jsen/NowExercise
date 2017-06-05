//
//  SugerAlertView.h
//  NowExercise
//
//  Created by 朱学森 on 2017/5/5.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassModel.h"
typedef enum : NSUInteger {
    ClassTypeWithExperience,
    ClassTypeWithClass,
} ClassTypes;


@protocol SugerAlertViewDelegate <NSObject>

//- (void)orderWithName:(NSString *)name tel:(NSString *)tel date:(NSString *)date time:(NSString *)time place:(NSString *)place classname:(NSString *)classname;
@optional
- (void)OrderWithClassID:(NSString *)class_id rmb:(NSInteger)rmb classname:(NSString *)classname orderid:(NSString *)orderid;

- (void)SRAlertDismiss;
@end

@interface SugerAlertView : UIView

@property (nonatomic , weak) id<SugerAlertViewDelegate> delegate;

+ (void)sr_showAlertViewWithPlaceOrType:(ClassTypes)classtype Delegate:(id<SugerAlertViewDelegate>)delegate model:(ClassModel *)model;



@end
