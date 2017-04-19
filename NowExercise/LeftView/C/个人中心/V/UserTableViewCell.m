//
//  UserTableViewCell.m
//  NowExercise
//
//  Created by mac on 17/3/21.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "UserTableViewCell.h"

@interface UserTableViewCell ()
{
    UIImageView * titleImageV;
    UILabel * titleLabel;
    
    UIImageView * detailImageV;
    UILabel * detailLabel;
    
    UIImageView * subTitleV;
}

@end

@implementation UserTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = COLOR(231, 212, 194);
        titleImageV = [[UIImageView alloc]init];
        titleLabel = [[UILabel alloc]init];
        detailImageV = [[UIImageView alloc]init];
        detailLabel = [[UILabel alloc]init];
        subTitleV = [[UIImageView alloc]init];
        
        titleImageV.layer.masksToBounds = YES;
        detailImageV.layer.masksToBounds = YES;
        
        titleLabel.font = [UIFont systemFontOfSize:HEIGHT_6(18)];
        detailLabel.font = [UIFont systemFontOfSize:HEIGHT_6(18)];
        
        titleLabel.backgroundColor = [UIColor redColor];
        detailImageV.backgroundColor = [UIColor redColor];
        subTitleV.backgroundColor = [UIColor redColor];
        
        [self addSubview:titleImageV];
        [self addSubview:titleLabel];
        [self addSubview:detailLabel];
        [self addSubview:detailImageV];
        [self addSubview:subTitleV];
        
    }
    return self;
}
- (void)createCellWithCellType:(CellImageViewType)CellType{
    //masonry布局
    [subTitleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset( - 10);
        make.width.and.height.mas_equalTo(HEIGHT_6(20));
        make.centerY.offset(0);
    }];

    //前面有图片的
    if (CellType == CellImageWithTitle) {
        [titleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.width.and.height.mas_equalTo(HEIGHT_6(25));
            make.centerY.offset(0);
        }];
        titleImageV.layer.cornerRadius = HEIGHT_6(25);
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleImageV.mas_right).offset(10);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(HEIGHT_6(25));
            make.centerY.offset(0);
        }];
        
    }else{
       //后面是头像
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(HEIGHT_6(25));
            make.centerY.offset(0);

        }];
        
        [detailImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(subTitleV.mas_left).offset(- 10);
            make.height.and.width.mas_equalTo(CGRectGetHeight(self.frame) - 20);
            make.centerY.offset(0);
            
        }];
        detailImageV.layer.cornerRadius = detailImageV.frame.size.height / 2.0f;
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
