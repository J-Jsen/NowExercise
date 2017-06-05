//
//  questionCell.m
//  NowExercise
//
//  Created by Suger on 17/6/1.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "questionCell.h"

@interface questionCell()
{
    UIImageView * imageV;
}

@end

@implementation questionCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = MAKA_JIN_COLOR;
        self.textLabel.textColor = [UIColor blackColor];
        imageV = [[UIImageView alloc]init];
        [self addSubview:imageV];
        imageV.backgroundColor = [UIColor redColor];
        imageV.image = [UIImage imageNamed:@"未选中问题.png"];
        imageV.contentMode = UIViewContentModeRight;
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            make.centerY.offset(0);
            make.width.height.mas_equalTo(20);
        }];
    }
    return self;
}
- (void)imageViewHide{
    imageV.hidden = YES;
}
- (void)select{
    imageV.image = [UIImage imageNamed:@"选中问题.png"];
}
- (void)disselect{
    imageV.image = [UIImage imageNamed:@"未选中问题.png"];
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
