//
//  LeftCell_1.m
//  NowExercise
//
//  Created by mac on 17/1/21.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "LeftCell_1.h"

@interface LeftCell_1()
{
    UIImageView * titleImageV;
    UILabel * titleLabel;
    
}

@end
@implementation LeftCell_1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = THEMECOLOR;
        titleImageV = [[UIImageView alloc]init];
        titleImageV.contentMode = UIViewContentModeCenter;
        titleLabel = [[UILabel alloc]init];
        titleLabel.font = FONT(@"", 17);
        titleLabel.textColor = [UIColor whiteColor];

        //titleImageV.backgroundColor = [UIColor grayColor];
        [self addSubview:titleLabel];
        [self addSubview:titleImageV];
        
        
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
        make.left.mas_equalTo(titleImageV.mas_right).offset(WIDTH_6(10.0));
        make.width.mas_equalTo(WIDTH_6(100));
        make.height.mas_equalTo(self.frame.size.height - 10);
    }];
    
}
- (void)crateCellWithImageName:(NSString *)imageName andtitleName:(NSString *)titleName{
    
    titleImageV.image = [UIImage imageNamed:imageName];
    titleLabel.text = titleName;
    
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
