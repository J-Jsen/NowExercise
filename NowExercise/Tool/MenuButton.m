//
//  MenuButton.m
//  NowExercise
//
//  Created by mac on 17/2/6.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "MenuButton.h"

@implementation MenuButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (MenuButton *)shareMenuButton{
    
    static MenuButton * shareMenuButton = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareMenuButton = [[self alloc]initWithFrame:CGRectMake(0, 0, 24, 24) buttonType:buttonMenuType buttonStyle:buttonPlainStyle animateToInitialState:YES];
        
        [shareMenuButton setTintColor:[UIColor whiteColor]];
//        shareMenuButton.lineRadius = 1.0;
    });
    
    return shareMenuButton;
}

+ (void)openMenu{
    [[MenuButton shareMenuButton] animateToType:buttonPausedType];
    
}
+ (void)closeMenu{
    [[MenuButton shareMenuButton] animateToType:buttonMenuType];
}
@end
