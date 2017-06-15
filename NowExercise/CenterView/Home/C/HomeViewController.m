//
//  HomeViewController.m
//  NowExercise
//
//  Created by mac on 17/1/19.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "HomeViewController.h"
#import "NavigationView.h"

#import "DetailCell.h"

#import "LoginViewController.h"

#import "UserViewController.h"
#import "OrderViewController.h"
#import "PreferentialViewController.h"
#import "BodyDataViewController.h"
#import "SellViewController.h"
#import "PersonalViewController.h"
#import "SettingViewController.h"
//二级页面
#import "ClassViewController.h"
#import "LocationViewController.h"
#import "PayViewController.h"
#import "PGIndexBannerSubiew.h"
#import "AppointmentView.h"
#import "ActivityViewController.h"
//model
#import "HomeModel.h"
#import "ClassModel.h"
#import "NSString+Suger.h"

#import "SugerAlertView.h"
#import "ADAlertView.h"
@interface HomeViewController ()<NavigationViewDelegate,UITableViewDelegate,UITableViewDataSource,SRAlertViewDelegate,NewPagedFlowViewDataSource,NewPagedFlowViewDelegate,SugerAlertViewDelegate>
{
    BOOL persenMessage;
    UIView * bannerView;
    //课程介绍滑动到第几页
    NSInteger page_index;
    NSArray * data;
    BOOL first;
    BOOL LOAD;
    MBProgressHUD * hud;
}
/**
 自定制导航栏
 */
@property (nonatomic , strong) NavigationView * NavigationV;

/**
 <#Description#>
 */
@property (nonatomic , strong) UITableView * TableV;
@property (nonatomic , strong) NSMutableArray * dataArr;
@property (nonatomic , strong) UIButton * ExerciseBtn;


@property (nonatomic , strong) NewPagedFlowView * pageFlowView;
@property (nonatomic , strong) RPRingedPages * pages;



@end

@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.alpha = 0;
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    if (!LOAD) {
        [self Reloddata];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loactionView:) name:@"location" object:nil];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    LOAD = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    LOAD = YES;
    //背景色
    self.view.backgroundColor = THEMECOLOR;
    [self InitData];
    [self CreatNavigationView];
    [self CreateUI];
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)Reloddata{
//    NSString * urll =  @"http://www.guodongwl.com:8065/userlogin/?number=18618263726&code=1234";
//[HttpRequest PostHttpwithUrl:urll andparameters:nil andProgress:nil andsuccessBlock:^(NSDictionary *responseObject) {
//    
//} andfailBlock:^(NSError *error) {
//    
//}];
//
    [self.dataArr removeAllObjects];
    
    NSString * url = [NSString stringWithFormat:@"%@api/?method=index.index",BASEURL];
    [HttpRequest GetHttpwithUrl:url parameters:nil andsuccessBlock:^(NSDictionary * responseObject) {
        if ([[responseObject objectForKey:@"rc"] integerValue] == 3) {
            [SRAlertView sr_showAlertViewWithTitle:@"提示" message:@"您的身份认证已过期,请前去登陆" leftActionTitle:@"确定" rightActionTitle:@"取消" animationStyle:AlertViewAnimationZoom delegate:self];
        }else{
            NSLog(@"数据如下:**************************************\n%@",responseObject);
            NSDictionary * dict = responseObject[@"data"];
            //套餐介绍
            NSDictionary * package = dict[@"package_info"];
            HomeModel * model = [[HomeModel alloc]init];
            [model setValuesForKeysWithDictionary:package];
            model.Cell_Height = [HttpRequest sizeWithText:model.intro font:[UIFont systemFontOfSize:HEIGHT_6(17)] maxWidth:SCREEN_W - 30].height + SCREEN_H - 150;
            [self.dataArr addObject:model];
            
            //课程
            NSArray * course = dict[@"course"];
            for (NSDictionary * dic in course) {
                HomeModel * model = [[HomeModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                CGSize size = [HttpRequest sizeWithText:model.intro font:[UIFont systemFontOfSize:HEIGHT_6(17)] maxWidth:SCREEN_W - 30];
                model.Cell_Height = size.height + SCREEN_H - 150;
                [self.dataArr addObject:model];
            }
            //是否有弹窗(首次课99元的弹窗)
            NSDictionary * firstDic = dict[@"first_info"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.TableV.mj_header endRefreshing];
                [self createTableViewBannerView];
                [self.TableV reloadData];

                if ([firstDic[@"isfirst"] boolValue]) {
                    [self showFirstClassAlertViewWith:firstDic[@"first_img"]];
                }
                
            });
        }
    } andfailBlock:^(NSError *error) {
        [HttpRequest showAlert];
    }];
    
}
#pragma mark 初始化数据
- (void)InitData{
    data = [NSArray arrayWithObjects:@"登陆",@"welcome",@"登陆",@"welcome",@"登陆",@"welcome",@"登陆", nil];
    self.dataArr = [[NSMutableArray alloc]init];
    page_index = 0;
}

