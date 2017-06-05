//
//  SRAlertView.m
//  SRAlertViewDemo
//
//  Created by 郭伟林 on 16/7/8.
//  Copyright © 2016年 SR. All rights reserved.
//

#import "SRAlertView.h"
#import "FXBlurView.h"

#import "NSDate+Agenda.h"

#pragma mark - Screen Frame



#define SCREEN_BOUNDS          [UIScreen mainScreen].bounds
#define SCREEN_WIDTH           [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT          [UIScreen mainScreen].bounds.size.height
#define SCREEN_ADJUST(Value)   SCREEN_WIDTH * (Value) / 375.0f

#pragma mark - Color

#define COLOR_RGB(R, G, B)              [UIColor colorWithRed:(R/255.0f) green:(G/255.0f) blue:(B/255.0f) alpha:1.0f]
#define COLOR_RANDOM                    COLOR_RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define UICOLOR_FROM_HEX_ALPHA(RGBValue, Alpha) [UIColor \
colorWithRed:((float)((RGBValue & 0xFF0000) >> 16))/255.0 \
green:((float)((RGBValue & 0xFF00) >> 8))/255.0 \
blue:((float)(RGBValue & 0xFF))/255.0 alpha:Alpha]

#define UICOLOR_FROM_HEX(RGBValue) [UIColor \
colorWithRed:((float)((RGBValue & 0xFF0000) >> 16))/255.0 \
green:((float)((RGBValue & 0xFF00) >> 8))/255.0 \
blue:((float)(RGBValue & 0xFF))/255.0 alpha:1.0]

#pragma mark - Use Color

#define kTitleLabelColor                UICOLOR_FROM_HEX_ALPHA(0x000000, 1.0)
#define kMessageLabelColor              UICOLOR_FROM_HEX_ALPHA(0x313131, 1.0)

#define kBtnNormalTitleColor            UICOLOR_FROM_HEX_ALPHA(0x4A4A4A, 1.0)
#define kBtnHighlightedTitleColor       UICOLOR_FROM_HEX_ALPHA(0x4A4A4A, 1.0)
#define kBtnHighlightedBackgroundColor  UICOLOR_FROM_HEX_ALPHA(0xF76B1E, 0.15)

#define kLineBackgroundColor            [UIColor colorWithRed:1.00 green:0.92 blue:0.91 alpha:1.00]

#pragma mark - Use Frame

#define kAlertViewW             275.0f
#define kAlertViewTitleH        20.0f
#define kAlertViewBtnH          50.0f
#define kAlertViewMessageMinH   75.0f

#define kTitleFont      [UIFont boldSystemFontOfSize:SCREEN_ADJUST(18)];
#define kMessageFont    [UIFont systemFontOfSize:SCREEN_ADJUST(15)];
#define kBtnTitleFont   [UIFont systemFontOfSize:SCREEN_ADJUST(16)];

@interface SRAlertView ()
{
//
//    UILabel * classLabel;
//    UILabel * nameLabel;
//    UILabel * telLabel;
//    UILabel * dateLabel;
//    UILabel * timeLabel;
//    UILabel * placeLabel;
//    
    NSTimer * timer;
//
}
@property (nonatomic, weak  ) id<SRAlertViewDelegate>   delegate;
@property (nonatomic, copy  ) AlertViewDidSelectAction  selectAction;

@property (nonatomic, strong) UIView     *alertView;
@property (nonatomic, strong) UIView     *coverView;
@property (nonatomic, strong) FXBlurView *blurView;

@property (nonatomic, copy  ) NSString   *title;
@property (nonatomic, strong) UILabel    *titleLabel;

@property (nonatomic, copy  ) NSString   *message;
@property (nonatomic, strong) UILabel    *messageLabel;

@property (nonatomic, copy  ) NSString   *leftActionTitle;
@property (nonatomic, strong) UIButton   *leftAction;

@property (nonatomic, copy  ) NSString   *rightActionTitle;
@property (nonatomic, strong) UIButton   *rightAction;
/***************************下单提示框*********************************/
/**
 体验店还是私人地点
 */
