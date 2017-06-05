//
//  BodyTableViewCell.m
//  NowExercise
//
//  Created by mac on 17/4/5.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "BodyTableViewCell.h"
#import "UILabel+Suger.h"
#import "UIImageView+Suger.h"
#import "DetailBodyView.h"

@interface BodyTableViewCell ()<detailBodyViewDelegate>
{
    //对比照
    UIImageView * photoImageV;
    UILabel * photoLabel;
    //上面分割线
    UILabel * topLineLabel;
    //分割线
    UILabel * bottomLineLabel;
    //照片下面的背景图
    UIView * bottomView;
    //身高
    UIImageView * heightImageV;
    UILabel * heightLabel;
    //体重
    UIImageView * weightImageV;
    UILabel * weightLabel;
    //腰围
    UIImageView * waistImageV;
    UILabel * waisLabel;
    //臀围
    UIImageView * hipImageV;
    UILabel * hipLabel;
    //脂肪百分比
    UIImageView * fatImageV;
    UILabel * fatLabel;
    //BMI
    UIImageView * BMIImageV;
    UILabel * BMILabel;
    //腰臀比例
    UIImageView * Percentage_Waist_Hip_ImageV;
    UILabel * Percentage_Waist_Hip_Label;
    //腿部
    UIImageView * legImageV;
    UILabel * legLabel;
    //详细腿部
    UILabel * DetailLegLabel;
    
    //臂部
    UIImageView * armImageV;
    UILabel * armLabel;
    //详细臂部
    UILabel * DetailArmLabel;
    
    //胸围
    UIImageView * bustImageV;
    UILabel * bustLabel;
    //详细腰围
    UILabel * DetailBustLabel;
    
    //肱三头肌皮脂
    UIImageView * Sebum_triceps_ImageV;
    UILabel * Sebum_triceps_Label;
    //髋嵴上缘皮脂
    UIImageView * Sebum_Pelvis_ImageV;
    UILabel * Sebum_Pelvis_Label;
    //肩胛下缘皮脂
    UIImageView * Sebum_Scapular_ImageV;
    UILabel * Sebum_Scapular_Label;
    //腹部皮脂
    UIImageView * Sebum_Stomach_ImageV;
    UILabel * Sebum_Stomach_Label;
    //大腿皮脂
    UIImageView * Sebum_Leg_ImageV;
    UILabel * Sebum_Leg_Label;
    //皮脂总和
    UIImageView * Sebum_Num_ImageV;
    UILabel * Sebum_Num_Label;
    //静态心率
    UIImageView * Static_Heart_ImageV;
    UILabel * Static_Heart_Label;
    //血压
    UIImageView * Blood_Pressure_ImageV;
    UILabel * Blood_Pressure_Label;
    //目标心率
    UIImageView * Target_Heart_ImageV;
    UILabel * Target_Heart_Label;
    
    DetailBodyView * collectionV;
    
}

@end