- (void)createTableViewBannerView{
    bannerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, HEIGHT_6(350))];
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, HEIGHT_6(350))];
    pageFlowView.backgroundColor = THEMECOLOR;
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageScale = 0.85;
    pageFlowView.isOpenAutoScroll = NO;
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 10, SCREEN_W, 8)];
    pageControl.pageIndicatorTintColor = MAKA_JIN_COLOR;
    pageFlowView.pageControl = pageControl;
    [pageFlowView addSubview:pageControl];

    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, HEIGHT_6(350))];
    [pageFlowView reloadData];
    [bottomScrollView addSubview:pageFlowView];
    [bannerView addSubview:bottomScrollView];
    
    self.pageFlowView = pageFlowView;
    
    _TableV.tableHeaderView = bannerView;
}
- (void)CreateUI{
    
    self.dataArr = [NSMutableArray array];
    self.TableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - HEIGHT_6(49)) style:UITableViewStylePlain];
    self.TableV.backgroundColor = THEMECOLOR;
    
    [self.TableV registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:@"DetailCell"];
    self.TableV.dataSource = self;
    self.TableV.delegate = self;
    self.TableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.TableV];
    
    MJRefreshStateHeader * header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    header.stateLabel.textColor = MAKA_JIN_COLOR;
    header.lastUpdatedTimeLabel.textColor = MAKA_JIN_COLOR;
    self.TableV.mj_header = header;
    
    self.ExerciseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH_6(244), HEIGHT_6(40))];
    self.ExerciseBtn.center = CGPointMake(SCREEN_W / 2, SCREEN_H - WIDTH_6(49 / 2.0));
    [self.ExerciseBtn setTitle:@"约     炼" forState:UIControlStateNormal];
    self.ExerciseBtn.titleLabel.font = FONT(@"", 44);
    [self.ExerciseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.ExerciseBtn.layer.cornerRadius = WIDTH_6(20);
    self.ExerciseBtn.layer.masksToBounds = YES;
    self.ExerciseBtn.backgroundColor = COLOR(227, 209, 191);
    [self.ExerciseBtn addTarget:self action:@selector(ExerciseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.ExerciseBtn];
}
- (void)CreatNavigationView{
    
    self.NavigationV = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 64) andtitle:@"立 炼"];
    self.NavigationV.delegate = self;
    [self.view addSubview:self.NavigationV];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 下拉从新加载页面
