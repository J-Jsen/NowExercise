//
//  OrderCell.m
//  NowExercise
//
//  Created by mac on 17/3/29.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "OrderCell.h"
#import "NSString+Suger.h"
@interface OrderCell ()
{
    UILabel * timeLabel;
    UILabel * dateLabel;
    UILabel * classLabel;
    UILabel * VIPnameLabel;
    UILabel * telLabel;
    UILabel * placeLabel;
    UILabel * statusLabel;
    UIImageView * coachImageV;
    UILabel * coachLabel;
    UILabel * line;
    UIButton * deleteOrderBtn;
    UIImageView * detailImageV;
    UIButton * evaluateBtn;
}

@end

@implementation OrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = NAV_COLOR;
        
        UIView * backgroundView = [[UIView alloc]init];
        backgroundView.backgroundColor = MAKA_JIN_COLOR;
        [self addSubview:backgroundView];
        
        UIColor * Order_LABEL_COLOR = COLOR(108, 105, 104);
        
        timeLabel = [[UILabel alloc]init];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.font = [UIFont systemFontOfSize:HEIGHT_6(16)];
        [backgroundView addSubview:timeLabel];
        
        dateLabel = [[UILabel alloc]init];
        dateLabel.textAlignment = NSTextAlignmentLeft;
        dateLabel.font = [UIFont systemFontOfSize:HEIGHT_6(14)];
        dateLabel.textColor = Order_LABEL_COLOR;
        [backgroundView addSubview:dateLabel];
        
        classLabel = [[UILabel alloc]init];
        classLabel.textAlignment = NSTextAlignmentLeft;
        classLabel.textColor = Order_LABEL_COLOR;
        classLabel.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
        [backgroundView addSubview:classLabel];
        
        VIPnameLabel = [[UILabel alloc]init];
        VIPnameLabel.font = [UIFont systemFontOfSize:HEIGHT_6(16)];
        [backgroundView addSubview:VIPnameLabel];
        
        telLabel = [[UILabel alloc]init];
        telLabel.font = [UIFont systemFontOfSize:HEIGHT_6(13)];
        telLabel.textColor = Order_LABEL_COLOR;
        [backgroundView addSubview:telLabel];
        
        placeLabel = [[UILabel alloc]init];
        placeLabel.textColor = Order_LABEL_COLOR;
        placeLabel.font = [UIFont systemFontOfSize:HEIGHT_6(13)];
        placeLabel.numberOfLines = 2;
