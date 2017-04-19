//
//  DetailBodyCollectionViewCell.m
//  NowExercise
//
//  Created by mac on 17/4/10.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "DetailBodyCollectionViewCell.h"
#import "UILabel+Suger.h"
#import "UIImageView+Suger.h"
@interface DetailBodyCollectionViewCell ()
{
    //小圆点
    UIImageView * pointImageV;
    //时间
    UILabel * timeLabel;
    //左图片
    UIImageView * leftImageV;
    //右图片
    UIImageView * rightImageV;
    //身高
    UILabel * heightLabel;
    //体重
    UILabel * weightLabel;
    UILabel * weight_Static_Label;
    //腰围
    UILabel * waisLabel;
    //臀围
    UILabel * hipLabel;
    //脂肪百分比
    UILabel * fatLabel;
    UILabel * fat_Static_Label;
    
    //BMI
    UILabel * BMILabel;
    UILabel * BMI_Static_Label;
    //腰臀比例
    UILabel * Percentage_Waist_Hip_Label;
    UILabel * Percentage_Waist_Static_label;
    //腿部
    UILabel * legLabel;
    //臂部
    UILabel * armLabel;
    //胸围
    UILabel * bustLabel;
    //肱三头肌皮脂
    UILabel * Sebum_triceps_Label;
    //髋嵴上缘皮脂
    UILabel * Sebum_Pelvis_Label;
    //肩胛下缘皮脂
    UILabel * Sebum_Scapular_Label;
    //腹部皮脂
    UILabel * Sebum_Stomach_Label;
    //大腿皮脂
    UILabel * Sebum_Leg_Label;
    //皮脂总和
    UILabel * Sebum_Num_Label;
    //静态心率
    UILabel * Static_Heart_Label;
    //血压
    UILabel * Blood_Pressure_Label;
    //目标心率
    UILabel * Target_Heart_Label;

}
@end

@implementation DetailBodyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        self.userInteractionEnabled = YES;
        [self createUI];
        [self loadData];
    }
    return self;
}
- (void)createUI{
    pointImageV = [[UIImageView alloc]initImageView];
    [self addSubview:pointImageV];
    
    timeLabel = [[UILabel alloc]initDatalabel];
    [self addSubview:timeLabel];
    
    leftImageV = [[UIImageView alloc]initImageView];
    UITapGestureRecognizer * leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftTap:)];
    leftImageV.userInteractionEnabled = YES;
    [leftImageV addGestureRecognizer:leftTap];
    [self addSubview:leftImageV];
    
    rightImageV = [[UIImageView alloc]initImageView];
    UITapGestureRecognizer * rightTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightTap:)];
    rightImageV.userInteractionEnabled = YES;
    [rightImageV addGestureRecognizer:rightTap];
    [self addSubview:rightImageV];
    
    heightLabel = [[UILabel alloc]initDatalabel];
    [self addSubview:heightLabel];
    
    weightLabel = [[UILabel alloc]initDatalabel];
    [self addSubview:weightLabel];
    weight_Static_Label = [[UILabel alloc]initDatalabel];
    weight_Static_Label.backgroundColor = [UIColor redColor];
    weight_Static_Label.font = [UIFont systemFontOfSize:HEIGHT_6(14)];
    [self addSubview:weight_Static_Label];
    
    waisLabel = [[UILabel alloc]initDatalabel];
    [self addSubview:waisLabel];
    
    hipLabel = [[UILabel alloc]initDatalabel];
    [self addSubview:hipLabel];
    
    fatLabel = [[UILabel alloc]initDatalabel];
    [self addSubview:fatLabel];
    fat_Static_Label = [[UILabel alloc]initDatalabel];
    fat_Static_Label.backgroundColor = [UIColor redColor];
    fat_Static_Label.font = [UIFont systemFontOfSize:HEIGHT_6(14)];
    [self addSubview:fat_Static_Label];
    
    BMILabel = [[UILabel alloc]initDatalabel];
    [self addSubview:BMILabel];
    BMI_Static_Label = [[UILabel alloc]initDatalabel];
    BMI_Static_Label.font = [UIFont systemFontOfSize:HEIGHT_6(14)];
    BMI_Static_Label.backgroundColor = [UIColor redColor];
    [self addSubview:BMI_Static_Label];
    
    Percentage_Waist_Hip_Label = [[UILabel alloc]initDatalabel];
    [self addSubview:Percentage_Waist_Hip_Label];
    Percentage_Waist_Static_label = [[UILabel alloc]initDatalabel];
    Percentage_Waist_Static_label.font = [UIFont systemFontOfSize:HEIGHT_6(14)];
    Percentage_Waist_Static_label.backgroundColor = [UIColor redColor];
    [self addSubview:Percentage_Waist_Static_label];
    
    legLabel = [[UILabel alloc]initDatalabel];
    [self addSubview:legLabel];
    
    armLabel = [[UILabel alloc]initDatalabel];

    [self addSubview:armLabel];
    
    bustLabel = [[UILabel alloc]initDatalabel];
     [self addSubview:bustLabel];
    
    Sebum_triceps_Label = [[UILabel alloc]initDatalabel];
    [self addSubview:Sebum_triceps_Label];
    
    Sebum_Pelvis_Label = [[UILabel alloc]initDatalabel];
    [self addSubview:Sebum_Pelvis_Label];
    
    Sebum_Scapular_Label = [[UILabel alloc]initDatalabel];
    [self addSubview:Sebum_Scapular_Label];
    
    Sebum_Stomach_Label = [[UILabel alloc]initDatalabel];
    [self addSubview:Sebum_Stomach_Label];
    
    Sebum_Leg_Label = [[UILabel alloc]initDatalabel];
    [self addSubview:Sebum_Leg_Label];
    
    Sebum_Num_Label = [[UILabel alloc]initDatalabel];
    [self addSubview:Sebum_Num_Label];
    
    Static_Heart_Label = [[UILabel alloc]initDatalabel];
    [self addSubview:Static_Heart_Label];
    
    Blood_Pressure_Label = [[UILabel alloc]initDatalabel];
    [self addSubview:Blood_Pressure_Label];
    
    Target_Heart_Label = [[UILabel alloc]initDatalabel];
    [self addSubview:Target_Heart_Label];
    
