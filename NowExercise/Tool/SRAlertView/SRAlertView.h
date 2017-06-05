//
//  SRAlertView.h
//  SRAlertViewDemo
//
//  Created by 郭伟林 on 16/7/8.
//  Copyright © 2016年 SR. All rights reserved.
//

/**
 *  If you have any question, submit an issue or contact me.
 *  QQ: 1990991510
 *  Email: guowilling@qq.com
 *
 *  If this repo helps you, please give it a star, thanks a lot.
 *  Github: https://github.com/guowilling/SRAlertView
 *
 *  Have Fun.
 */

#import <UIKit/UIKit.h>

@class SRAlertView;


typedef UIView * (^AlertViewBlock)(void);
//typedef enum : NSUInteger {
//    ClassTypeexperience,
//    ClassTypeClass,
//} ClassType;

typedef NS_ENUM(NSInteger, AlertViewActionType) {
    AlertViewActionTypeLeft,
    AlertViewActionTypeRight,
};

typedef NS_ENUM(NSInteger, AlertViewAnimationStyle) {
    AlertViewAnimationNone,
    AlertViewAnimationZoom,
    AlertViewAnimationTopToCenterSpring,
    AlertViewAnimationDownToCenterSpring,
    AlertViewAnimationLeftToCenterSpring,
    AlertViewAnimationRightToCenterSpring,
};

@protocol SRAlertViewDelegate <NSObject>
@optional
- (void)alertViewDidSelectAction:(AlertViewActionType)actionType;
//- (void)orderWithName:(NSString *)name tel:(NSString *)tel date:(NSString *)date time:(NSString *)time place:(NSString *)place classname:(NSString *)classname;
//- (void)SRAlertDismiss;
@end

typedef void(^AlertViewDidSelectAction)(AlertViewActionType actionType);

@interface SRAlertView : UIView

/**
 The Animation style to show alert.
 */
@property (nonatomic, assign) AlertViewAnimationStyle animationStyle;

/**
 Whether blur the current background view, default is YES.
 */
@property (nonatomic, assign) BOOL blurCurrentBackgroundView;

/**
 Action's title color when highlighted.
 */
@property (nonatomic, strong) UIColor *actionWhenHighlightedTitleColor;

/**
 Action's background color when highlighted.
 */
@property (nonatomic, strong) UIColor *actionWhenHighlightedBackgroundColor;

#pragma mark - BLOCK

/**
 Quickly show a alert view with block.
 */
+ (void)sr_showAlertViewWithTitle:(NSString *)title
                          message:(NSString *)message
                  leftActionTitle:(NSString *)leftActionTitle
                 rightActionTitle:(NSString *)rightActionTitle
                   animationStyle:(AlertViewAnimationStyle)animationStyle
                     selectAction:(AlertViewDidSelectAction)selectAction;

/**
 Init a Alert view with block.
 */
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
              leftActionTitle:(NSString *)leftActionTitle
             rightActionTitle:(NSString *)rightActionTitle
               animationStyle:(AlertViewAnimationStyle)animationStyle
                 selectAction:(AlertViewDidSelectAction)selectAction;

#pragma mark - DELEGATE

/**
 Quickly show a alert view with delegate.
 */
+ (void)sr_showAlertViewWithTitle:(NSString *)title
                          message:(NSString *)message
                  leftActionTitle:(NSString *)leftActionTitle
                 rightActionTitle:(NSString *)rightActionTitle
                   animationStyle:(AlertViewAnimationStyle)animationStyle
                         delegate:(id<SRAlertViewDelegate>)delegate;
#pragma mark bymyself_Suger
/**
 Init a Alert view with delegate.
 */
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
              leftActionTitle:(NSString *)leftActionTitle
             rightActionTitle:(NSString *)rightActionTitle
               animationStyle:(AlertViewAnimationStyle)animationStyle
                     delegate:(id<SRAlertViewDelegate>)delegate;

- (void)show;


//+ (void)sr_showAlertViewWithPlaceOrType:(ClassType)classtype Delegate:(id<SRAlertViewDelegate>)delegate;
//- (void)showalert;

+ (void)suger_showAlertWithView:(UIView *)alertViewBlock;


@end