//@property (nonatomic , assign) ClassType classType;
//
///**
// 名字
// */
//@property (nonatomic , strong) UITextField * nameTF;
///**
// 电话
// */
//@property (nonatomic , strong) UITextField * telTF;
///**
// 日期
// */
//@property (nonatomic , strong) UIButton * dateBtn;
///**
// 时间
// */
//@property (nonatomic , strong) UIButton * timeBtn;
///**
// 地点
// */
//@property (nonatomic , strong) UITextField * placeTF;
///**
// 下单
// */
//@property (nonatomic , strong) UIButton * BuyBtn;
///**
// 课程(在体验店时)
// */
//@property (nonatomic , strong) UITextField * classTF;
//
//@property (nonatomic , assign) BOOL AddOrder;
//
/***************************下单提示框*********************************/
@end

@implementation SRAlertView

#pragma mark - BLOCK

+ (void)sr_showAlertViewWithTitle:(NSString *)title
                          message:(NSString *)message
                  leftActionTitle:(NSString *)leftActionTitle
                 rightActionTitle:(NSString *)rightActionTitle
                   animationStyle:(AlertViewAnimationStyle)animationStyle
                     selectAction:(AlertViewDidSelectAction)selectAction;
{
    SRAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                         leftActionTitle:leftActionTitle
                                        rightActionTitle:rightActionTitle
                                          animationStyle:animationStyle
                                            selectAction:selectAction];
    [alertView show];
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
              leftActionTitle:(NSString *)leftActionTitle
             rightActionTitle:(NSString *)rightActionTitle
               animationStyle:(AlertViewAnimationStyle)animationStyle
                 selectAction:(AlertViewDidSelectAction)selectAction
{
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        _blurCurrentBackgroundView = YES;
        _title             = title;
        _message           = message;
        _leftActionTitle   = leftActionTitle;
        _rightActionTitle  = rightActionTitle;
        _animationStyle    = animationStyle;
        _selectAction      = selectAction;
        [self setupAlertView];
    }
    return self;
}

#pragma mark - DELEGATE

+ (void)sr_showAlertViewWithTitle:(NSString *)title
                          message:(NSString *)message
                  leftActionTitle:(NSString *)leftActionTitle
                 rightActionTitle:(NSString *)rightActionTitle
                   animationStyle:(AlertViewAnimationStyle)animationStyle
                         delegate:(id<SRAlertViewDelegate>)delegate
{
    SRAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                         leftActionTitle:leftActionTitle
                                        rightActionTitle:rightActionTitle
                                          animationStyle:animationStyle
                                                delegate:delegate];
    [alertView show];
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
              leftActionTitle:(NSString *)leftActionTitle
             rightActionTitle:(NSString *)rightActionTitle
               animationStyle:(AlertViewAnimationStyle)animationStyle
                     delegate:(id<SRAlertViewDelegate>)delegate
{
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        _blurCurrentBackgroundView = YES;
        _title             = title;
        _message           = message;
        _leftActionTitle   = leftActionTitle;
        _rightActionTitle  = rightActionTitle;
        _animationStyle    = animationStyle;
        _delegate          = delegate;
        [self setupAlertView];
    }
    return self;
}
//#pragma mark 自定制
//+ (void)sr_showAlertViewWithPlaceOrType:(ClassType)classtype Delegate:(id<SRAlertViewDelegate>)delegate{
//    SRAlertView * alertView = [[self alloc]initWithPlaceOrType:classtype Delegate:delegate];
//    
//    [alertView showalert];
//}
//
//- (instancetype)initWithPlaceOrType:(ClassType)classtype Delegate:(id<SRAlertViewDelegate>)delegate{
//    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
//        self.AddOrder = YES;
//        _delegate = delegate;
//        _classType = classtype;
//        [self layoutView];
//    }
//    return self;
//}

+ (void)suger_showAlertWithView:(UIView *)alertView{
    SRAlertView * alert = [[SRAlertView alloc]initWithFrame:SCREEN_BOUNDS alerTview:alertView];
    [alert showCustomAlert:alertView];
}
- (instancetype)initWithFrame:(CGRect)frame alerTview:(UIView *)alertV{
    
    if (self = [super initWithFrame:frame]) {
        [self coverView];
        alertV.center = self.center;
        alertV.layer.cornerRadius = 4;
        alertV.layer.masksToBounds = YES;
        [self addSubview:alertV];
    }
    return self;
}
- (void)showCustomAlert:(UIView *)alertV{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [alertV.layer setValue:@(0) forKeyPath:@"transform.scale"];
    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [alertV.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                     } completion:^(BOOL finished) {
                         
                     }];
    timer = [NSTimer timerWithTimeInterval:1.2 target:self selector:@selector(timeToDismiss) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    

}

