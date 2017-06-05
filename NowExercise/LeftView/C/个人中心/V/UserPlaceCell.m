//
//  UserPlaceCell.m
//  NowExercise
//
//  Created by 朱学森 on 2017/5/8.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "UserPlaceCell.h"
#import "NSString+Suger.h"
@interface UserPlaceCell()<UITextFieldDelegate>
{
    UITextField * placeTF;
    UILabel * statusLabel;
    UIButton * setDefault;
    UIButton * editingBtn;
    UIButton * deleteBtn;
    
    NSString * placeID;
    PlaceModel * model;
}

@end

@implementation UserPlaceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = MAKA_JIN_COLOR;
        model = [[PlaceModel alloc]init];
        UIColor * color = COLOR(71, 77, 82);
        placeTF = [[UITextField alloc]init];
        placeTF.textColor = color;
        placeTF.font = [UIFont systemFontOfSize:HEIGHT_6(15)];
        placeTF.delegate = self;
        placeTF.userInteractionEnabled = NO;
        placeTF.returnKeyType = UIReturnKeyDone;
        
        statusLabel = [[UILabel alloc]init];
        statusLabel.textColor = [UIColor orangeColor];
        statusLabel.hidden = YES;
        statusLabel.font = [UIFont systemFontOfSize:HEIGHT_6(14)];
        statusLabel.text = @"默认地址";
        
//        placeTF.backgroundColor = [UIColor redColor];
        setDefault = [[UIButton alloc]init];
        setDefault.layer.cornerRadius = 2;
        setDefault.layer.masksToBounds = YES;
        setDefault.backgroundColor = [UIColor orangeColor];
        [setDefault setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        setDefault.hidden = YES;
        [setDefault setTitle:@"设为默认地址" forState:UIControlStateNormal];
        setDefault.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [setDefault addTarget:self action:@selector(SetDefaultBtnClick)forControlEvents:UIControlEventTouchUpInside];
        
        setDefault.titleLabel.font = [UIFont systemFontOfSize:HEIGHT_6(15)];
        
        deleteBtn = [[UIButton alloc]init];
        deleteBtn.titleLabel.textColor = color;
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT_6(15)];
        [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        deleteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        editingBtn = [[UIButton alloc]init];
        editingBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT_6(15)];
        [editingBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [editingBtn setTitle:@"编辑" forState:UIControlStateNormal];
        editingBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [editingBtn addTarget:self action:@selector(editingBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:editingBtn];
        [self addSubview:placeTF];
        [self addSubview:statusLabel];
        [self addSubview:setDefault];
        [self addSubview:deleteBtn];
        [self layout];
    }
    return self;
}
- (void)layout{
    [placeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(5);
        make.width.mas_equalTo(SCREEN_W * 2 /3 - 10);
        make.height.mas_equalTo(HEIGHT_6(25));
    }];
    
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.bottom.offset(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(HEIGHT_6(18));
    }];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.bottom.offset(-10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(HEIGHT_6(20));
    }];
    
    [editingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(deleteBtn.mas_left).offset(- 10);
        make.bottom.offset(-10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(HEIGHT_6(20));
    }];
    
    [setDefault mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(HEIGHT_6(20));
    }];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.userInteractionEnabled = NO;
    if (textField == placeTF && textField.text.length) {
        
        NSString * str = [NSString CanUseString:placeTF.text];
        NSString * url = [NSString stringWithFormat:@"%@api/?method=address.modify&address_id=%ld&address=%@",BASEURL,(long)model.placeID,str];
        [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(NSDictionary *responseObject) {
            NSLog(@"修改成功");
        } andfailBlock:^(NSError *error) {
            NSLog(@"开小差了");
        }];
    }
}
- (void)createCellWithModel:(PlaceModel *)placemodel{
    model = placemodel;
    placeTF.text = placemodel.address;
    if (placemodel.default_place) {
        [self statusHide];
        setDefault.hidden = YES;
    }else{
        [self setDefaultHide];
    }
}
- (void)creatCellWithStr:(NSString *)str andplaceid:(NSString *)placeid{
    placeTF.text = str;
    
}
- (void)statusHide{
    statusLabel.hidden = NO;
}
- (void)setDefaultHide{
    setDefault.hidden = NO;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)SetDefaultBtnClick{
    //设置为默认
    if ([self.delegate respondsToSelector:@selector(placeChangeWithmodel:type:index:)]) {
        [self.delegate placeChangeWithmodel:model type:1 index:_index_row];
    }
}
- (void)deleteBtnClick{
    //删除
    if ([self.delegate respondsToSelector:@selector(placeChangeWithmodel:type:index:)]) {
        [self.delegate placeChangeWithmodel:model type:2 index:_index_row];
    }

}
- (void)editingBtnClick{
    placeTF.userInteractionEnabled = YES;
    [placeTF becomeFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
