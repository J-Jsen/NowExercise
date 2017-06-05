//
//  SellCell.m
//  NowExercise
//
//  Created by mac on 17/3/30.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "SellCell.h"

@interface SellCell ()
{
    UILabel * packageLabel;
    UILabel * valueLabel;
    UILabel * classTimersLabel;
    UIButton * payBtn;
    UIView * backGroundView;
    
}

@end

@implementation SellCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = THEMECOLOR;
        backGroundView = [[UIView alloc]init];
        backGroundView.backgroundColor = MAKA_JIN_COLOR;
        [self addSubview:backGroundView];
        
        packageLabel = [[UILabel alloc]init];
        packageLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(19)];
        [backGroundView addSubview:packageLabel];
        
        
        valueLabel = [[UILabel alloc]init];
        valueLabel.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
        valueLabel.textColor = [UIColor blackColor];
        [backGroundView addSubview:valueLabel];
        
        classTimersLabel = [[UILabel alloc]init];
        classTimersLabel.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
        [backGroundView addSubview:classTimersLabel];
        
        payBtn = [[UIButton alloc]init];
        [payBtn setTitle:@"立即订购" forState:UIControlStateNormal];
        payBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        payBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT_6(13)];
        payBtn.layer.cornerRadius = HEIGHT_6(13);
        payBtn.layer.borderColor = [UIColor blackColor].CGColor;
        payBtn.layer.borderWidth = 0.5;
        [payBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        payBtn.userInteractionEnabled = NO;
        [backGroundView addSubview:payBtn];
        
        [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.offset(0);
            make.bottom.offset(-20);
        }];
        
        packageLabel.text = @"特享套餐";
        valueLabel.text = @"充值5000元";
        packageLabel.textColor = [UIColor blackColor];
        classTimersLabel.text = @"含17节课";
        
        
        [self layoutBackGroundViewSubviews];
        
    }
    return self;
}

- (void)createCellWithModel:(Sellmodel *)model{
    packageLabel.text = model.name;
    valueLabel.text = [NSString stringWithFormat:@"充值%ld元",(long)model.price];
    classTimersLabel.text = [NSString stringWithFormat:@"含%ld节课",(long)model.number];
    
}

- (void)layoutBackGroundViewSubviews{
    
    [packageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(0);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(backGroundView.mas_height).multipliedBy(1 / 2.0f);
        
    }];
    
    [valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.bottom.offset(0);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(backGroundView.mas_height).multipliedBy(1 / 2.0f);
    }];
    
    [classTimersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(HEIGHT_6(20));
    }];
    
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.offset(0);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(HEIGHT_6(26));
    }];
    
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