- (void)timeToDismiss{
    [timer invalidate];
    timer = nil;
    [self removeFromSuperview];
}

#pragma mark - Setup

- (FXBlurView *)blurView {
    
    if (!_blurView) {
        _blurView = [[FXBlurView alloc] initWithFrame:SCREEN_BOUNDS];
        _blurView.tintColor = [UIColor clearColor];
        _blurView.dynamic = NO;
        _blurView.blurRadius = 0;
        [[UIApplication sharedApplication].keyWindow addSubview:_blurView];
    }
    return _blurView;
}

- (UIView *)coverView {
    
    if (!_coverView) {
        [self insertSubview:({
            _coverView = [[UIView alloc] initWithFrame:self.bounds];
            _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            _coverView.alpha = 0;
            _coverView;
        }) atIndex:0];
    }
    return _coverView;
}

- (void)setupAlertView {
    
    [self addSubview:({
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor     = [UIColor whiteColor];
        _alertView.layer.cornerRadius  = 10.0;
        _alertView.layer.masksToBounds = YES;
        _alertView;
    })];
    
    CGFloat verticalMargin = 20;
    if (_title) {
        [_alertView addSubview:({
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, verticalMargin, kAlertViewW, kAlertViewTitleH)];
            _titleLabel.text          = _title;
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.textColor     = kTitleLabelColor;
            _titleLabel.font          = kTitleFont;
            _titleLabel;
        })];
    }
    
    CGFloat messageLabelSpacing = 20;
    [_alertView addSubview:({
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.backgroundColor = [UIColor whiteColor];
        _messageLabel.textColor       = kMessageLabelColor;
        _messageLabel.font            = kMessageFont;
        _messageLabel.numberOfLines   = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maxSize = CGSizeMake(kAlertViewW - messageLabelSpacing * 2, MAXFLOAT);
        _messageLabel.text = @"one";
        CGSize tempSize    = [_messageLabel sizeThatFits:maxSize];
        _messageLabel.text = _message;
        CGSize expectSize  = [_messageLabel sizeThatFits:maxSize];
        if (expectSize.height == tempSize.height) {
            // if just only one line then set textAlignment is NSTextAlignmentCenter.
            _messageLabel.textAlignment = NSTextAlignmentCenter;
        }
        [_messageLabel sizeToFit];
        CGFloat messageLabH = expectSize.height < kAlertViewMessageMinH ? kAlertViewMessageMinH : expectSize.height;
        _messageLabel.frame = CGRectMake(messageLabelSpacing, CGRectGetMaxY(_titleLabel.frame) + verticalMargin,
                                         kAlertViewW - messageLabelSpacing * 2, messageLabH);
        _messageLabel;
    })];
    
    _alertView.frame  = CGRectMake(0, 0, kAlertViewW, CGRectGetMaxY(_messageLabel.frame) + kAlertViewBtnH + verticalMargin);
    _alertView.center = self.center;
    
    CGFloat btnY = _alertView.frame.size.height - kAlertViewBtnH;
    if (_leftActionTitle) {
        [_alertView addSubview:({
            _leftAction = [UIButton buttonWithType:UIButtonTypeCustom];
            _leftAction.tag = AlertViewActionTypeLeft;
            _leftAction.titleLabel.font = kBtnTitleFont;
            [_leftAction setTitle:_leftActionTitle forState:UIControlStateNormal];
            [_leftAction setTitleColor:kBtnNormalTitleColor forState:UIControlStateNormal];
            [_leftAction setTitleColor:kBtnHighlightedTitleColor forState:UIControlStateHighlighted];
            [_leftAction setBackgroundImage:[self imageWithColor:kBtnHighlightedBackgroundColor] forState:UIControlStateHighlighted];
            [_leftAction addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_leftAction];
            if (_rightActionTitle) {
                _leftAction.frame = CGRectMake(0, btnY, kAlertViewW * 0.5, kAlertViewBtnH);
            } else {
                _leftAction.frame = CGRectMake(0, btnY, kAlertViewW, kAlertViewBtnH);
            }
            _leftAction;
        })];
    }
    
    if (_rightActionTitle) {
        [_alertView addSubview:({
            _rightAction = [UIButton buttonWithType:UIButtonTypeCustom];
            _rightAction.tag = AlertViewActionTypeRight;
            _rightAction.titleLabel.font = kBtnTitleFont;
            [_rightAction setTitle:_rightActionTitle forState:UIControlStateNormal];
            [_rightAction setTitleColor:kBtnNormalTitleColor forState:UIControlStateNormal];
            [_rightAction setTitleColor:kBtnHighlightedTitleColor forState:UIControlStateHighlighted];
            [_rightAction setBackgroundImage:[self imageWithColor:kBtnHighlightedBackgroundColor] forState:UIControlStateHighlighted];
            [_rightAction addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_rightAction];
            if (_rightActionTitle) {
                _rightAction.frame = CGRectMake(kAlertViewW * 0.5, btnY, kAlertViewW * 0.5, kAlertViewBtnH);
            } else {
                _rightAction.frame = CGRectMake(0, btnY, kAlertViewW, kAlertViewBtnH);
            }
            _rightAction;
        })];
    }
    
    if (_leftActionTitle && _rightActionTitle) {
        UIView *line1 = [[UIView alloc] init];
        line1.frame = CGRectMake(0, btnY, kAlertViewW, 1);
        line1.backgroundColor = kLineBackgroundColor;
        [_alertView addSubview:line1];
        
        UIView *line2 = [[UIView alloc] init];
        line2.frame = CGRectMake(kAlertViewW * 0.5, btnY, 1, kAlertViewBtnH);
        line2.backgroundColor = kLineBackgroundColor;
        [_alertView addSubview:line2];
    } else {
        UIView *line = [[UIView alloc] init];
        line.frame = CGRectMake(0, btnY, kAlertViewW, 1);
        line.backgroundColor = kLineBackgroundColor;
        [_alertView addSubview:line];
    }
}

