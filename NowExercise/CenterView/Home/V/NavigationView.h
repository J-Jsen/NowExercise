//
//  NavigationView.h
//  NowExercise
//
//  Created by mac on 17/2/7.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <CoreLocation/CoreLocation.h>

@protocol NavigationViewDelegate <NSObject>

- (void)NavigationViewMenuButtonClick;
- (void)NavigationViewRightBtnClick;
@end

@interface NavigationView : UIView<CLLocationManagerDelegate>

@property (nonatomic , weak) id<NavigationViewDelegate>delegate;
@property (nonatomic , assign) BOOL MenuStaus;
- (void)location;
/**
 打开状态方法
 */
- (void)openMenu;

/**
 关闭状态方法
 */
- (void)closeMenu;


/**
 初始化方法

 @param frame 导航栏大小
 @param title 标题
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame andtitle:(NSString *)title;

@end