//    weight_Static_Label.hidden = YES;
//    fat_Static_Label.hidden = YES;
//    BMI_Static_Label.hidden = YES;
//    Percentage_Waist_Static_label.hidden = YES;
    weight_Static_Label.alpha = 0;
    fat_Static_Label.alpha = 0;
    BMI_Static_Label.alpha = 0;
    Percentage_Waist_Static_label.alpha = 0;

}
- (void)loadData{
    timeLabel.text = @"2000-10-10";
    heightLabel.text = @"100cm";
    weightLabel.text = @"66kg";
    waisLabel.text = @"33";
    hipLabel.text = @"22";
    fatLabel.text = @"222";
    BMILabel.text = @"sda";
    Percentage_Waist_Hip_Label.text = @"dsa";
    leftImageV.image = [UIImage imageNamed:@"侧边栏.png"];
    rightImageV.image = [UIImage imageNamed:@"侧边栏.png"];
    legLabel.text = @"22\n22\n22\n22\n";
    legLabel.backgroundColor = [UIColor purpleColor];
    Target_Heart_Label.text = @"00";
    [UILabel changeLineSpaceForLabel:legLabel WithSpace:10];
    [UILabel changeLineSpaceForLabel:armLabel WithSpace:10];
    [UILabel changeLineSpaceForLabel:bustLabel WithSpace:10];
    legLabel.textAlignment = NSTextAlignmentCenter;
    armLabel.textAlignment = NSTextAlignmentCenter;
    bustLabel.textAlignment = NSTextAlignmentCenter;
}
- (void)layoutSubviews{
    CGFloat title_H = HEIGHT_6(45) + 1;
    CGFloat title_H_1 = HEIGHT_6(45);

    [pointImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.width.height.mas_offset(10);
        make.centerX.offset(0);
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(HEIGHT_6(20));
        make.top.mas_equalTo(pointImageV.mas_bottom).offset(5);
    }];
    
    [leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.top.mas_equalTo(timeLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(HEIGHT_6(125) - 10);
        make.width.mas_equalTo(self.frame.size.width / 2 - 8);
    }];
    
    [rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.top.mas_equalTo(timeLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(HEIGHT_6(125) - 10);
        make.width.mas_equalTo(self.frame.size.width / 2 - 8);
    }];
    
    [heightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(HEIGHT_6(160) + 11);
        make.left.right.offset(0);
        make.height.mas_equalTo(title_H);
        
    }];
    
    [weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(heightLabel.mas_bottom);
        make.height.mas_equalTo(title_H);
    }];
    
    [weight_Static_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(35);
        make.top.mas_equalTo(heightLabel.mas_bottom);
        make.width.mas_equalTo(WIDTH_6(25));
        make.height.mas_equalTo(HEIGHT_6(15));
    }];
    
    [waisLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(weightLabel.mas_bottom);
        make.height.mas_equalTo(title_H);
    }];
    
    [hipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(waisLabel.mas_bottom);
        make.height.mas_equalTo(title_H);
    }];
    
    [fatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(hipLabel.mas_bottom);
        make.height.mas_equalTo(title_H);
    }];
    [fat_Static_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(35);
        make.width.mas_equalTo(WIDTH_6(25));
        make.height.mas_equalTo(HEIGHT_6(15));
        make.top.mas_equalTo(hipLabel.mas_bottom);
    }];
    
    [BMILabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(fatLabel.mas_bottom);
        make.height.mas_equalTo(title_H);
    }];
    [BMI_Static_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(35);
        make.top.mas_equalTo(fatLabel.mas_bottom);
        make.height.mas_equalTo(HEIGHT_6(15));
        make.width.mas_equalTo(25);
    }];
    
    [Percentage_Waist_Hip_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(BMILabel.mas_bottom);
        make.height.mas_equalTo(title_H);
    }];
    [Percentage_Waist_Static_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(35);
        make.width.mas_equalTo(WIDTH_6(25));
        make.height.mas_equalTo(HEIGHT_6(15));
        make.top.mas_equalTo(BMILabel.mas_bottom);
    }];
    
    [legLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(Percentage_Waist_Hip_Label.mas_bottom);
        make.height.mas_equalTo(title_H_1 * 3 + 1);
    }];
    [armLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(title_H_1 * 3 + 1);
        make.top.mas_equalTo(legLabel.mas_bottom);
    }];
    
    [bustLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(armLabel.mas_bottom);
        make.height.mas_equalTo(title_H_1 * 2 + 1);
    }];
    
    [Sebum_triceps_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(bustLabel.mas_bottom);
        make.height.mas_equalTo(title_H);
    }];
    
    [Sebum_Pelvis_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(Sebum_triceps_Label.mas_bottom);
        make.height.mas_equalTo(title_H);
    }];
    
    [Sebum_Scapular_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(Sebum_Pelvis_Label.mas_bottom);
        make.height.mas_equalTo(title_H);
    }];
    
    [Sebum_Stomach_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(Sebum_Scapular_Label.mas_bottom);
        make.height.mas_equalTo(title_H);
    }];
    
    [Sebum_Leg_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(Sebum_Stomach_Label.mas_bottom);
        make.height.mas_equalTo(title_H);
    }];
    
    [Sebum_Num_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(Sebum_Leg_Label.mas_bottom);
        make.height.mas_equalTo(title_H);
    }];
    
    [Static_Heart_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(Sebum_Num_Label.mas_bottom);
        make.height.mas_equalTo(title_H);
    }];
    
    [Blood_Pressure_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(Static_Heart_Label.mas_bottom);
        make.height.mas_equalTo(title_H);
    }];
    
    [Target_Heart_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(Blood_Pressure_Label.mas_bottom);
        make.height.mas_equalTo(title_H_1);
    }];
}

