//
//  PayCell.m
//  NowExercise
//
//  Created by mac on 17/3/28.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "PayCell.h"

@interface PayCell()
{
    UIImageView * imageV;
    UIImageView * selectImageV;
    
}


@end

@implementation PayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        imageV = [[UIImageView alloc]init];
        [self addSubview:imageV];
//        imageV.backgroundColor = [UIColor redColor];
        selectImageV = [[UIImageView alloc]init];
        [self addSubview:selectImageV];
        selectImageV.layer.cornerRadius = 10;
        selectImageV.layer.masksToBounds = YES;
        selectImageV.layer.borderColor = MAKA_JIN_COLOR.CGColor;
        selectImageV.layer.borderWidth = 1;
        selectImageV.backgroundColor = THEMECOLOR;
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(HEIGHT_6(30));
            make.left.offset(10);
            make.centerY.offset(0);
        }];
        
        [selectImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(HEIGHT_6(20));
            make.right.offset(-20);
            make.centerY.offset(0);
            
        }];
        self.backgroundColor = COLOR(91, 91, 91);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)createCellWithTitleImage:(UIImage *)image{
    imageV.image = image;
    selectImageV.image = [UIImage imageNamed:@""];
}

- (void)selectCell{
    selectImageV.image = [UIImage imageNamed:@""];
    selectImageV.backgroundColor = MAKA_JIN_COLOR;
}

- (void)disselectCell{
    selectImageV.backgroundColor = THEMECOLOR;
    selectImageV.image = [UIImage imageNamed:@""];
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
