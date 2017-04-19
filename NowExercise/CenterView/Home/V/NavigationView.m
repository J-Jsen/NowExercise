//
//  NavigationView.m
//  NowExercise
//
//  Created by mac on 17/2/7.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "NavigationView.h"

@interface NavigationView()

/**
 菜单栏按钮
 */
@property (nonatomic , strong) MenuButton * MenuBtn;

/**
 标题栏
 */
@property (nonatomic , strong) UILabel * TitleLabel;

/**
 右方按钮
 */
@property (nonatomic , strong) UIButton * RightButton;


@end

@implementation NavigationView

- (instancetype)initWithFrame:(CGRect)frame andtitle:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        //背景色
        self.backgroundColor = THEMECOLOR;
        //菜单button
        self.MenuBtn = [MenuButton shareMenuButton];
        self.MenuBtn.frame = CGRectMake(WIDTH_6(18), 30, WIDTH_6(24), WIDTH_6(24));
        [self.MenuBtn addTarget:self action:@selector(MenuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //self.MenuButton = [[VBFPopFlatButton alloc]initWithFrame: buttonType:buttonMenuType buttonStyle:buttonRoundedStyle animateToInitialState:YES];
        
        [self addSubview:self.MenuBtn];
        
        
        self.TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W / 2.0, 23)];
        self.TitleLabel.center = CGPointMake(self.center.x, self.MenuBtn.center.y);
        
        self.TitleLabel.textAlignment = NSTextAlignmentCenter;
        self.TitleLabel.font = FONT(@"AmericanTypewriter", 17);
        self.TitleLabel.textColor = [UIColor redColor];
        self.TitleLabel.text = title;
        
        [self addSubview:self.TitleLabel];
        
        self.RightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W - 34, 30, 24, 24)];
        
        self.RightButton.backgroundColor = [UIColor redColor];
        
        [self addSubview:self.RightButton];
        
        
    }
    return self;
    
}

- (void)openMenu{
    
    [self.MenuBtn animateToType:buttonPausedType];
    
}

- (void)closeMenu{
    
    [self.MenuBtn animateToType:buttonMenuType];
    
    
}
- (void)MenuBtnClick:(MenuButton *)btn{
    //if ([self.delegate performSelector:@selector(NavigationViewMenuButtonClick)]) {
        [self.delegate NavigationViewMenuButtonClick];
    //}
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
