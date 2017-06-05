//
//  SettingCell.m
//  NowExercise
//
//  Created by 朱学森 on 2017/5/10.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "SettingCell.h"

@interface SettingCell()
{
    UIImageView * imageV;
}

@end

@implementation SettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        imageV = [[UIImageView alloc]init];
        imageV.contentMode = UIViewContentModeLeft;
        [self addSubview:imageV];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(10);
            make.centerY.offset(0);
            make.width.height.mas_equalTo(HEIGHT_6(40));
        }];
    }
    return self;
}
- (void)createCellImageStr:(NSString *)str{
    imageV.image = [UIImage imageNamed:str];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