//        placeLabel.backgroundColor = [UIColor redColor];
        [backgroundView addSubview:placeLabel];
        
        statusLabel = [[UILabel alloc]init];
        statusLabel.font = [UIFont systemFontOfSize:HEIGHT_6(14)];
        statusLabel.textAlignment = NSTextAlignmentCenter;
        [backgroundView addSubview:statusLabel];
        
        coachImageV = [[UIImageView alloc]init];
        coachImageV.layer.cornerRadius = HEIGHT_6(20.0);
        coachImageV.layer.masksToBounds = YES;
        [backgroundView addSubview:coachImageV];
        
        coachLabel = [[UILabel alloc]init];
        coachLabel.textAlignment = NSTextAlignmentCenter;
        coachLabel.font = [UIFont systemFontOfSize:HEIGHT_6(14)];
        [backgroundView addSubview:coachLabel];
        
        line = [[UILabel alloc]init];
        line.backgroundColor = Order_LABEL_COLOR;
        [backgroundView addSubview:line];
        
        deleteOrderBtn = [[UIButton alloc]init];
        [deleteOrderBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        deleteOrderBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        deleteOrderBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT_6(14)];
        [deleteOrderBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [deleteOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        deleteOrderBtn.layer.cornerRadius = HEIGHT_6(12);
        deleteOrderBtn.layer.masksToBounds = YES;
        deleteOrderBtn.layer.borderColor = [UIColor blackColor].CGColor;
        deleteOrderBtn.layer.borderWidth = 1;
        [backgroundView addSubview:deleteOrderBtn];
        
        evaluateBtn = [[UIButton alloc]init];
//        [evaluateBtn setTitle:@"订单评价" forState:UIControlStateNormal];
//        evaluateBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        evaluateBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT_6(14)];
        [evaluateBtn addTarget:self action:@selector(evaluateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [evaluateBtn setImage:[UIImage imageNamed:@"评价.png"] forState:UIControlStateNormal];
//        [evaluateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        evaluateBtn.layer.cornerRadius = HEIGHT_6(12);
//        evaluateBtn.layer.masksToBounds = YES;
//        evaluateBtn.layer.borderColor = [UIColor blackColor].CGColor;
//        evaluateBtn.layer.borderWidth = 1;
        [backgroundView addSubview:evaluateBtn];
        
        detailImageV = [[UIImageView alloc]init];
//        detailImageV.backgroundColor = [UIColor redColor];
        [backgroundView addSubview:detailImageV];
        
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.and.right.offset(0);
            make.bottom.offset(-10);
        }];
        
        [self layoutBackgroundSubviews];
        
//        timeLabel.text = @"16:11";
//        dateLabel.text = @"2000-10-10";
//        classLabel.text = @"热血搏击";
//        VIPnameLabel.text = @"会员: 朱学森";
//        telLabel.text = @"15733322222";
//        placeLabel.text = @"朝阳区百子湾路后花园现代城8888";
//        statusLabel.text = @"一出发";
//        coachImageV.backgroundColor = [UIColor redColor];
//        coachLabel.text = @"大宝宝";
}
    return self;
}
- (void)createCellWithModel:(OrderModel *)model{
    NSString * date = [NSString dateToString:[NSString stringWithFormat:@"%ld",(long)model.pre_time] Format:@"yyyy-MM-dd"];
    dateLabel.text = date;
    NSString * time = [NSString dateToString:[NSString stringWithFormat:@"%ld",(long)model.pre_time] Format:@"hh:mm"];
    timeLabel.text = time;
    classLabel.text = model.course;
    VIPnameLabel.text = [NSString stringWithFormat:@"会员: %@",model.name];
    telLabel.text = model.number;
    placeLabel.text = model.place;
    statusLabel.text = model.order_status;
    coachLabel.text = model.coach_info[@"username"];
    [coachImageV sd_setImageWithURL:[NSURL URLWithString:model.coach_info[@"headimg"]]];
    if (model.gd_status != 7) {
//        evaluateBtn.hidden = YES;
    }
    
}
- (void)layoutBackgroundSubviews{
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(HEIGHT_6(20));
        make.left.offset(15);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(HEIGHT_6(16));
    }];
    
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.mas_equalTo(timeLabel.mas_bottom).offset(HEIGHT_6(10));
        make.width.mas_equalTo(185);
        make.height.mas_equalTo(HEIGHT_6(16));
    }];
    
    [classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(dateLabel.mas_bottom).offset(HEIGHT_6(15));
        make.left.offset(15);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(HEIGHT_6(18));
    }];
    
    CGFloat Center_Width = 120;
    
    [VIPnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(HEIGHT_6(20));
        make.centerX.offset(0);
        make.width.mas_equalTo(Center_Width);
        make.height.mas_equalTo(HEIGHT_6(18));
    }];
    
    [telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(VIPnameLabel.mas_bottom).offset(HEIGHT_6(10));
        make.centerX.offset(0);
        make.width.mas_equalTo(Center_Width);
        make.height.mas_equalTo(HEIGHT_6(14));
    }];
    
    [placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(telLabel.mas_bottom).offset(HEIGHT_6(10));
        make.centerX.offset(10);
        make.width.mas_equalTo(Center_Width + 20);
        make.height.mas_equalTo(HEIGHT_6(35));
    }];
    
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(HEIGHT_6(20));
        make.right.offset(-20);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
    [detailImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(HEIGHT_6(19));
        make.left.mas_equalTo(statusLabel.mas_right).offset(-15);
        make.width.mas_equalTo(HEIGHT_6(17));
        make.height.mas_equalTo(HEIGHT_6(17));
    }];
    
    [coachImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(statusLabel.mas_bottom).offset(HEIGHT_6(5));
        make.centerX.mas_equalTo(statusLabel.mas_centerX);
        make.width.and.height.mas_equalTo(HEIGHT_6(40));
        
    }];
    
    [coachLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(coachImageV.mas_bottom).offset(8);
        make.centerX.mas_equalTo(statusLabel.mas_centerX);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.offset(0);
        make.top.mas_equalTo(placeLabel.mas_bottom).offset(HEIGHT_6(10));
        make.height.mas_equalTo(1);
    }];
    
    [deleteOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-HEIGHT_6(15));
        make.right.offset(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(HEIGHT_6(24));
        
    }];
    
    [evaluateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(deleteOrderBtn.mas_left).offset(-10);
        make.bottom.offset(-HEIGHT_6(14));
        make.width.mas_equalTo(WIDTH_6(27));
        make.height.mas_equalTo(HEIGHT_6(26));

    }];
}
- (void)deleteBtnClick:(UIButton *)deleteBtn{
    NSLog(@"删除订单");
    if ([self.delegate respondsToSelector:@selector(deleteOrderWithIndexRow:)]) {
        [self.delegate deleteOrderWithIndexRow:_index_row];
    }
    
}
- (void)evaluateBtnClick:(UIButton *)btn{
    NSLog(@"评价订单");
    if ([self.delegate respondsToSelector:@selector(evaluateOrderWithIndexRow:)]) {
        [self.delegate evaluateOrderWithIndexRow:_index_row];
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