- (void)disselectCell{
    weight_Static_Label.alpha = 1;
    fat_Static_Label.alpha = 1;
    BMI_Static_Label.alpha = 1;
    Percentage_Waist_Static_label.alpha = 1;

    
    UIFont * font = [UIFont systemFontOfSize:HEIGHT_6(14)];
    heightLabel.font = font;
    heightLabel.textColor = [UIColor grayColor];
    [UIView animateWithDuration:0.3 animations:^{
        heightLabel.transform                = CGAffineTransformMakeScale(10.0 / 11 , 10.0/11);
        weightLabel.transform                = CGAffineTransformMakeScale(10.0 / 11 , 10.0/11);
        waisLabel.transform                  = CGAffineTransformMakeScale(10.0 / 11 , 10.0/11);
        hipLabel.transform                   = CGAffineTransformMakeScale(10.0 / 11 , 10.0/11);
        fatLabel.transform                   = CGAffineTransformMakeScale(10.0 / 11 , 10.0/11);
        BMILabel.transform                   = CGAffineTransformMakeScale(10.0 / 11 , 10.0/11);
        Percentage_Waist_Hip_Label.transform = CGAffineTransformMakeScale(10.0 / 11 , 10.0/11);
        legLabel.transform                   = CGAffineTransformMakeScale(10.0 / 11 , 10.0/11);
        armLabel.transform                   = CGAffineTransformMakeScale(10.0 / 11 , 10.0/11);
        Sebum_triceps_Label.transform        = CGAffineTransformMakeScale(10.0 / 11 , 10.0/11);
        Sebum_Pelvis_Label.transform         = CGAffineTransformMakeScale(10.0 / 11 , 10.0/11);
        Sebum_Scapular_Label.transform       = CGAffineTransformMakeScale(10.0 / 11 , 10.0/11);
        Sebum_Stomach_Label.transform        = CGAffineTransformMakeScale(10.0 / 11 , 10.0/11);
        Sebum_Num_Label.transform            = CGAffineTransformMakeScale(10.0 / 11 , 10.0/11);
        Static_Heart_Label.transform         = CGAffineTransformMakeScale(10.0 / 11 , 10.0/11);
        Blood_Pressure_Label.transform       = CGAffineTransformMakeScale(10.0 / 11 , 10.0/11);
        Target_Heart_Label.transform         = CGAffineTransformMakeScale(10.0 / 11 , 10.0/11);
//        weight_Static_Label.transform = CGAffineTransformMakeScale(0.1 , 0.1);
//        fat_Static_Label.transform = CGAffineTransformIdentity;
//        BMI_Static_Label.transform = CGAffineTransformIdentity;
//        Percentage_Waist_Static_label.transform = CGAffineTransformIdentity;
        
        weight_Static_Label.alpha = 0;
        fat_Static_Label.alpha = 0;
        BMI_Static_Label.alpha = 0;
        Percentage_Waist_Static_label.alpha = 0;

    } completion:^(BOOL finished) {
        
    }];
    
    weightLabel.textColor = [UIColor grayColor];
    
    waisLabel.textColor = [UIColor grayColor];
    
    hipLabel.textColor = [UIColor grayColor];
    
    fatLabel.textColor = [UIColor grayColor];
    
    BMILabel.textColor = [UIColor grayColor];
    
    Percentage_Waist_Hip_Label.textColor = [UIColor grayColor];
    
    legLabel.textColor = [UIColor grayColor];
    
    armLabel.textColor = [UIColor grayColor];
    
    bustLabel.textColor = [UIColor grayColor];
    
    Sebum_triceps_Label.textColor = [UIColor grayColor];
    
    Sebum_Pelvis_Label.textColor = [UIColor grayColor];
    
    Sebum_Scapular_Label.textColor = [UIColor grayColor];
    
    Sebum_Stomach_Label.textColor = [UIColor grayColor];
    
    Sebum_Num_Label.textColor = [UIColor grayColor];
    
    Static_Heart_Label.textColor = [UIColor grayColor];
    
    Blood_Pressure_Label.textColor = [UIColor grayColor];
    
    Target_Heart_Label.textColor = [UIColor grayColor];
    
}