#pragma mark - Actions

- (void)btnAction:(UIButton *)btn {
    
    if (self.selectAction) {
        self.selectAction(btn.tag);
    }
    if ([self.delegate respondsToSelector:@selector(alertViewDidSelectAction:)]) {
        [self.delegate alertViewDidSelectAction:btn.tag];
    }
    
    [self dismiss];
}

//#pragma mark - Animations(Suger)
//- (void)layoutView{
//    [self addSubview:({
//        _alertView = [[UIView alloc] init];
//        //_alertView.backgroundColor     = [UIColor whiteColor];
//        _alertView;
//    })];
//    
//    //高度
//    CGFloat THE_height = HEIGHT_6(45);
//
//    
//    classLabel = [[UILabel alloc]init];
//    nameLabel  = [[UILabel alloc]init];
//    telLabel   = [[UILabel alloc]init];
//    dateLabel  = [[UILabel alloc]init];
//    timeLabel  = [[UILabel alloc]init];
//    placeLabel = [[UILabel alloc]init];
//    
//    classLabel.textColor = [UIColor blackColor];
//    nameLabel.textColor = [UIColor blackColor];
//    telLabel.textColor = [UIColor blackColor];
//    dateLabel.textColor = [UIColor blackColor];
//    timeLabel.textColor = [UIColor blackColor];
//    placeLabel.textColor = [UIColor blackColor];
//    
//    classLabel.backgroundColor = [UIColor whiteColor];
//    nameLabel.backgroundColor = [UIColor whiteColor];
//    telLabel.backgroundColor = [UIColor whiteColor];
//    dateLabel.backgroundColor = [UIColor whiteColor];
//    timeLabel.backgroundColor = [UIColor whiteColor];
//    placeLabel.backgroundColor = [UIColor whiteColor];
//    
//    classLabel.text = @"  课程名称";
//    nameLabel.text = @"  姓名";
//    telLabel.text = @"  电话";
//    dateLabel.text = @"  日期";
//    timeLabel.text = @"  时间";
//    placeLabel.text = @"  地址";
//    
//    classLabel.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
//    nameLabel.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
//    telLabel.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
//    dateLabel.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
//    timeLabel.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
//    placeLabel.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
//    
//    [_alertView addSubview:classLabel];
//    [_alertView addSubview:nameLabel];
//    [_alertView addSubview:telLabel];
//    [_alertView addSubview:dateLabel];
//    [_alertView addSubview:timeLabel];
//    [_alertView addSubview:placeLabel];
//    
//    UILabel * classline = [[UILabel alloc]initWithFrame:CGRectMake(10, THE_height - 2, SCREEN_WIDTH - 10, 1)];
//    classline.backgroundColor = [UIColor lightGrayColor];
//    classline.alpha = 0.3;
//    [_alertView addSubview:classline];
//    
//    UILabel * nameline = [[UILabel alloc]initWithFrame:CGRectMake(10, THE_height * 2 - 1, SCREEN_WIDTH - 10, 1)];
//    nameline.alpha = 0.3;
//    nameline.backgroundColor = [UIColor lightGrayColor];
//    [_alertView addSubview:nameline];
//    
//    UILabel * tel = [[UILabel alloc]initWithFrame:CGRectMake(10, THE_height * 3 - 1, SCREEN_WIDTH - 10, 1)];
//    tel.alpha = 0.3;
//    tel.backgroundColor = [UIColor lightGrayColor];
//    [_alertView addSubview:tel];
//    
//    UILabel * dateline = [[UILabel alloc]initWithFrame:CGRectMake(10, THE_height * 4 - 1, SCREEN_WIDTH - 10, 1)];
//    dateline.alpha = 0.3;
//    dateline.backgroundColor = [UIColor lightGrayColor];
//    [_alertView addSubview:dateline];
//    
//    UILabel * timeline = [[UILabel alloc]initWithFrame:CGRectMake(10, THE_height * 5 - 1, SCREEN_WIDTH - 10, 1)];
//    timeline.alpha = 0.3;
//    timeline.backgroundColor = [UIColor lightGrayColor];
//    [_alertView addSubview:timeline];
//    
//    UILabel * placeline = [[UILabel alloc]initWithFrame:CGRectMake(10, THE_height * 6 - 1, SCREEN_WIDTH - 10, 1)];
//    placeline.alpha = 0.3;
//    placeline.backgroundColor = [UIColor lightGrayColor];
//    [_alertView addSubview:placeline];
//    
////    timeLabel.backgroundColor = [UIColor redColor];
//
//    
//    
//    self.classTF = [[UITextField alloc]init];
//    self.nameTF  = [[UITextField alloc]init];
//    self.telTF   = [[UITextField alloc]init];
//    self.dateBtn = [[UIButton alloc]init];
//    self.timeBtn = [[UIButton alloc]init];
//    self.placeTF = [[UITextField alloc]init];
//    
//    self.classTF.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
//    self.nameTF.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
//    self.telTF.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
//    self.placeTF.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
//    
//    self.classTF.textAlignment = NSTextAlignmentRight;
//    self.nameTF.textAlignment = NSTextAlignmentRight;
//    self.telTF.textAlignment = NSTextAlignmentRight;
//    self.dateBtn.titleLabel.textAlignment = NSTextAlignmentRight;
//    self.timeBtn.titleLabel.textAlignment = NSTextAlignmentRight;
//    self.placeTF.textAlignment = NSTextAlignmentRight;
//    
//    [self.dateBtn addTarget:self action:@selector(DateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    
//    self.BuyBtn = [[UIButton alloc]init];
//    
//    [self.BuyBtn setTitle:@"下     单" forState:UIControlStateNormal];
//    self.BuyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(20)];
//    [self.BuyBtn setTintColor:[UIColor blackColor]];
//    self.BuyBtn.backgroundColor = [UIColor colorWithRed:231 / 255.0f green:212 / 255.0f blue:194 / 255.0f alpha:1];
//    [self.BuyBtn addTarget:self action:@selector(BuyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [_alertView addSubview:self.classTF];
//    [_alertView addSubview:self.nameTF];
//    [_alertView addSubview:self.telTF];
//    [_alertView addSubview:self.dateBtn];
//    [_alertView addSubview:self.timeBtn];
//    [_alertView addSubview:self.placeTF];
//    
//    [_alertView addSubview:self.BuyBtn];
//    
///******************************布局*******************************/
//    
//    classLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH , THE_height);
//    self.classTF.frame = CGRectMake(WIDTH_6(120), 0, SCREEN_WIDTH - WIDTH_6(120), THE_height);
//    
//    nameLabel.frame = CGRectMake(0, THE_height, SCREEN_WIDTH , THE_height);
//    self.nameTF.frame = CGRectMake(WIDTH_6(70), THE_height, SCREEN_WIDTH - WIDTH_6(70), THE_height);
//    
//    telLabel.frame = CGRectMake(0, THE_height * 2, SCREEN_WIDTH , THE_height);
//    self.telTF.frame = CGRectMake(WIDTH_6(70), THE_height * 2, SCREEN_WIDTH - WIDTH_6(70), THE_height);
//    
//    dateLabel.frame = CGRectMake(0, THE_height * 3, SCREEN_WIDTH , THE_height);
//    self.dateBtn.frame = CGRectMake(WIDTH_6(70), THE_height * 3, SCREEN_WIDTH - WIDTH_6(70), THE_height);
//    
//    timeLabel.frame = CGRectMake(0, THE_height * 4, SCREEN_WIDTH , THE_height);
//    self.timeBtn.frame = CGRectMake(WIDTH_6(70), THE_height * 4, SCREEN_WIDTH - WIDTH_6(70), THE_height);
//    
//    placeLabel.frame = CGRectMake(0, THE_height * 5, SCREEN_WIDTH , THE_height);
//    self.placeTF.frame = CGRectMake(WIDTH_6(70),THE_height * 5 , SCREEN_WIDTH - WIDTH_6(70) - THE_height, THE_height);
//    
//    self.BuyBtn.frame = CGRectMake(0, THE_height * 6, SCREEN_WIDTH, THE_height + 10);
//    
//    _alertView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, THE_height * 7 + 10);
//    
//    if (_classType == ClassTypeClass) {
//        classLabel.hidden = YES;
//        _classTF.hidden = YES;
//        classline.hidden = YES;
//    }
//    
//}
//- (void)showalert{
//    [self coverView];
//    [[UIApplication sharedApplication].keyWindow addSubview:self];
//
//    CGPoint startPoint = CGPointMake(self.center.x, SCREEN_HEIGHT);
//    self.alertView.layer.position = startPoint;
//    [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
//                        options:UIViewAnimationOptionCurveEaseIn
//                     animations:^{
//                         self.alertView.layer.position = CGPointMake(self.center.x, SCREEN_HEIGHT - (HEIGHT_6(45) * 7 + 10) / 2);
//                     } completion:nil];
//    
//}
//#pragma mark 日期按钮
//- (void)DateBtnClick:(UIButton *)DateBtn{
//    HYYCalendar * DateView = [[HYYCalendar alloc]initWithFrame:[UIScreen mainScreen].bounds number:0 unit:HYYCalendarUnitDay type:HYYCalendarTypeCollection];
//    DateView.delegate = self;
//    
//    [DateView show];
//    
//}
//
//#pragma mark HYYClalendar delegate
//- (void)calendar:(HYYCalendar *)calendar didSelectDate:(NSDate *)date number:(NSUInteger)number unit:(HYYCalendarUnit)unit{
//    NSString * dateStr = [date dateStringWithFormat:@"yyyy-MM-dd"];
//    NSLog(@"%@",[date dateStringWithFormat:@"yyyy-MM-dd"]);
//    
//    [self.dateBtn setTitle:dateStr forState:UIControlStateNormal];
//    
//}
//***********************************************************************************//
- (void)show {
    if (!_blurCurrentBackgroundView) {
        [self coverView];
    } else {
        [self blurView];
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    if (!_blurCurrentBackgroundView) {
        [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _coverView.alpha = 1.0;
                         } completion:nil];
    } else {
        _blurView.blurRadius = 10;
    }
    
    switch (self.animationStyle) {
        case AlertViewAnimationNone:
        {
            // No animation
            break;
        }
        case AlertViewAnimationZoom:
        {
            [self.alertView.layer setValue:@(0) forKeyPath:@"transform.scale"];
            [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 [self.alertView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                             } completion:nil];
            break;
        }
        case AlertViewAnimationTopToCenterSpring:
        {
            CGPoint startPoint = CGPointMake(self.center.x, -self.alertView.frame.size.height);
            self.alertView.layer.position = startPoint;
            [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alertView.layer.position = self.center;
                             } completion:nil];
            break;
        }
        case AlertViewAnimationDownToCenterSpring:
        {
            CGPoint startPoint = CGPointMake(self.center.x, SCREEN_HEIGHT);
            self.alertView.layer.position = startPoint;
            [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alertView.layer.position = self.center;
                             } completion:nil];
            break;
        }
        case AlertViewAnimationLeftToCenterSpring:
        {
            CGPoint startPoint = CGPointMake(-kAlertViewW, self.center.y);
            self.alertView.layer.position = startPoint;
            [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alertView.layer.position = self.center;
                             } completion:nil];
            break;
        }
        case AlertViewAnimationRightToCenterSpring:
        {
            CGPoint startPoint = CGPointMake(SCREEN_WIDTH + kAlertViewW, self.center.y);
            self.alertView.layer.position = startPoint;
            [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alertView.layer.position = self.center;
                             } completion:nil];
            break;
        }
    }
}