- (void)headerRefresh{
    [self Reloddata];
}
#pragma mark 约炼按钮点击事件
- (void)ExerciseBtnClick:(UIButton *)ExerciseBtn{
    WeakSelf
    self.ExerciseBtn.userInteractionEnabled = NO;

    if ([HttpRequest judgeWhetherUserLogin]) {
        if (page_index == 0) {
            self.ExerciseBtn.userInteractionEnabled = YES;
            SellViewController * sell = [[SellViewController alloc]init];
            [self.navigationController pushViewController:sell animated:YES];
            
            return;
        }
        HomeModel * model = self.dataArr[page_index];
        NSString * url = [NSString stringWithFormat:@"%@api/?method=gdcourse.course&class_id=%ld&types=1",BASEURL,(long)model.class_id];
        [SVProgressHUD setBackgroundColor:MAKA_JIN_COLOR];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showWithStatus:@"正在加载"];
        
        [HttpRequest GetHttpwithUrl:url parameters:nil andsuccessBlock:^(NSDictionary * _Nonnull responseObject) {
            
            if ([[responseObject objectForKey:@"rc"] integerValue] == 3) {
                
            }else{
                NSDictionary * dict = responseObject[@"data"];
                ClassModel * classmodel = [[ClassModel alloc]init];
                classmodel.class_name = model.course_name;
                classmodel.class_id = model.class_id;
                classmodel.fun_id = model.func_id;
                [classmodel setValuesForKeysWithDictionary:dict];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SugerAlertView sr_showAlertViewWithPlaceOrType:ClassTypeWithClass Delegate:self model:classmodel];
                    [SVProgressHUD dismiss];
                });
            }
        } andfailBlock:^(NSError * _Nonnull error) {
            [HttpRequest showAlert];
            weakSelf.ExerciseBtn.userInteractionEnabled = YES;
        }];
        
    }else{
        self.ExerciseBtn.userInteractionEnabled = YES;

        LoginViewController * login = [[LoginViewController alloc]init];
        login.back = NO;
        [self presentViewController:login animated:YES completion:nil];
    }
    
}
#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(WIDTH_6(250), HEIGHT_6(289));
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
//    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
//    if (subIndex == 0) {
//        SellViewController * sell = [[SellViewController alloc]init];
//        [self.navigationController pushViewController:sell animated:YES];
//    }else{
//        HomeModel * model = self.dataArr[subIndex];
//        ClassViewController * classVC = [[ClassViewController alloc]init];
//        classVC.class_id = [NSString stringWithFormat:@"%ld",model.func_id];
//        [self.navigationController pushViewController:classVC animated:YES];
//    }
    [self ExerciseBtnClick:self.ExerciseBtn];
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.dataArr.count;
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    PGIndexBannerSubiew *bannerV = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerV) {
        bannerV = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, WIDTH_6(250), HEIGHT_6(289))];
        bannerV.layer.cornerRadius = 5;
        bannerV.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
        bannerV.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        bannerV.layer.shadowOpacity = 0.5;//阴影透明度，默认0
        bannerV.layer.shadowRadius = 4;//阴影半径，默认3
//        bannerV.layer.masksToBounds = YES;
        bannerV.mainImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    //在这里下载网络图片
    HomeModel * model = self.dataArr[index];
    [bannerV.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.img]placeholderImage:[UIImage imageNamed:@""]];
    
    return bannerV;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    page_index = pageNumber;
//    if (pageNumber == 0) {
//        self.ExerciseBtn.userInteractionEnabled = NO;
//    }else if ([[Default objectForKey:@"citycode"] integerValue]){
//        self.ExerciseBtn.userInteractionEnabled = YES;
//    }
    [self.TableV reloadData];
    NSLog(@"TestViewController 滚动到了第%ld页",(long)pageNumber);
}
#pragma mark tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArr.count > 0) {
        return 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    DetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    cell.userInteractionEnabled = NO;
    if (self.dataArr.count > 0) {
        HomeModel * model = self.dataArr[page_index];
        if (page_index == 0) {
            [cell createCellWith:model.intro title:model.name];
        }else{
            [cell createCellWith:model.intro title:model.course_name];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArr.count > 0) {
        HomeModel * model = self.dataArr[page_index];
        return model.Cell_Height;
    }
    return SCREEN_H - 64 - WIDTH_6(49);
}

