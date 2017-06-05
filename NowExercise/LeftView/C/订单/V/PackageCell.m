//
//  PackageCell.m
//  NowExercise
//
//  Created by Suger on 17/5/4.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "PackageCell.h"

@interface PackageCell()
{
    UILabel * package_name;
    UILabel * pay_status;
    UILabel * pay_amount;
    UILabel * package_content;
    UILabel * line;
    UILabel * numlabel;
}

@end

@implementation PackageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = THEMECOLOR;
        package_name    = [[UILabel alloc]init];
        pay_status      = [[UILabel alloc]init];
        pay_amount      = [[UILabel alloc]init];
        package_content = [[UILabel alloc]init];
        line            = [[UILabel alloc]init];
        numlabel        = [[UILabel alloc]init];
        
        pay_status.textAlignment = NSTextAlignmentRight;
        pay_amount.textAlignment = NSTextAlignmentRight;
        numlabel.textAlignment = NSTextAlignmentRight;
        package_name.textAlignment = NSTextAlignmentLeft;
        package_content.textAlignment = NSTextAlignmentLeft;
        
        package_name.font = [UIFont systemFontOfSize:HEIGHT_6(16)];
        pay_status.font = [UIFont systemFontOfSize:HEIGHT_6(14)];
        pay_amount.font = [UIFont systemFontOfSize:HEIGHT_6(15)];
        package_content.font = [UIFont systemFontOfSize:HEIGHT_6(15)];
        numlabel.font = [UIFont systemFontOfSize:HEIGHT_6(16)];
        
        UIView * backgroundView = [[UIView alloc]init];
        backgroundView.backgroundColor = MAKA_JIN_COLOR;
        [self addSubview:backgroundView];

        line.backgroundColor = COLOR(108, 105, 104);
        
        [backgroundView addSubview:package_name];
        [backgroundView addSubview:pay_status];
        [backgroundView addSubview:pay_amount];
        [backgroundView addSubview:package_content];
        [backgroundView addSubview:line];
        [backgroundView addSubview:numlabel];
        
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.and.right.offset(0);
            make.bottom.offset(-10);
        }];

        [package_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(20);
            make.left.offset(10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(HEIGHT_6(17));
        }];
        [pay_status mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            make.top.offset(20);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(15);
        }];
        [package_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.mas_equalTo(package_name.mas_bottom).offset(10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(HEIGHT_6(16));
        }];
        [pay_amount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            make.top.mas_equalTo(pay_status.mas_bottom).offset(10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(HEIGHT_6(16));
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(package_content.mas_bottom).offset(10);
        }];
        [numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            make.top.mas_equalTo(line.mas_bottom).offset(10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(HEIGHT_6(24));
        }];
        
    }
    return self;
}
- (void)createCellWithModel:(OrderModel *)model{
    package_name.text = model.package_name;
    pay_status.text = model.pay_status;
    pay_amount.text = [NSString stringWithFormat:@"¥%ld",(long)model.pay_amount];
    package_content.text = model.package_content;
    numlabel.text = [NSString stringWithFormat:@"合计: ¥%ld",(long)model.pay_amount];
    
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
