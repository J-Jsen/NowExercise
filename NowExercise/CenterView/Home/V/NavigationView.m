//
//  NavigationView.m
//  NowExercise
//
//  Created by mac on 17/2/7.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "NavigationView.h"

@interface NavigationView()
{
    BOOL                firstRequest;

}
/**
 菜单栏按钮
 */
@property (nonatomic , strong) MenuButton * MenuBtn;

/**
 标题栏
 */
@property (nonatomic , strong) UILabel * TitleLabel;
@property (nonatomic , strong) UIImageView * TitleImageV;
/**
 右方按钮
 */
@property (nonatomic , strong) UIButton * RightButton;

@property (strong, nonatomic) CLLocationManager *locationManager; // 位置管理器
@property (strong, nonatomic) CLGeocoder        *geoCoder;        // 地理编码器


@end

@implementation NavigationView

- (instancetype)initWithFrame:(CGRect)frame andtitle:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        //背景色
        self.backgroundColor = THEMECOLOR;
        //菜单button
        self.MenuBtn = [MenuButton shareMenuButton];
        self.MenuBtn.frame = CGRectMake(WIDTH_6(18), 30, WIDTH_6(24), WIDTH_6(24));
        [self.MenuBtn addTarget:self action:@selector(MenuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //self.MenuButton = [[VBFPopFlatButton alloc]initWithFrame: buttonType:buttonMenuType buttonStyle:buttonRoundedStyle animateToInitialState:YES];
        
        [self addSubview:self.MenuBtn];
        
        self.TitleImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 96, 24)];
        self.TitleImageV.contentMode = UIViewContentModeBottom;
        self.TitleImageV.center = CGPointMake(self.center.x, self.MenuBtn.center.y);
        self.TitleImageV.image = [UIImage imageNamed:@"立炼.png"];
        [self addSubview:self.TitleImageV];
//        self.TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W / 2.0, 23)];
//        self.TitleLabel.center = CGPointMake(self.center.x, self.MenuBtn.center.y);
//        
//        self.TitleLabel.textAlignment = NSTextAlignmentCenter;
//        self.TitleLabel.font = FONT(@"AmericanTypewriter", 17);
//        self.TitleLabel.textColor = [UIColor redColor];
//        self.TitleLabel.text = title;
//        
//        [self addSubview:self.TitleLabel];
        
        self.RightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W - 80, 31, 70, 24)];
        [self.RightButton setTitle:@"定位中..." forState:UIControlStateNormal];
        self.RightButton.titleLabel.font = [UIFont systemFontOfSize:13];
        self.RightButton.backgroundColor = MAKA_JIN_COLOR;
        [self.RightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.RightButton.layer.cornerRadius = 12;
        self.RightButton.layer.masksToBounds = YES;
        [self.RightButton addTarget:self action:@selector(loactionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.RightButton];
        
        [self location];
    }
    return self;
    
}
- (void)location{
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)) {
            //定位功能可用，开始定位
            _locationManager = [[CLLocationManager alloc] init];
            
            //创建并初始化编码器
            _geoCoder = [[CLGeocoder alloc] init];
            
            //设置代理
            _locationManager.delegate = self;
            
            //启动跟踪定位
            [_locationManager startUpdatingLocation];
            
        } else {
            NSLog(@"未开启定位");
            [self.RightButton setTitle:@"未开启定位" forState:UIControlStateNormal];
            [SRAlertView sr_showAlertViewWithTitle:@"提示" message:@"未开启定位功能,请前去设置开启" leftActionTitle:@"确定" rightActionTitle:nil animationStyle:AlertViewAnimationZoom selectAction:^(AlertViewActionType actionType) {
                
            }];
        }
}
#pragma mark - CoreLocation
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
- (void)locationManager:(CLLocationManager*)manager didUpdateLocations:(NSArray*)locations {
    
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
    CLLocation* location = [locations firstObject]; //取出第一个位置
    
    NSDictionary *locationDict = //@{@"lnt":@"121.48",@"lat":@"31.22"};
    @{ @"lnt" : [NSString stringWithFormat:@"%f", location.coordinate.longitude],@"lat" : [NSString stringWithFormat:@"%f", location.coordinate.latitude]};
    
    if ([locationDict count] != 0 && !firstRequest) {
        [self requestCityAllowedDataWith:locationDict];
    }
}
- (void)requestCityAllowedDataWith:(NSDictionary *)dict {
    firstRequest = !firstRequest;
    NSString *urlString  = [NSString stringWithFormat:@"%@geocoding/", BASEURL];
    [HttpRequest postHttpwithUrl:urlString andparameters:dict andProgress:nil andsuccessBlock:^(NSDictionary *responseObject) {
        if ([[responseObject objectForKey:@"rc"] integerValue] == 0) {
            //城市
            NSString *city = [[responseObject objectForKey:@"city"] objectForKey:@"name"];
            [Default setObject:city forKey:@"city"];
            //城市代码
            NSString *cityNumber = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"city"] objectForKey:@"city_code"]];
            NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];  // 创建cookie属性字典
            [cookieProperties setObject:@"city_code" forKey:NSHTTPCookieName]; // 手动设置cookie的属性
            [cookieProperties setObject:cityNumber forKey:NSHTTPCookieValue];
            [cookieProperties setObject:@"www.guodongwl.com" forKey:NSHTTPCookieDomain];
            [cookieProperties setObject:@"www.guodongwl.com" forKey:NSHTTPCookieOriginURL];
            [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
            [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
            
            NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
//
            dispatch_async(dispatch_get_main_queue(), ^{
                [_RightButton setTitle:city forState:UIControlStateNormal];
                if ([[responseObject objectForKey:@"allowd"] containsObject:cityNumber]) {
                    [Default setObject:@"1" forKey:@"citycode"];
                    NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
                    [notificationCenter postNotificationName:@"location" object:nil userInfo:@{@"citycode":@"1"}];

                }else{
                    [Default setObject:@"0" forKey:@"citycode"];
                    NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
                    [notificationCenter postNotificationName:@"location" object:nil userInfo:@{@"citycode":@"0"}];

                }
            });
        }
    } andfailBlock:^(NSError *error) {
    }];
}
- (void)openMenu{
    [self.MenuBtn animateToType:buttonPausedType];
}
- (void)closeMenu{
    [self.MenuBtn animateToType:buttonMenuType];
}
- (void)loactionBtnClick:(UIButton *)Btn{
    if ([self.delegate respondsToSelector:@selector(NavigationViewRightBtnClick)]) {
        [self.delegate NavigationViewRightBtnClick];
    }
}
- (void)MenuBtnClick:(MenuButton *)btn{
    if ([self.delegate respondsToSelector:@selector(NavigationViewMenuButtonClick)]) {
        [self.delegate NavigationViewMenuButtonClick];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
