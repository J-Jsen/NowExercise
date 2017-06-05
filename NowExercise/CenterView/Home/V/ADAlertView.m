//
//  ADAlertView.m
//  NowExercise
//
//  Created by 朱学森 on 2017/5/11.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "ADAlertView.h"

@interface ADAlertView()
{
    UIButton * BackBtn;
    UIImageView * imageV;
    NSString * imageUrl;
}
@property (nonatomic, strong) UIView     *coverView;

@end

@implementation ADAlertView

+ (void)showAlertViewWithurl:(NSString *)url{
    ADAlertView * alert = [[ADAlertView alloc]initWithFrame:[UIScreen mainScreen].bounds url:url];
    [alert show];
}

- (instancetype)initWithFrame:(CGRect)frame url:(NSString *)url{
    if (self = [super initWithFrame:frame]) {
        imageUrl = url;
        imageV = [[UIImageView alloc]initWithFrame:frame];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.userInteractionEnabled = YES;
        [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"弹窗.png"]];
        [self addSubview:imageV];
        
        BackBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 170, 36)];
        BackBtn.center = CGPointMake(self.center.x, SCREEN_H - 140);
        BackBtn.layer.cornerRadius = 18;
        BackBtn.layer.masksToBounds = YES;
        [BackBtn setTitle:@"参与私教体验课" forState:UIControlStateNormal];
        [BackBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        BackBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        BackBtn.backgroundColor = MAKA_JIN_COLOR;
        [BackBtn addTarget:self action:@selector(BackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:BackBtn];
        
    }
    return self;
}
- (UIView *)coverView {
    
    if (!_coverView) {
        [self insertSubview:({
            _coverView = [[UIView alloc] initWithFrame:self.bounds];
            _coverView.backgroundColor = [UIColor blackColor];
            _coverView.alpha = 0.3;
            _coverView;
        }) atIndex:0];
    }
    return _coverView;
}
//出现
- (void)show{
    [self coverView];
    
    [imageV.layer setValue:@(0) forKeyPath:@"transform.scale"];

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.55 animations:^{
        [imageV.layer setValue:@(1.0) forKeyPath:@"transform.scale"];

    } completion:^(BOOL finished) {
        
    }];

//    [imageV.layer setValue:@(0) forKeyPath:@"transform.scale"];
//    [UIView animateWithDuration:1.25 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
//                        options:UIViewAnimationOptionCurveEaseIn
//                     animations:^{
//                         [imageV.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
//                     } completion:nil];

}
//消失
- (void)BackBtnClick:(UIButton *)backBtn{
//    [imageV.layer setValue:@(1) forKeyPath:@"transform.scale"];
//    [UIView animateWithDuration:1.25 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
//                        options:UIViewAnimationOptionCurveEaseIn
//                     animations:^{
////                         [imageV.layer setValue:@(0) forKeyPath:@"transform.scale"];
//                         imageV.transform = CGAffineTransformMakeScale(0.1, 0.1);
//                     } completion:^(BOOL finished) {
//                         [self removeFromSuperview];
//                     }];
    imageV.transform = CGAffineTransformMakeScale(1, 1);
    
    [imageV.layer setValue:@(1) forKeyPath:@"transform.scale"];

    [UIView animateWithDuration:0.55 animations:^{
//        [imageV.layer setValue:@(0) forKeyPath:@"transform.scale"];
        imageV.transform = CGAffineTransformMakeScale(0.01, 0.01);

    } completion:^(BOOL finished) {
        [self removeFromSuperview];

    }];

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