- (void)dismiss {

    [self.alertView removeFromSuperview];
    
    if (!_blurCurrentBackgroundView) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _coverView.alpha = 0;
                         } completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
    } else {
        [_blurView removeFromSuperview];
        [self removeFromSuperview];
    }
}
////自定制
//- (void)alertDismiss{
//    CGPoint startPoint = CGPointMake(self.center.x, SCREEN_HEIGHT - (HEIGHT_6(45) * 7 + 10) / 2);;
//    self.alertView.layer.position = startPoint;
//
//    [UIView animateWithDuration:0.3 animations:^{
//        self.alertView.layer.position = CGPointMake(self.center.x, SCREEN_HEIGHT + (HEIGHT_6(45) * 7 + 10) / 2);
//    } completion:^(BOOL finished) {
//        [self.alertView removeFromSuperview];
//        [self removeFromSuperview];
//
//    }];
//    
//    if ([self.delegate respondsToSelector:@selector(SRAlertDismiss)]) {
//        [self.delegate SRAlertDismiss];
//    }
//
////}
//#pragma mark 下单按钮点击事件
//- (void)BuyBtnClick:(UIButton *)BuyBtn{
//    [self alertDismiss];
//    //代理回调下单内容
//    if ([self.delegate respondsToSelector:@selector(orderWithName:tel:date:time:place:classname:)]) {
//        [self.delegate orderWithName:self.nameTF.text tel:self.telTF.text date:self.dateBtn.titleLabel.text time:self.timeBtn.titleLabel.text place:self.placeTF.text classname:self.classTF.text];
//    }
//}