- (void)selectCell{

    UIFont * font = [UIFont systemFontOfSize:HEIGHT_6(18)];
    heightLabel.font = font;
    heightLabel.textColor = MAKA_JIN_COLOR;
    
//    weight_Static_Label.alpha = 1;
//    fat_Static_Label.alpha = 1;
//    BMI_Static_Label.alpha = 1;
//    Percentage_Waist_Static_label.alpha = 1;

    
    [UIView animateWithDuration:0.3 animations:^{
        heightLabel.transform      = CGAffineTransformMakeScale(1.1 , 1.1);
        weightLabel.transform     = CGAffineTransformMakeScale(1.1 , 1.1);
        waisLabel.transform     = CGAffineTransformMakeScale(1.1 , 1.1);
        hipLabel.transform     = CGAffineTransformMakeScale(1.1 , 1.1);
        fatLabel.transform     = CGAffineTransformMakeScale(1.1 , 1.1);
        BMILabel.transform     = CGAffineTransformMakeScale(1.1 , 1.1);
        Percentage_Waist_Hip_Label.transform     = CGAffineTransformMakeScale(1.25 , 1.1);
        legLabel.transform     = CGAffineTransformMakeScale(1.1 , 1.1);
        armLabel.transform     = CGAffineTransformMakeScale(1.1 , 1.1);
        Sebum_triceps_Label.transform     = CGAffineTransformMakeScale(1.1 , 1.1);
        Sebum_Pelvis_Label.transform     = CGAffineTransformMakeScale(1.1 , 1.1);
        Sebum_Scapular_Label.transform     = CGAffineTransformMakeScale(1.1 , 1.1);
        Sebum_Stomach_Label.transform     = CGAffineTransformMakeScale(1.1 , 1.1);
        Sebum_Num_Label.transform     = CGAffineTransformMakeScale(1.1 , 1.1);
        Static_Heart_Label.transform     = CGAffineTransformMakeScale(1.1 , 1.1);
        Blood_Pressure_Label.transform        = CGAffineTransformMakeScale(1.1 , 1.1);
        Target_Heart_Label.transform     = CGAffineTransformMakeScale(1.1 , 1.1);
        
        weight_Static_Label.alpha = 1;
        fat_Static_Label.alpha = 1;
        BMI_Static_Label.alpha = 1;
        Percentage_Waist_Static_label.alpha = 1;

    } completion:^(BOOL finished) {
        
    }];
    
    weightLabel.textColor = MAKA_JIN_COLOR;
    
    waisLabel.textColor = MAKA_JIN_COLOR;
    
    hipLabel.textColor = MAKA_JIN_COLOR;
    
    fatLabel.textColor = MAKA_JIN_COLOR;
    
    
    BMILabel.textColor = MAKA_JIN_COLOR;
    
    
    Percentage_Waist_Hip_Label.textColor = MAKA_JIN_COLOR;
    
    
    legLabel.textColor = MAKA_JIN_COLOR;
    
    armLabel.textColor = MAKA_JIN_COLOR;
    
    bustLabel.textColor = MAKA_JIN_COLOR;
    
    Sebum_triceps_Label.textColor = MAKA_JIN_COLOR;
    
    Sebum_Pelvis_Label.textColor = MAKA_JIN_COLOR;
    
    Sebum_Scapular_Label.textColor = MAKA_JIN_COLOR;
    
    Sebum_Stomach_Label.textColor = MAKA_JIN_COLOR;
    
    Sebum_Num_Label.textColor = MAKA_JIN_COLOR;
    
    Static_Heart_Label.textColor = MAKA_JIN_COLOR;
    
    Blood_Pressure_Label.textColor = MAKA_JIN_COLOR;
    
    Target_Heart_Label.textColor = MAKA_JIN_COLOR;

}

- (void)leftTap:(UITapGestureRecognizer *)tap{
    NSArray * arr = [NSArray arrayWithObjects:leftImageV.image,rightImageV.image, nil];
    [self tapWithImageArr:arr index:0];
}
- (void)rightTap:(UITapGestureRecognizer *)tap{
    NSArray * arr = [NSArray arrayWithObjects:leftImageV.image,rightImageV.image, nil];
    [self tapWithImageArr:arr index:1];
}
- (void)tapWithImageArr:(NSArray *)imageArr index:(NSInteger )index{
    if ([self.delegate respondsToSelector:@selector(presentDetailPhotoViewImageArr:index:)]) {
        [self.delegate presentDetailPhotoViewImageArr:imageArr index:index];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
