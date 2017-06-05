//
//  LeftCell_2.m
//  NowExercise
//
//  Created by mac on 17/1/21.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "LeftCell_2.h"

@interface LeftCell_2()
{
    UIImageView * titleImageV;
    UILabel * titleLabel;
    UILabel * numberLabel;
    
}

@end
@implementation LeftCell_2
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = THEMECOLOR;
        titleImageV = [[UIImageView alloc]init];
        titleLabel = [[UILabel alloc]init];
        numberLabel = [[UILabel alloc]init];
        
        titleLabel.font = FONT(@"", 17);
        numberLabel.font = FONT(@"", 17);
        titleLabel.textColor = [UIColor whiteColor];
        numberLabel.textColor = [UIColor whiteColor];
        //titleImageV.backgroundColor = [UIColor grayColor];
        titleImageV.contentMode = UIViewContentModeCenter;
        [self addSubview:titleLabel];
        [self addSubview:titleImageV];
        [self addSubview:numberLabel];
        
    }
    return self;
}
//布局
- (void)layoutSubviews{
    [super layoutSubviews];
    [titleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(WIDTH_6(10));
        make.width.mas_equalTo(HEIGHT_6(21));
        make.height.mas_equalTo(HEIGHT_6(21));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.mas_equalTo(titleImageV.mas_right).offset(10);
        make.width.mas_equalTo(WIDTH_6(50));
        make.height.mas_equalTo(self.frame.size.height - 10);
    }];
    
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.mas_equalTo(titleLabel.mas_right).offset(WIDTH_6(10));
        make.height.mas_equalTo(self.frame.size.height - 10);
        make.width.mas_equalTo(35);
    }];
}
- (void)crateCellWithImageName:(NSString *)imageName andtitleName:(NSString *)titleName{
    
    titleImageV.image = [UIImage imageNamed:imageName];
    titleLabel.text = titleName;
    
}
- (void)packagenumber:(NSString *)number{
    numberLabel.text = number;
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
