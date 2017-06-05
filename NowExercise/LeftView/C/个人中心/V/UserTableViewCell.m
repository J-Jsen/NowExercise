//
//  UserTableViewCell.m
//  NowExercise
//
//  Created by mac on 17/3/21.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "UserTableViewCell.h"

@interface UserTableViewCell ()<UITextFieldDelegate>
{
    UITextField * detailTF;
    
    UILabel * statusLabel;

    CellImageViewType type;
}
@end

@implementation UserTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = COLOR(231, 212, 194);
        _titleLabel = [[UILabel alloc]init];
        _detailImageV = [[UIImageView alloc]init];
        detailTF = [[UITextField alloc]init];
        statusLabel = [[UILabel alloc]init];

        detailTF.textAlignment = NSTextAlignmentRight;
        _detailImageV.layer.masksToBounds = YES;
        _detailImageV.layer.cornerRadius = HEIGHT_6(25);
        _titleLabel.font = [UIFont systemFontOfSize:HEIGHT_6(18)];
        statusLabel.font = [UIFont systemFontOfSize:HEIGHT_6(13)];
        statusLabel.hidden = YES;
        statusLabel.textColor = [UIColor blackColor];
        detailTF.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
        detailTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        detailTF.returnKeyType = UIReturnKeyDone;
        detailTF.textColor = [UIColor grayColor];
        detailTF.delegate = self;
//        titleLabel.backgroundColor = [UIColor redColor];
//        detailImageV.backgroundColor = [UIColor redColor];
        
        [self addSubview:statusLabel];
        [self addSubview:detailTF];
        [self addSubview:_titleLabel];
        [self addSubview:_detailImageV];
        
    }
    return self;
}
- (void)creatCellWithTitle:(NSString *)title{
    _titleLabel.text = title;
}
- (void)createCellWithCellType:(CellImageViewType)CellType{
    type = CellType;
    //masonry布局
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.offset(0);
        make.height.mas_equalTo(HEIGHT_6(45));
        make.width.mas_equalTo(100);
    }];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(60);
        make.centerY.offset(0);
        make.width.mas_equalTo(50);
        make.height.offset(HEIGHT_6(45));
    }];
    //后面是图还是文字
    if (CellType == CellImage) {
        //图片
        [_detailImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-20);
            make.centerY.offset(0);
            make.width.height.mas_equalTo(HEIGHT_6(50));
        }];
    }else if(CellType == CellTitle){
        //文字
       [detailTF mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.offset(-20);
           make.centerY.offset(0);
           make.width.mas_equalTo(150);
           make.height.mas_equalTo(HEIGHT_6(45));
       }];
    }
}
- (void)hide{
    statusLabel.hidden = NO;
}
- (void)createCellWithStr:(NSString *)str{
    if (type == CellImage) {
        [_detailImageV sd_setImageWithURL:[NSURL URLWithString:str]];
    }else if(type == CellTitle){
        detailTF.text = str;
    }
    if (_index == 7) {
        [self hide];
        float BMI = [str floatValue];
        if (BMI < 18.50) {
            statusLabel.textColor = UIColorFromRGB(0xe74c3c);
            statusLabel.text      = @"偏低";
        } else if (BMI > 22.90) {
            statusLabel.textColor = UIColorFromRGB(0xe74c3c);
            statusLabel.text      = @"偏高";
        } else {
            statusLabel.textColor = [UIColor colorWithRed:0 green:206/255.0 blue:185/255.0 alpha:1];
            statusLabel.text      = @"正常";
        }
    }
}
- (void)createCellImage:(UIImage *)image{
    _detailImageV.image = image;
}
- (void)CellTFCanUse{
    detailTF.userInteractionEnabled = NO;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"体重身高");
    if ([textField.text integerValue] <=0) {
        [HttpRequest showAlertWithTitle:@"请正确填写"];
        [textField becomeFirstResponder];
    }else{
        if ([self.delegate respondsToSelector:@selector(detailTitle:andindex:)]) {
            [self.delegate detailTitle:textField.text andindex:_index];
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [detailTF resignFirstResponder];
    return YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