@implementation BodyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        [self initData];
    }
    return self;
}
- (void)createUI{
    
    self.backgroundColor = THEMECOLOR;
    
    photoLabel = [[UILabel alloc]initWithtitle:@"  照片"];
    [self addSubview:photoLabel];
    photoImageV = [[UIImageView alloc]initImageView];
    [self addSubview:photoImageV];
    
    topLineLabel = [[UILabel alloc]init];
    topLineLabel.backgroundColor = MAKA_JIN_COLOR;
    [self addSubview:topLineLabel];
    
    bottomLineLabel = [[UILabel alloc]init];
    bottomLineLabel.backgroundColor = MAKA_JIN_COLOR;
    [self addSubview:bottomLineLabel];
    
    bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = MAKA_JIN_COLOR;
    [self addSubview:bottomView];
    
    heightLabel = [[UILabel alloc]initWithtitle:@"  身高"];
    [bottomView addSubview:heightLabel];
    heightImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:heightImageV];
    
    weightLabel = [[UILabel alloc]initWithtitle:@"  体重"];
    [bottomView addSubview:weightLabel];
    weightImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:weightImageV];
    
    waisLabel = [[UILabel alloc]initWithtitle:@"  腰围"];
    [bottomView addSubview:waisLabel];
    waistImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:waistImageV];
    
    hipLabel = [[UILabel alloc]initWithtitle:@"  臀围"];
    [bottomView addSubview:hipLabel];
    hipImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:hipImageV];
    
    fatImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:fatImageV];
    fatLabel = [[UILabel alloc]initWithtitle:@"  脂肪百分比\n  (标准:12%-18%)"];
    [bottomView addSubview:fatLabel];
    
    BMILabel = [[UILabel alloc]initWithtitle:@"  BMI\n  (标准:18.5-22.9)"];
    [bottomView addSubview:BMILabel];
    BMIImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:BMIImageV];
    
    Percentage_Waist_Hip_Label = [[UILabel alloc]initWithtitle:@"  腰臀比例\n  (标准:18.5-22.9)"];
    [bottomView addSubview:Percentage_Waist_Hip_Label];
    Percentage_Waist_Hip_ImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:Percentage_Waist_Hip_ImageV];
    
    //行间距
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    
    legLabel = [[UILabel alloc]initWithtitle:@"  腿部"];
    [bottomView addSubview:legLabel];
    legImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:legImageV];
    DetailLegLabel = [[UILabel alloc]init];
    DetailLegLabel.backgroundColor = THEMECOLOR;
    DetailLegLabel.text = @"左大腿\n右大腿\n左小腿\n右小腿";
    DetailLegLabel.textColor = MAKA_JIN_COLOR;
    [UILabel changeLineSpaceForLabel:DetailLegLabel WithSpace:12];
    DetailLegLabel.font = [UIFont systemFontOfSize:HEIGHT_6(12)];
    DetailLegLabel.numberOfLines = 0;
    [bottomView addSubview:DetailLegLabel];
    
    armLabel = [[UILabel alloc]initWithtitle:@"  臂部"];
    [bottomView addSubview:armLabel];
    armImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:armImageV];
    DetailArmLabel = [[UILabel alloc]init];
    DetailArmLabel.text = @"左上臂(放松)\n左上臂(屈曲)\n右上臂(放松)\n右上臂(屈曲)";
    [UILabel changeLineSpaceForLabel:DetailArmLabel WithSpace:12];
    DetailArmLabel.font = [UIFont systemFontOfSize:HEIGHT_6(12)];
    DetailArmLabel.numberOfLines = 0;
    DetailArmLabel.backgroundColor = THEMECOLOR;
    DetailArmLabel.textColor = MAKA_JIN_COLOR;
    [bottomView addSubview:DetailArmLabel];
    
    bustLabel = [[UILabel alloc]initWithtitle:@"  腰围"];
    [bottomView addSubview:bustLabel];
    bustImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:bustImageV];
    DetailBustLabel = [[UILabel alloc]init];
    DetailBustLabel.text = @"胸围(放松)\n胸围(扩张)";
    [UILabel changeLineSpaceForLabel:DetailBustLabel WithSpace:12];
    DetailBustLabel.font = [UIFont systemFontOfSize:HEIGHT_6(12)];
    DetailBustLabel.numberOfLines = 0;
    DetailBustLabel.textColor = MAKA_JIN_COLOR;
    DetailBustLabel.backgroundColor = THEMECOLOR;
    [bottomView addSubview:DetailBustLabel];
    
    Sebum_triceps_Label = [[UILabel alloc]initWithtitle:@"  肱三头肌皮脂"];
    [bottomView addSubview:Sebum_triceps_Label];
    Sebum_triceps_ImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:Sebum_triceps_ImageV];
    
    Sebum_Pelvis_Label = [[UILabel alloc]initWithtitle:@"  髋嵴下缘皮脂"];
    [bottomView addSubview:Sebum_Pelvis_Label];
    Sebum_Pelvis_ImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:Sebum_Pelvis_ImageV];
    
    Sebum_Scapular_Label = [[UILabel alloc]initWithtitle:@"  肩胛下缘皮脂"];
    [bottomView addSubview:Sebum_Scapular_Label];
    Sebum_Scapular_ImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:Sebum_Scapular_ImageV];
    
    Sebum_Stomach_Label = [[UILabel alloc]initWithtitle:@"  腹部皮脂"];
    [bottomView addSubview:Sebum_Stomach_Label];
    Sebum_Stomach_ImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:Sebum_Stomach_ImageV];
    
    Sebum_Leg_Label = [[UILabel alloc]initWithtitle:@"  大腿皮脂"];
    [bottomView addSubview:Sebum_Leg_Label];
    Sebum_Leg_ImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:Sebum_Leg_ImageV];
    
    Sebum_Num_Label = [[UILabel alloc]initWithtitle:@"  皮脂总和"];
    [bottomView addSubview:Sebum_Num_Label];
    Sebum_Num_ImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:Sebum_Num_ImageV];
    
    Static_Heart_Label = [[UILabel alloc]initWithtitle:@"  静态心率\n  (标准:60-70)"];
    [bottomView addSubview:Static_Heart_Label];
    Static_Heart_ImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:Static_Heart_ImageV];
    
    Blood_Pressure_Label = [[UILabel alloc]initWithtitle:@"  血压\n  (标准:80-120)"];
    [bottomView addSubview:Blood_Pressure_Label];
    Blood_Pressure_ImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:Blood_Pressure_ImageV];
    
    Target_Heart_Label = [[UILabel alloc]initWithtitle:@"  目标心率"];
    [bottomView addSubview:Target_Heart_Label];
    Target_Heart_ImageV = [[UIImageView alloc]initImageView];
    [bottomView addSubview:Target_Heart_ImageV];
    Target_Heart_ImageV.backgroundColor = THEMECOLOR;
    
    collectionV = [[DetailBodyView alloc]init];