#pragma mark MenuView代理方法
- (void)PushViewControllerWithKey:(NSInteger)key{
    //NSLog(@"第几行%ld",key);
    
    if (![HttpRequest judgeWhetherUserLogin]) {
        switch (key) {
            case 6:
            {
                self.ExerciseBtn.userInteractionEnabled = YES;
            }
                break;
                
            default:
            {
                LoginViewController * login = [[LoginViewController alloc]init];
                login.backBtn.hidden = NO;
                [self presentViewController:login animated:YES completion:nil];
                return;
            }
                break;
        }
    }
    switch (key) {
        case 0://账户
        {
            UserViewController * user = [[UserViewController alloc]init];
            [self.navigationController pushViewController:user animated:YES];
            
        }
            break;
        case 1://课时
        {
            
        }
            break;
        case 2://订单
        {
            OrderViewController * order = [[OrderViewController alloc]init];
            [self.navigationController pushViewController:order animated:YES];
        }
            break;
//        case 3://优惠劵
//        {
//            PreferentialViewController * preferential = [[PreferentialViewController alloc]init];
//            [self.navigationController pushViewController:preferential animated:YES];
//            
//        }
//            break;
        case 3://购买套餐
        {
            SellViewController * sell = [[SellViewController alloc]init];
            [self.navigationController pushViewController:sell animated:YES];

            
        }
            break;
        case 4://健身数据
        {
            BodyDataViewController * bodydata = [[BodyDataViewController alloc]init];
            [self.navigationController pushViewController:bodydata animated:YES];

        }
            break;
        case 5://私人定制
        {
            PersonalViewController * personal = [[PersonalViewController alloc]init];
            [self.navigationController pushViewController:personal animated:YES];
            
        }
            break;

        default://设置
        {
            SettingViewController * settingView = [[SettingViewController alloc]init];
            [self.navigationController pushViewController:settingView animated:YES];
            
        }
            break;
    }
}
//跳转活动页
- (void)PushActivityViewControllerWithUrl:(NSString *)url{
    if ([HttpRequest judgeWhetherUserLogin]) {
        SellViewController * sell = [[SellViewController alloc]init];
        [self.navigationController pushViewController:sell animated:YES];
    }else{
        LoginViewController * login = [[LoginViewController alloc]init];
        login.backBtn.hidden = NO;
        [self presentViewController:login animated:YES completion:nil];

    }
    
//    ActivityViewController * activit = [[ActivityViewController alloc]init];
//    activit.url = url;
//    [self.navigationController pushViewController:activit animated:YES];
}
#pragma mark 自定制导航栏代理
- (void)NavigationViewMenuButtonClick{
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
    }];
}
- (void)NavigationViewRightBtnClick{
//    LocationViewController * location = [[LocationViewController alloc]init];
//    
//    [self.navigationController pushViewController:location animated:YES];
}
#pragma mark 下单代理方法

- (void)OrderWithClassID:(NSString *)class_id rmb:(NSInteger)rmb classname:(NSString *)classname orderid:(NSString *)orderid{
    self.ExerciseBtn.userInteractionEnabled = YES;
    PayViewController * pay = [[PayViewController alloc]init];
    pay.class_id = [NSString stringWithFormat:@"%@",class_id];
    pay.ispackage = NO;
    pay.name = classname;
    pay.price = rmb;
    pay.order_id = orderid;
    [self.navigationController pushViewController:pay animated:YES];
}

- (void)SRAlertDismiss{
    self.ExerciseBtn.userInteractionEnabled = YES;
}
- (void)alertViewDidSelectAction:(AlertViewActionType)actionType{
    if (actionType == AlertViewActionTypeLeft) {
        
    }
}
- (void)loactionView:(NSNotification *)info{
    [self Reloddata];
    NSString * location = [info.userInfo objectForKey:@"citycode"];
    if ([location integerValue]) {
        [self.ExerciseBtn setTitle:@"约     炼" forState:UIControlStateNormal];
    }else{
        [self.ExerciseBtn setTitle:@"所在城市未覆盖" forState:UIControlStateNormal];
        self.ExerciseBtn.userInteractionEnabled = NO;
    }
}
- (void)showFirstClassAlertViewWith:(NSString *)url{
    if (!first) {
        first = YES;
        [ADAlertView showAlertViewWithurl:url];
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"location" object:nil];
}

- (void)showAlertWithTitle:(NSString *)title {
    hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    //    hud.activityIndicatorColor = [UIColor blueColor];
    hud.color = [UIColor blackColor];
    hud.labelText = title;
    hud.labelFont = [UIFont boldSystemFontOfSize:17];
    hud.dimBackground = YES;
    [hud setColor:MAKA_JIN_COLOR];
    hud.labelColor = [UIColor blackColor];
    hud.minSize = CGSizeMake(SCREEN_W * 0.5, HEIGHT_6(90));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
