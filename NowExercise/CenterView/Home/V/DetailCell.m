//
//  DetailCell.m
//  NowExercise
//
//  Created by mac on 17/2/15.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "DetailCell.h"

@interface DetailCell()
{
    BOOL isheight;
}

@end

@implementation DetailCell


- (void)createCellWith:(NSString *)detailStr title:(NSString *)title{
    _ClassShowLabel.text = detailStr;
    CGSize  size = [HttpRequest sizeWithText:detailStr font:[UIFont systemFontOfSize:HEIGHT_6(17)] maxWidth:SCREEN_W - 30];
    __weak typeof(self) weakSelf = self;

    if (!isheight) {
        self.Cell_H += size.height + HEIGHT_6(250);
        isheight = YES;
    }
    [_ClassShowLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.ClassLabel.mas_bottom).offset(5);
        make.left.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(size.height);
    }];
    
    [_MatterLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.ClassLabel.mas_bottom).offset(size.height + 10);
    }];
    _DetailLabel.text = title;
    if ([title isEqualToString:@"套餐介绍"]) {
        self.ClassLabel.text = @"";
    }else{
        self.ClassLabel.text = @"课程介绍";
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = THEMECOLOR;
    UIFont * font17 = [UIFont systemFontOfSize:HEIGHT_6(16)];
    UIFont * font19 = [UIFont systemFontOfSize:HEIGHT_6(18)];
    self.ClassLabel.font = font19;
    self.ClassShowLabel.font = font17;
    self.MatterLabel.font = font19;
    self.MatterShowLabel.font = font17;
    self.NowExerciseInformLabel.font = font19;
    self.NowExerciseLabel.font = font17;

    self.MatterShowLabel.text = @"1.穿舒适运动服\n2.课前一小时禁食\n3.经期前三天不宜运动\n4.有伤病史者请提前告知教练\n";
    self.NowExerciseLabel.text = @"约课时间: 09: 00-20: 00\n健身所需器材,由教练提供\n健身所需空间,一张瑜伽垫大小即可\n北京地区仅限五环内订课\n上海地区仅限外环内订课\n更多地区将陆续开通,敬请期待\n";
    CGSize matterShowL = [HttpRequest sizeWithText:self.MatterShowLabel.text font:[UIFont systemFontOfSize:HEIGHT_6(17)] maxWidth:SCREEN_W - 30];
    
    CGSize nowExerciseL = [HttpRequest sizeWithText:self.NowExerciseLabel.text font:[UIFont systemFontOfSize:HEIGHT_6(17)] maxWidth:SCREEN_W - 30];
    self.Cell_H = matterShowL.height + nowExerciseL.height;
    NSLog(@"默认长度:%f",_Cell_H);
     __weak typeof(self) weakSelf = self;
    
    [_MatterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.mas_equalTo(weakSelf.ClassLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(HEIGHT_6(20));
    }];
    
    [self.MatterShowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.mas_equalTo(weakSelf.MatterLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(matterShowL.height);
    }];
    [self.NowExerciseInformLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.mas_equalTo(weakSelf.MatterShowLabel.mas_bottom);
        make.height.mas_equalTo(HEIGHT_6(20));
    }];
    [self.NowExerciseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.mas_equalTo(weakSelf.NowExerciseInformLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(nowExerciseL.height);
    }];
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