#pragma mark - Other

- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Public interface

- (void)setAnimationStyle:(AlertViewAnimationStyle)animationStyle {
    
    if (_animationStyle == animationStyle) {
        return;
    }
    _animationStyle = animationStyle;
}

- (void)setBlurCurrentBackgroundView:(BOOL)blurCurrentBackgroundView {
    
    if (_blurCurrentBackgroundView == blurCurrentBackgroundView) {
        return;
    }
    _blurCurrentBackgroundView = blurCurrentBackgroundView;
}

- (void)setActionWhenHighlightedTitleColor:(UIColor *)actionWhenHighlightedTitleColor {
    
    if (_actionWhenHighlightedTitleColor == actionWhenHighlightedTitleColor) {
        return;
    }
    _actionWhenHighlightedTitleColor = actionWhenHighlightedTitleColor;
    
    [self.leftAction  setTitleColor:actionWhenHighlightedTitleColor forState:UIControlStateHighlighted];
    [self.rightAction setTitleColor:actionWhenHighlightedTitleColor forState:UIControlStateHighlighted];
}

- (void)setActionWhenHighlightedBackgroundColor:(UIColor *)actionWhenHighlightedBackgroundColor {
    
    if (_actionWhenHighlightedBackgroundColor == actionWhenHighlightedBackgroundColor) {
        return;
    }
    _actionWhenHighlightedBackgroundColor = actionWhenHighlightedBackgroundColor;
    
    [self.leftAction  setBackgroundImage:[self imageWithColor:actionWhenHighlightedBackgroundColor] forState:UIControlStateHighlighted];
    [self.rightAction setBackgroundImage:[self imageWithColor:actionWhenHighlightedBackgroundColor] forState:UIControlStateHighlighted];
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
//    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
//    CGPoint point = [touch locationInView:self]; //返回触摸点在视图中的当前坐标
//    int y = point.y;
//    if (self.AddOrder && y < SCREEN_H - (HEIGHT_6(45) * 7 + 10)) {
//        [self alertDismiss];
//    }
//    NSLog(@"位置%d    gangdu:%f", y,(HEIGHT_6(45) * 7 + 10));
//}
@end
