//
//  SugerAlertView.m
//  NowExercise
//
//  Created by 朱学森 on 2017/5/5.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "SugerAlertView.h"
#import "HYYCalendar+Helper.h"
#import "NSDate+Agenda.h"
#import "NSString+Suger.h"
@interface SugerAlertView()<HYYCalendarDelegate,UITextFieldDelegate>
{
    
    UILabel * classLabel;
    UILabel * nameLabel;
    UILabel * telLabel;
    UILabel * dateLabel;
    UILabel * timeLabel;
    UILabel * placeLabel;
    
    NSTimer * timer;
    
    ClassModel * classmodel;
    
}
/***************************下单提示框*********************************/
/**
 体验店还是私人地点
 */
@property (nonatomic , assign) ClassTypes classType;

/**
 名字
 */
@property (nonatomic , strong) UITextField * nameTF;
/**
 电话
 */
@property (nonatomic , strong) UITextField * telTF;
/**
 日期
 */
@property (nonatomic , strong) UIButton * dateBtn;
/**
 时间
 */
@property (nonatomic , strong) UIButton * timeBtn;
/**
 地点
 */
@property (nonatomic , strong) UITextField * placeTF;
/**
 下单
 */
@property (nonatomic , strong) UIButton * BuyBtn;
/**
 课程(在体验店时)
 */
@property (nonatomic , strong) UITextField * classTF;

@property (nonatomic , assign) BOOL AddOrder;

/***************************下单提示框*********************************/
@property (nonatomic, strong) UIView     *alertView;
@property (nonatomic, strong) UIView     *coverView;

@end

@implementation SugerAlertView
+ (void)sr_showAlertViewWithPlaceOrType:(ClassTypes)classtype Delegate:(id<SugerAlertViewDelegate>)delegate model:model{
    SugerAlertView * alertView = [[self alloc]initWithPlaceOrType:classtype Delegate:delegate model:model];
    
    [alertView showalert];
}
- (instancetype)initWithPlaceOrType:(ClassTypes)classtype Delegate:(id<SugerAlertViewDelegate>)delegate model:(ClassModel *)model{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.AddOrder = YES;
        _delegate = delegate;
        _classType = classtype;
        classmodel = model;
        [self addNoticeForKeyboard];
        [self layoutView];
        [self initData];
    }
    return self;
}
#pragma mark - 键盘通知
- (void)addNoticeForKeyboard {
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = (_placeTF.frame.origin.y+_placeTF.frame.size.height) - (self.frame.size.height - kbHeight);
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
//    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = CGRectMake(0.0f, -kbHeight + HEIGHT_6(45) +10, self.frame.size.width, self.frame.size.height);
        }];
