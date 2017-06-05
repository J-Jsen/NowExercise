//
//  PreferentialCell.m
//  NowExercise
//
//  Created by mac on 17/3/15.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "PreferentialCell.h"

#define VIEW_HEIGHT           HEIGHT_6(90)

@interface PreferentialCell ()
{
    //背景视图
    UIView * backGroundView;
    //面值
    UILabel * valueLabel;
    //满足使用条件
    UILabel * conditionLabel;
    //左面背景
    UIView * leftBackGoundView;
    
    //优惠券类型 (现金券)
    UILabel * typeLabel;
    //优惠券标题 (立炼3月活动礼包)
    UILabel * titleLabel;
    
    //有效日期
    UILabel * toTimeLabel;
    //领取
    UIButton * getButton;
    
    //已领取或过期的
    UIView * cover;
    
}
@end

@implementation PreferentialCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = THEMECOLOR;
        //背景
        backGroundView = [[UIView alloc]initWithFrame:CGRectMake(15, 7.5, SCREEN_W - 30,VIEW_HEIGHT - 15)];
        backGroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backGroundView];
        //左背景
        leftBackGoundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_6(100), backGroundView.frame.size.height)];
        leftBackGoundView.backgroundColor = COLOR(231, 212, 194);
        [backGroundView addSubview:leftBackGoundView];
        //面值
        valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, leftBackGoundView.frame.size.width, (leftBackGoundView.frame.size.height - 10) * 2/3)];
        valueLabel.textAlignment = NSTextAlignmentCenter;
        valueLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(25)];
        [leftBackGoundView addSubview:valueLabel];
        
        //满足条件
        conditionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5 + valueLabel.frame.size.height, leftBackGoundView.frame.size.width, (leftBackGoundView.frame.size.height - 10) * 1/3)];
        conditionLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(14)];
        conditionLabel.textAlignment = NSTextAlignmentCenter;
        [leftBackGoundView addSubview:conditionLabel];
        
        CGFloat riht_X = leftBackGoundView.frame.size.width + 15;
        CGFloat backgroundView_Height = backGroundView.frame.size.height;
        CGFloat backgroundView_Width = backGroundView.frame.size.width;
        //类型
        typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(riht_X + 2, 14, WIDTH_6(40), 15)];
        typeLabel.textAlignment = NSTextAlignmentCenter;
        typeLabel.textColor = [UIColor grayColor];
        typeLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(12)];
        typeLabel.backgroundColor = COLOR(231, 212, 194);
        typeLabel.layer.cornerRadius = 2;
        typeLabel.layer.masksToBounds = YES;
        [backGroundView addSubview:typeLabel];
        //优惠券标题
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(typeLabel.frame.origin.x + typeLabel.frame.size.width + 2, 14, WIDTH_6(140), 15)];
        titleLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(13)];
        titleLabel.textColor = [UIColor grayColor];
        [backGroundView addSubview:titleLabel];
        
        //起始时间
        toTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(riht_X + 5 ,backgroundView_Height - 15 - 10, WIDTH_6(120), 12)];
        toTimeLabel.font = [UIFont systemFontOfSize:HEIGHT_6(11)];
        toTimeLabel.textColor = [UIColor grayColor];
        [backGroundView addSubview:toTimeLabel];
        
        //领取按钮
        getButton = [[UIButton alloc]initWithFrame:CGRectMake(backgroundView_Width - WIDTH_6(50) - 10, 12, WIDTH_6(50), WIDTH_6(50))];
        getButton.titleLabel.font = [UIFont systemFontOfSize:HEIGHT_6(14)];
        [getButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        getButton.layer.cornerRadius = WIDTH_6(25.0);
        getButton.layer.masksToBounds = YES;
        getButton.backgroundColor = COLOR(231, 212, 194);
        [backGroundView addSubview:getButton];
        
        valueLabel.text = @"¥50";
        conditionLabel.text = @"满300元可用";
        typeLabel.text = @"现金券";
        titleLabel.text = @"立炼3月活动礼包";
        toTimeLabel.text = @"2017.03.01-2016.22.22";
        [getButton setTitle:@"已领取" forState:UIControlStateNormal];
        
//        conditionLabel.backgroundColor = [UIColor redColor];
        
        
    }
    return self;
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
