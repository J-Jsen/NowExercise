//
//  AppointmentView.m
//  NowExercise
//
//  Created by mac on 17/2/16.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "AppointmentView.h"

@interface AppointmentView()
{
    UIView * backgroundView;
    
    UILabel * nameLabel;
    UILabel * telLabel;
    UILabel * dateLabel;
    UILabel * timeLabel;
    UILabel * placeLabel;
    
}
@end

@implementation AppointmentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        nameLabel = [[UILabel alloc]init];
        telLabel = [[UILabel alloc]init];
        dateLabel = [[UILabel alloc]init];
        timeLabel = [[UILabel alloc]init];
        placeLabel = [[UILabel alloc]init];
        backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H, SCREEN_W, 170)];
        
        nameLabel.textColor = [UIColor whiteColor];
        telLabel.textColor = [UIColor whiteColor];
        dateLabel.textColor = [UIColor whiteColor];
        timeLabel.textColor = [UIColor whiteColor];
        placeLabel.textColor = [UIColor whiteColor];
        backgroundView.backgroundColor = COLOR(67, 67, 67);
        
        nameLabel.text = @"姓名";
        telLabel.text = @"电话";
        dateLabel.text = @"日期";
        timeLabel.text = @"时间";
        placeLabel.text = @"地址";
        
        [backgroundView addSubview:nameLabel];
        [backgroundView addSubview:telLabel];
        [backgroundView addSubview:dateLabel];
        [backgroundView addSubview:timeLabel];
        [backgroundView addSubview:placeLabel];
        
        self.nameTF = [[UITextField alloc]init];
        self.telTF = [[UITextField alloc]init];
        self.dateBtn = [[UIButton alloc]init];
        self.timeBtn = [[UIButton alloc]init];
        self.placeTF = [[UITextField alloc]init];
        
        self.BuyBtn = [[UIButton alloc]init];
        
        [backgroundView addSubview:self.nameTF];
        [backgroundView addSubview:self.telTF];
        [backgroundView addSubview:self.dateBtn];
        [backgroundView addSubview:self.timeBtn];
        [backgroundView addSubview:self.placeTF];
        
        [backgroundView addSubview:self.BuyBtn];
    
        [self addSubview:backgroundView];
        
    }
    return self;
}

- (void)layoutSubviews{
    
    nameLabel.frame = CGRectMake(10, 10, 40, 20);
    telLabel.frame = CGRectMake(10, 35, 40, 20);
    dateLabel.frame = CGRectMake(10, 60, 40, 20);
    timeLabel.frame = CGRectMake(10, 85, 40, 20);
    placeLabel.frame = CGRectMake(10, 110, 40, 20);
    
    self.nameTF.frame = CGRectMake(60, 10, SCREEN_W - 70, 20);
    self.telTF.frame = CGRectMake(60, 35, SCREEN_W - 70, 20);
    self.dateBtn.frame = CGRectMake(60, 60, SCREEN_W - 70, 20);
    self.timeBtn.frame = CGRectMake(60, 85, SCREEN_W - 70, 20);
    self.placeTF.frame = CGRectMake(60, 110, SCREEN_W - 70, 20);
    self.BuyBtn.frame = CGRectMake(0, 140, SCREEN_W, 20);
    
}
//点击空白处消失
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    backgroundView = nil;
    [self removeFromSuperview];
}
- (void)showAppoinmentViewWithViewController:(UIViewController *)ViewController{
    
    [ViewController.view addSubview:self];
    
    //添加pop动画
    POPBasicAnimation * anBasic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anBasic.fromValue = @(SCREEN_H);
    
    anBasic.toValue = @(backgroundView.center.y - 170);
    anBasic.beginTime = CACurrentMediaTime() + 1.0f;
    [backgroundView pop_addAnimation:anBasic forKey:@"position"];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
