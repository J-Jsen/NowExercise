//
//  MenuButton.h
//  NowExercise
//
//  Created by mac on 17/2/6.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "VBFPopFlatButton.h"

/**
 菜单栏按钮(单例)
 */
@interface MenuButton : VBFPopFlatButton

+ (MenuButton *)shareMenuButton;
+ (void)openMenu;
+ (void)closeMenu;

@end