//    collectionV.backgroundColor = [UIColor purpleColor];
    collectionV.delegate = self;
    [self addSubview:collectionV];
    
}
- (void)initData{
    photoImageV.image = [UIImage imageNamed:@"照片.png"];
    heightImageV.image = [UIImage imageNamed:@"身高.png"];
    weightImageV.image = [UIImage imageNamed:@"体重.png"];
    waistImageV.image = [UIImage imageNamed:@"腰围.png"];
    hipImageV.image = [UIImage imageNamed:@"臀围.png"];
    fatImageV.image = [UIImage imageNamed:@"脂肪百分比.png"];
    BMIImageV.image = [UIImage imageNamed:@"BMI.png"];
    Percentage_Waist_Hip_ImageV.image = [UIImage imageNamed:@"腰臀比例.png"];
    legImageV.image = [UIImage imageNamed:@"腿部.png"];
    armImageV.image = [UIImage imageNamed:@"臂部.png"];
    bustImageV.image = [UIImage imageNamed:@"胸围.png"];
    Sebum_triceps_ImageV.image = [UIImage imageNamed:@"肱三头肌皮脂.png"];
    Sebum_Pelvis_ImageV.image = [UIImage imageNamed:@"髋嵴上缘皮脂.png"];
    Sebum_Scapular_ImageV.image = [UIImage imageNamed:@"肩胛下缘皮脂.png"];
    Sebum_Stomach_ImageV.image = [UIImage imageNamed:@"腹部皮脂.png"];
    Sebum_Leg_ImageV.image = [UIImage imageNamed:@"大腿皮脂.png"];
    Sebum_Num_ImageV.image = [UIImage imageNamed:@"皮脂总和.png"];
    Static_Heart_ImageV.image = [UIImage imageNamed:@"静态心率.png"];
    Blood_Pressure_ImageV.image = [UIImage imageNamed:@"血压.png"];
    Target_Heart_ImageV.image = [UIImage imageNamed:@"目标心率.png"];
    
}
- (void)layoutSubviews{
    CGFloat title_H = HEIGHT_6(45);
    CGFloat imageV_W = WIDTH_6(23);
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomLineLabel.mas_bottom);
        make.left.offset(10);
        make.right.offset(-10);
        make.bottom.offset(0);
    }];
    //                                                                   1
    [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(10);
        make.height.mas_equalTo(1);
    }];
    //                                                                   160(H)
    [photoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.mas_equalTo(topLineLabel.mas_bottom);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(HEIGHT_6(160));
    }];
    [photoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(photoImageV.mas_right);
        make.top.mas_equalTo(topLineLabel.mas_bottom);
        make.width.mas_equalTo(WIDTH_6(50));
        make.height.mas_equalTo(photoImageV.mas_height);
        
    }];
    
    //                                                                   1
    [bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(photoImageV.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    //                                                                   title_H(40)
    [heightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(title_H);
    }];
    [heightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(heightImageV.mas_right);
        make.right.top.offset(0);
        make.height.mas_equalTo(title_H);
    }];
    //                                                                  title_H(40)+1
    [weightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(heightImageV.mas_bottom).offset(1);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(title_H);
    }];
    
    [weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weightImageV.mas_right);
        make.right.offset(0);
        make.top.mas_equalTo(heightImageV.mas_bottom).offset(1);
        make.height.mas_equalTo(title_H);
    }];
    
    //                                                                     title_H(40)+1
    [waistImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(weightImageV.mas_bottom).offset(1);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(title_H);
    }];
    [waisLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(waistImageV.mas_right);
        make.top.mas_equalTo(weightLabel.mas_bottom).offset(1);
        make.right.offset(0);
        make.height.mas_equalTo(title_H);
    }];
    
    //                                                                      title_H(40)+1
    [hipImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.mas_equalTo(imageV_W);
        make.top.mas_equalTo(waistImageV.mas_bottom).offset(1);
        make.height.mas_equalTo(title_H);
    }];
    [hipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hipImageV.mas_right);
        make.top.mas_equalTo(waisLabel.mas_bottom).offset(1);
        make.right.offset(0);
        make.height.mas_equalTo(title_H);
    }];
    //                                                                       title_H + 1
    [fatImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(hipLabel.mas_bottom).offset(1);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(title_H);
    }];
    [fatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(fatImageV.mas_right);
        make.top.mas_equalTo(hipLabel.mas_bottom).offset(1);
        make.right.offset(0);
        make.height.mas_equalTo(title_H);
    }];
    
    //                                                                       title_H + 1
    [BMIImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(fatImageV.mas_bottom).offset(1);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(title_H);
    }];
    [BMILabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(fatLabel.mas_bottom).offset(1);
        make.right.offset(0);
        make.left.mas_equalTo(BMIImageV.mas_right);
        make.height.mas_equalTo(title_H);
    }];
    
    //                                                                       title_H + 1
    [Percentage_Waist_Hip_ImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(BMIImageV.mas_bottom).offset(1);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(title_H);
    }];
    [Percentage_Waist_Hip_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(BMILabel.mas_bottom).offset(1);
        make.left.mas_equalTo(Percentage_Waist_Hip_ImageV.mas_right);
        make.right.offset(0);
        make.height.mas_equalTo(title_H);
    }];
    
    //                                                                      title_H * 3 + 1
    [legImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(Percentage_Waist_Hip_ImageV.mas_bottom).offset(1);
        make.height.mas_equalTo(title_H * 3);
        make.width.mas_equalTo(imageV_W);
    }];
    [legLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Percentage_Waist_Hip_Label.mas_bottom).offset(1);
        make.left.mas_equalTo(legImageV.mas_right);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(title_H * 3);
    }];
    
    [DetailLegLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.top.mas_equalTo(Percentage_Waist_Hip_Label.mas_bottom).offset(1);
        make.left.mas_equalTo(legLabel.mas_right);
        make.height.mas_equalTo(title_H * 3);
    }];
    
    //                                                                      title_H * 3 + 1
    [armImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(legImageV.mas_bottom).offset(1);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(title_H * 3);
    }];
    [armLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(armImageV.mas_right);
        make.top.mas_equalTo(legLabel.mas_bottom).offset(1);
        make.height.mas_equalTo(title_H * 3);
        make.width.mas_equalTo(40);
    }];
    [DetailArmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(armLabel.mas_right);
        make.top.mas_equalTo(DetailLegLabel.mas_bottom).offset(1);
        make.height.mas_equalTo(title_H * 3);
        make.right.offset(0);
    }];
    
    //                                                                      title_H * 2 + 1
    [bustImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(armImageV.mas_bottom).offset(1);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(title_H * 2);
    }];
    [bustLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bustImageV.mas_right);
        make.top.mas_equalTo(armLabel.mas_bottom).offset(1);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(title_H * 2);
    }];
    [DetailBustLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bustLabel.mas_right);
        make.right.offset(0);
        make.top.mas_equalTo(DetailArmLabel.mas_bottom).offset(1);
        make.height.mas_equalTo(title_H * 2);
    }];
    
    //                                                                      title_H + 1
    [Sebum_triceps_ImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(bustImageV.mas_bottom).offset(1);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(title_H);
    }];
    [Sebum_triceps_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bustLabel.mas_bottom).offset(1);
        make.left.mas_equalTo(Sebum_triceps_ImageV.mas_right);
        make.right.offset(0);
        make.height.mas_equalTo(title_H);
    }];
    
    //                                                                      title_H + 1
    [Sebum_Pelvis_ImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(Sebum_triceps_ImageV.mas_bottom).offset(1);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(title_H);
    }];
    [Sebum_Pelvis_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Sebum_Pelvis_ImageV.mas_right);
        make.top.mas_equalTo(Sebum_triceps_Label.mas_bottom).offset(1);
        make.right.offset(0);
        make.height.mas_equalTo(title_H);
    }];
    
    //                                                                      title_H + 1
    [Sebum_Scapular_ImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(Sebum_Pelvis_ImageV.mas_bottom).offset(1);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(title_H);
    }];
    [Sebum_Scapular_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Sebum_Scapular_ImageV.mas_right);
        make.right.offset(0);
        make.top.mas_equalTo(Sebum_Pelvis_Label.mas_bottom).offset(1);
        make.height.mas_equalTo(title_H);
    }];
    
    //                                                                      title_H + 1
    [Sebum_Stomach_ImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(Sebum_Scapular_ImageV.mas_bottom).offset(1);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(title_H);
    }];
    [Sebum_Stomach_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Sebum_Stomach_ImageV.mas_right);
        make.top.mas_equalTo(Sebum_Scapular_Label.mas_bottom).offset(1);
        make.right.offset(0);
        make.height.mas_equalTo(title_H);
    }];
    
    //                                                                       title_H + 1
    [Sebum_Leg_ImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(Sebum_Stomach_ImageV.mas_bottom).offset(1);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(title_H);
    }];
    [Sebum_Leg_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Sebum_Leg_ImageV.mas_right);
        make.right.offset(0);
        make.top.mas_equalTo(Sebum_Stomach_Label.mas_bottom).offset(1);
        make.height.mas_equalTo(title_H);
    }];
    
    //                                                                        title_H + 1
    [Sebum_Num_ImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(Sebum_Leg_ImageV.mas_bottom).offset(1);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(title_H);
    }];
    [Sebum_Num_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Sebum_Num_ImageV.mas_right);
        make.top.mas_equalTo(Sebum_Leg_Label.mas_bottom).offset(1);
        make.right.offset(0);
        make.height.mas_equalTo(title_H);
    }];
    //                                                                      title_H + 1
    [Static_Heart_ImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(Sebum_Num_ImageV.mas_bottom).offset(1);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(title_H);
    }];
    [Static_Heart_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Static_Heart_ImageV.mas_right);
        make.top.mas_equalTo(Sebum_Num_Label.mas_bottom).offset(1);
        make.right.offset(0);
        make.height.mas_equalTo(title_H);
    }];

    //                                                                      title_H + 1
    [Blood_Pressure_ImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(title_H);
        make.top.mas_equalTo(Static_Heart_ImageV.mas_bottom).offset(1);
    }];
    [Blood_Pressure_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Blood_Pressure_ImageV.mas_right);
        make.top.mas_equalTo(Static_Heart_Label.mas_bottom).offset(1);
        make.right.offset(0);
        make.height.mas_equalTo(title_H);
    }];
    
    //                                                                      title_H + 1
    [Target_Heart_ImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(Blood_Pressure_ImageV.mas_bottom).offset(1);
        make.width.mas_equalTo(imageV_W);
        make.height.mas_equalTo(title_H);
    }];
    [Target_Heart_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Target_Heart_ImageV.mas_right);
        make.right.offset(0);
        make.height.mas_equalTo(title_H);
        make.top.mas_equalTo(Blood_Pressure_Label.mas_bottom).offset(1);
    }];
    
    [collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.bottom.offset(0);
        make.width.mas_equalTo(SCREEN_W / 5 * 3);
    }];
    
}
- (void)showImageScrollerViewArr:(NSArray *)arr index:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(ShowImageScrollerViewWithImageArr:index:)]) {
        [self.delegate ShowImageScrollerViewWithImageArr:arr index:index];
    }
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