//    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }];
}
- (void)initData{
    _nameTF.text = classmodel.userInfo[@"name"];
    _telTF.text = classmodel.userInfo[@"phone"];
    _placeTF.text = classmodel.userInfo[@"address"];
    
}
- (void)layoutView{
    [self addSubview:({
        _alertView = [[UIView alloc] init];
        //_alertView.backgroundColor     = [UIColor whiteColor];
        _alertView;
    })];
    
    //高度
    CGFloat THE_height = HEIGHT_6(45);
    
    
    classLabel = [[UILabel alloc]init];
    nameLabel  = [[UILabel alloc]init];
    telLabel   = [[UILabel alloc]init];
    dateLabel  = [[UILabel alloc]init];
    timeLabel  = [[UILabel alloc]init];
    placeLabel = [[UILabel alloc]init];
    
    classLabel.textColor = [UIColor blackColor];
    nameLabel.textColor = [UIColor blackColor];
    telLabel.textColor = [UIColor blackColor];
    dateLabel.textColor = [UIColor blackColor];
    timeLabel.textColor = [UIColor blackColor];
    placeLabel.textColor = [UIColor blackColor];
    
    classLabel.backgroundColor = [UIColor whiteColor];
    nameLabel.backgroundColor = [UIColor whiteColor];
    telLabel.backgroundColor = [UIColor whiteColor];
    dateLabel.backgroundColor = [UIColor whiteColor];
    timeLabel.backgroundColor = [UIColor whiteColor];
    placeLabel.backgroundColor = [UIColor whiteColor];
    
    classLabel.text = @"  课程名称";
    nameLabel.text = @"  姓名";
    telLabel.text = @"  电话";
    dateLabel.text = @"  日期";
    timeLabel.text = @"  时间";
    placeLabel.text = @"  地址";
    
    classLabel.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
    nameLabel.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
    telLabel.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
    dateLabel.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
    timeLabel.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
    placeLabel.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
    
    [_alertView addSubview:classLabel];
    [_alertView addSubview:nameLabel];
    [_alertView addSubview:telLabel];
    [_alertView addSubview:dateLabel];
    [_alertView addSubview:timeLabel];
    [_alertView addSubview:placeLabel];
    
    UILabel * classline = [[UILabel alloc]initWithFrame:CGRectMake(10, THE_height - 2, SCREEN_W - 10, 1)];
    classline.backgroundColor = [UIColor lightGrayColor];
    classline.alpha = 0.3;
    [_alertView addSubview:classline];
    
    UILabel * nameline = [[UILabel alloc]initWithFrame:CGRectMake(10, THE_height * 2 - 1, SCREEN_W - 10, 1)];
    nameline.alpha = 0.3;
    nameline.backgroundColor = [UIColor lightGrayColor];
    [_alertView addSubview:nameline];
    
    UILabel * tel = [[UILabel alloc]initWithFrame:CGRectMake(10, THE_height * 3 - 1, SCREEN_W - 10, 1)];
    tel.alpha = 0.3;
    tel.backgroundColor = [UIColor lightGrayColor];
    [_alertView addSubview:tel];
    
    UILabel * dateline = [[UILabel alloc]initWithFrame:CGRectMake(10, THE_height * 4 - 1, SCREEN_W - 10, 1)];
    dateline.alpha = 0.3;
    dateline.backgroundColor = [UIColor lightGrayColor];
    [_alertView addSubview:dateline];
    
    UILabel * timeline = [[UILabel alloc]initWithFrame:CGRectMake(10, THE_height * 5 - 1, SCREEN_W - 10, 1)];
    timeline.alpha = 0.3;
    timeline.backgroundColor = [UIColor lightGrayColor];
    [_alertView addSubview:timeline];
    
    UILabel * placeline = [[UILabel alloc]initWithFrame:CGRectMake(10, THE_height * 6 - 1, SCREEN_W - 10, 1)];
    placeline.alpha = 0.3;
    placeline.backgroundColor = [UIColor lightGrayColor];
    [_alertView addSubview:placeline];
    
    self.classTF = [[UITextField alloc]init];
    self.nameTF  = [[UITextField alloc]init];
    self.telTF   = [[UITextField alloc]init];
    self.dateBtn = [[UIButton alloc]init];
    self.timeBtn = [[UIButton alloc]init];
    self.placeTF = [[UITextField alloc]init];
    
    self.classTF.font = [UIFont systemFontOfSize:HEIGHT_6(16)];
    self.nameTF.font = [UIFont systemFontOfSize:HEIGHT_6(16)];
    self.telTF.font = [UIFont systemFontOfSize:HEIGHT_6(16)];
    self.placeTF.font = [UIFont systemFontOfSize:HEIGHT_6(16)];
    
    self.classTF.textAlignment = NSTextAlignmentRight;
    self.nameTF.textAlignment = NSTextAlignmentRight;
    self.telTF.textAlignment = NSTextAlignmentRight;
    self.dateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.timeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    self.nameTF.delegate = self;
    self.telTF.delegate = self;
    self.placeTF.delegate = self;
    
    self.nameTF.returnKeyType = UIReturnKeyDone;
    self.telTF.returnKeyType = UIReturnKeyDone;
    self.placeTF.returnKeyType = UIReturnKeyDone;
    
    self.placeTF.textAlignment = NSTextAlignmentRight;
    [self.dateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.timeBtn addTarget:self action:@selector(timeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.dateBtn addTarget:self action:@selector(DateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.BuyBtn = [[UIButton alloc]init];
    
    [self.BuyBtn setTitle:@"下     单" forState:UIControlStateNormal];
    self.BuyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(20)];
    [self.BuyBtn setTintColor:[UIColor blackColor]];
    self.BuyBtn.backgroundColor = [UIColor colorWithRed:231 / 255.0f green:212 / 255.0f blue:194 / 255.0f alpha:1];
    [self.BuyBtn addTarget:self action:@selector(BuyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_alertView addSubview:self.classTF];
    [_alertView addSubview:self.nameTF];
    [_alertView addSubview:self.telTF];
    [_alertView addSubview:self.dateBtn];
    [_alertView addSubview:self.timeBtn];
    [_alertView addSubview:self.placeTF];
    
    [_alertView addSubview:self.BuyBtn];
    
    /******************************布局*******************************/
    
    classLabel.frame = CGRectMake(0, 0, SCREEN_W , THE_height);
    self.classTF.frame = CGRectMake(WIDTH_6(120), 0, SCREEN_W - WIDTH_6(120), THE_height);
    
    nameLabel.frame = CGRectMake(0, THE_height, SCREEN_W , THE_height);
    self.nameTF.frame = CGRectMake(WIDTH_6(70), THE_height, SCREEN_W - WIDTH_6(80), THE_height);
    
    telLabel.frame = CGRectMake(0, THE_height * 2, SCREEN_W , THE_height);
    self.telTF.frame = CGRectMake(WIDTH_6(70), THE_height * 2, SCREEN_W - WIDTH_6(80), THE_height);
    
    dateLabel.frame = CGRectMake(0, THE_height * 3, SCREEN_W , THE_height);
    self.dateBtn.frame = CGRectMake(WIDTH_6(70), THE_height * 3, SCREEN_W - WIDTH_6(80), THE_height);
    
    timeLabel.frame = CGRectMake(0, THE_height * 4, SCREEN_W , THE_height);
    self.timeBtn.frame = CGRectMake(WIDTH_6(70), THE_height * 4, SCREEN_W - WIDTH_6(80), THE_height);
    
    placeLabel.frame = CGRectMake(0, THE_height * 5, SCREEN_W , THE_height);
    self.placeTF.frame = CGRectMake(WIDTH_6(70),THE_height * 5 , SCREEN_W - WIDTH_6(70) - THE_height, THE_height);
    UIButton * placeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.placeTF.frame) + 5,THE_height * 5 , WIDTH_6(40), THE_height)];
    [placeBtn addTarget:self action:@selector(placeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [placeBtn setImage:[UIImage imageNamed:@"下拉.png"] forState:UIControlStateNormal];
//    placeBtn.backgroundColor = [UIColor redColor];
    [_alertView addSubview:placeBtn];
    self.BuyBtn.frame = CGRectMake(0, THE_height * 6, SCREEN_W, THE_height + 10);
    
    _alertView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, THE_height * 7 + 10);
    
    if (_classType == ClassTypeWithClass) {
        classLabel.hidden = YES;
        _classTF.hidden = YES;
        classline.hidden = YES;
    }
    
}
#pragma mark 日期按钮
- (void)DateBtnClick:(UIButton *)DateBtn{
    HYYCalendar * DateView = [[HYYCalendar alloc]initWithFrame:[UIScreen mainScreen].bounds number:0 unit:HYYCalendarUnitDay type:HYYCalendarTypeCollection];
    DateView.delegate = self;
    [self addSubview:DateView];
    [DateView show];
    
}
#pragma mark 时间按钮
- (void)timeBtnClick:(UIButton *)btn{
    DLPickerView * picker = [[DLPickerView alloc]initWithDataSource:classmodel.pre_times withSelectedItem:btn.titleLabel.text withSelectedBlock:^(id  _Nonnull item) {
        [btn setTitle:item forState:UIControlStateNormal];
        
    }];
    [picker show];
}
- (void)placeBtnClick{
    NSString * url = [NSString stringWithFormat:@"%@api/?method=address.list",BASEURL];
    WeakSelf
    [HttpRequest GetHttpwithUrl:url parameters:nil andsuccessBlock:^(NSDictionary * _Nonnull responseObject) {
        NSMutableArray * place = [[NSMutableArray alloc]init];
        NSMutableArray * arr = responseObject[@"data"];
        for (NSDictionary * dic in arr) {
            [place addObject:dic[@"address"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
           DLPickerView * pick = [[DLPickerView alloc]initWithDataSource:place withSelectedItem:weakSelf.placeTF.text withSelectedBlock:^(id  _Nonnull item) {
               weakSelf.placeTF.text = item;
           }];
            [pick show];
        });
    } andfailBlock:^(NSError * _Nonnull error) {
        [HttpRequest showAlert];
    }];
}
- (void)BuyBtnClick:(UIButton *)BuyBtn{
    if (self.nameTF.text.length == 0) {
        [HttpRequest showAlertWithTitle:@"姓名不能为空"];
    }else if (self.telTF.text.length != 11){
        [HttpRequest showAlertWithTitle:@"请正确填写手机号码"];
    }else if(self.dateBtn.titleLabel.text.length == 0){
        [HttpRequest showAlertWithTitle:@"请选择预约日期"];
    }else if(self.timeBtn.titleLabel.text.length == 0){
        [HttpRequest showAlertWithTitle:@"请选择预约时间"];
    }else if(self.placeTF.text.length == 0){
        [HttpRequest showAlertWithTitle:@"地址不能为空"];
    }else{
        if (classmodel.package_balance !=0) {
            NSString * str = [NSString stringWithFormat:@"目标课程:%@\n\n您目前所剩套餐数:%ld",classmodel.class_name,classmodel.package_balance];
            [SRAlertView sr_showAlertViewWithTitle:@"提示" message:str leftActionTitle:@"确定" rightActionTitle:@"取消" animationStyle:AlertViewAnimationZoom selectAction:^(AlertViewActionType actionType) {
                if (actionType == AlertViewActionTypeLeft) {
                    [self addorder];
                }
            }];

        }else{
        
            [self addorder];
        }

//        WeakSelf
//        if(classmodel.package_balance != 0){
//            NSString * str = [NSString stringWithFormat:@"预约课程:%@\n当前剩余:%ld课时",classmodel.class_name,classmodel.package_balance];
//            [SRAlertView sr_showAlertViewWithTitle:@"提示" message:str leftActionTitle:@"确定" rightActionTitle:@"取消" animationStyle:AlertViewAnimationZoom selectAction:^(AlertViewActionType actionType) {
//                if (actionType == AlertViewActionTypeLeft) {
//                }
//            }];
//        }
    }
}
- (void)addorder{
    // 封装时间戳
    WeakSelf
    NSString* timeString = [self.timeBtn.titleLabel.text substringToIndex:5];
    
    NSString* string = [NSString stringWithFormat:@"%@ %@:00", self.dateBtn.titleLabel.text, timeString];
    
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date1 = [dateFormatter dateFromString:string];
    NSString* timeSp = [NSString stringWithFormat:@"%ld", (long)[date1 timeIntervalSince1970]];
    NSLog(@"%@",timeSp);
    
    
//    NSDictionary * dict = @{@"func_id":[NSString stringWithFormat:@"%ld",classmodel.fun_id],
//                            @"course_type":@"1",
//                            @"course_num":@"1",
//                            @"number":self.telTF.text,
//                            @"name":[NSString CanUseString:self.nameTF.text],
//                            @"address":[NSString CanUseString:self.placeTF.text],
//                            @"time":timeSp};
    NSString * url = [NSString stringWithFormat:@"%@api/?method=gdcourse.get_order&func_id=%ld&course_type=1&number=%@&name=%@&address=%@&time=%@",BASEURL,(long)classmodel.fun_id,self.telTF.text,[NSString CanUseString:self.nameTF.text],[NSString CanUseString:self.placeTF.text],timeSp];
    
    //价格
    NSInteger price;
    NSArray * arr = classmodel.course;
        NSDictionary * dic = arr[0];
        price = [dic[@"rmb"] integerValue];
    
    [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(NSDictionary *responseObject) {
        if ([[[responseObject objectForKey:@"data"] objectForKey:@"order_type"] isEqualToString:@"gd"]) {
//            PayViewController * pay = [[PayViewController alloc]init];
//            pay.class_id = [NSString stringWithFormat:@"%ld",model.Sell_id];
//            pay.ispackage = YES;
//            pay.name = model.name;
//            pay.price = model.price;
//            [self.navigationController pushViewController:pay animated:YES];

            NSString * orderid = [[responseObject objectForKey:@"data"] objectForKey:@"order_id"];
            if ([weakSelf.delegate respondsToSelector:@selector(OrderWithClassID:rmb:classname:orderid:)]) {
                NSString * str = [NSString stringWithFormat:@"%ld",(long)classmodel.class_id];
                [weakSelf.delegate OrderWithClassID:str rmb:price classname:classmodel.class_name orderid:orderid];
                [weakSelf alertDismiss];
            }
        } else {
            [SRAlertView sr_showAlertViewWithTitle:@"提示" message:[[responseObject objectForKey:@"data"] objectForKey:@"info"] leftActionTitle:@"确定" rightActionTitle:nil animationStyle:AlertViewAnimationZoom selectAction:^(AlertViewActionType actionType) {
                [weakSelf alertDismiss];
            }];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[[responseObject objectForKey:@"data"] objectForKey:@"info"] delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
//            [alert show];
        }

    } andfailBlock:^(NSError *error) {
        
    }];
    
//    //代理回调下单内容
//    if ([self.delegate respondsToSelector:@selector(orderWithName:tel:date:time:place:classname:)]) {
//        [self.delegate orderWithName:self.nameTF.text tel:self.telTF.text date:self.dateBtn.titleLabel.text time:self.timeBtn.titleLabel.text place:self.placeTF.text classname:self.classTF.text];
//    }

}
//自定制
- (void)alertDismiss{
    CGPoint startPoint = CGPointMake(self.center.x, SCREEN_H - (HEIGHT_6(45) * 7 + 10) / 2);;
    self.alertView.layer.position = startPoint;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alertView.layer.position = CGPointMake(self.center.x, SCREEN_H + (HEIGHT_6(45) * 7 + 10) / 2);
    } completion:^(BOOL finished) {
        [self.alertView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
    
    if ([self.delegate respondsToSelector:@selector(SRAlertDismiss)]) {
        [self.delegate SRAlertDismiss];
    }
    
}

#pragma mark HYYClalendar delegate
- (void)calendar:(HYYCalendar *)calendar didSelectDate:(NSDate *)date number:(NSUInteger)number unit:(HYYCalendarUnit)unit{
    NSString * dateStr = [date dateStringWithFormat:@"yyyy-MM-dd"];
    NSLog(@"%@",[date dateStringWithFormat:@"yyyy-MM-dd"]);
    
    [self.dateBtn setTitle:dateStr forState:UIControlStateNormal];
    
}

- (UIView *)coverView {
    
    if (!_coverView) {
        [self insertSubview:({
            _coverView = [[UIView alloc] initWithFrame:self.bounds];
            _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            _coverView.alpha = 0.7;
            _coverView;
        }) atIndex:0];
    }
    return _coverView;
}

- (void)showalert{
    [self coverView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGPoint startPoint = CGPointMake(self.center.x, SCREEN_H);
    self.alertView.layer.position = startPoint;
    [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alertView.layer.position = CGPointMake(self.center.x, SCREEN_H - (HEIGHT_6(45) * 7 + 10) / 2);
                     } completion:nil];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:self]; //返回触摸点在视图中的当前坐标
    int y = point.y;
    if (self.AddOrder && y < SCREEN_H - (HEIGHT_6(45) * 7 + 10)) {
        [self alertDismiss];
    }
    NSLog(@"位置%d    gangdu:%f", y,(HEIGHT_6(45) * 7 + 10));
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
