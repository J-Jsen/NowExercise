//
//  HomeViewController.m
//  NowExercise
//
//  Created by mac on 17/1/19.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "HomeViewController.h"
#import "NavigationView.h"

#import "BannerCell.h"
#import "DetailCell.h"

#import "UserViewController.h"
#import "OrderViewController.h"
#import "PreferentialViewController.h"
#import "BodyDataViewController.h"
#import "SellViewController.h"
#import "PersonalViewController.h"
#import "SettingViewController.h"

#import "ClassViewController.h"

#import "AppointmentView.h"
@interface HomeViewController ()<NavigationViewDelegate,UITableViewDelegate,UITableViewDataSource,SRAlertViewDelegate,RPRingedPagesDelegate,RPRingedPagesDataSource>
{
    BOOL persenMessage;
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


@property (nonatomic , strong) RPRingedPages * pages;



@end

@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.alpha = 0;
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
//    [UIApplication sharedApplication].statusBarHidden = NO;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];

    //背景色
    self.view.backgroundColor = THEMECOLOR;
    [self InitData];
    [self CreatNavigationView];
    [self CreateUI];
    if (!persenMessage) {
        [self loadPersent];
    }
    [self Reloddata];
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)loadPersent{
    NSString * url = [NSString stringWithFormat:@"%@api/?method=index.index",TBASEURL];
    
    [HttpRequest GetHttpwithUrl:url parameters:nil andsuccessBlock:^(NSDictionary * responseObject) {
        if ([[responseObject objectForKey:@"rc"] integerValue] == 3) {
            
        }
        
    } andfailBlock:^(NSError *error) {
        [HttpRequest showAlert];
    }];
//
    
}

#pragma mark 初始化数据
- (void)InitData{
    self.dataArr = [[NSMutableArray alloc]init];
}
#pragma mark 加载数据
- (void)Reloddata{
//    [SVProgressHUD showWithStatus:@"正在加载"];
//    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    
    
    self.dataArr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",nil];
    
    [self createTableViewBannerView];
    [self.TableV reloadData];
    [self.pages reloadData];
}
- (void)createTableViewBannerView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, HEIGHT_6(400))];
    
    self.pages = [[RPRingedPages alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, HEIGHT_6(400))];
    _pages.carousel.pageScale = 0.8;
    self.pages.carousel.mainPageSize = CGSizeMake(WIDTH_6(280), 320);
    _pages.delegate = self;
    _pages.dataSource = self;
    [view addSubview:_pages];
    _TableV.tableHeaderView = view;
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
    
    self.ExerciseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH_6(244), HEIGHT_6(40))];
    self.ExerciseBtn.center = CGPointMake(self.view.center.x, SCREEN_H - WIDTH_6(49 / 2.0));
    
    [self.ExerciseBtn setTitle:@"约    炼" forState:UIControlStateNormal];
    self.ExerciseBtn.titleLabel.font = FONT(@"", 44);
    
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
#pragma mark 约炼按钮点击事件
- (void)ExerciseBtnClick:(UIButton *)ExerciseBtn{
    [SRAlertView sr_showAlertViewWithPlaceOrType:ClassTypeClass Delegate:self];
}

#pragma mark pagesDelegate(tableview头视图代理)
- (NSInteger)numberOfItemsInRingedPages:(RPRingedPages *)pages {
    return 4;
    return self.dataArr.count;
}
- (UIView *)ringedPages:(RPRingedPages *)pages viewForItemAtIndex:(NSInteger)index {
    
    UIImageView *imageV = (UIImageView *)[pages dequeueReusablePage];
    if (![imageV isKindOfClass:[UIImageView class]]) {
        imageV = [UIImageView new];
        imageV.image = [UIImage imageNamed:@"2-1.jpg"];
        imageV.layer.backgroundColor = [UIColor redColor].CGColor;
        imageV.layer.cornerRadius = 5;
        imageV.layer.masksToBounds = YES;
        
        UIButton * button = [[UIButton alloc]init];
        button.center = CGPointMake(WIDTH_6(135), 190);
        
        button.layer.cornerRadius = 25;
        button.layer.masksToBounds = YES;
        button.layer.borderColor = COLOR(227, 209, 191).CGColor;
        button.layer.borderWidth = 2;
        [imageV addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
            make.width.and.height.mas_equalTo(50);
        }];
    }
    return imageV;
}
#pragma mark 代理方法
- (void)didSelectedCurrentPageInPages:(RPRingedPages *)pages {
    NSLog(@"pages selected, the current index is %zd", pages.currentIndex);
    ClassViewController * classVC = [[ClassViewController alloc]init];
    [self.navigationController pushViewController:classVC animated:YES];
    
}
- (void)pages:(RPRingedPages *)pages didScrollToIndex:(NSInteger)index {
    NSLog(@"pages scrolled to index: %zd", index);
    DetailCell * cell = [_TableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [cell createCellWith:@"变换"];
}

#pragma mark tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    DetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    cell.userInteractionEnabled = NO;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCREEN_H - 64 - WIDTH_6(49);
}

#pragma mark MenuView代理方法
- (void)PushViewControllerWithKey:(NSInteger)key{
    //NSLog(@"第几行%ld",key);
    
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
        case 3://优惠劵
        {
            PreferentialViewController * preferential = [[PreferentialViewController alloc]init];
            [self.navigationController pushViewController:preferential animated:YES];
            
        }
            break;
        case 4://购买套餐
        {
            SellViewController * sell = [[SellViewController alloc]init];
            [self.navigationController pushViewController:sell animated:YES];

            
        }
            break;
        case 5://健身数据
        {
            BodyDataViewController * bodydata = [[BodyDataViewController alloc]init];
            [self.navigationController pushViewController:bodydata animated:YES];

        }
            break;
        case 6://私人定制
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
- (void)NavigationViewMenuButtonClick{
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        
    }];
}

#pragma mark 下单代理方法
- (void)orderWithName:(NSString *)name tel:(NSString *)tel date:(NSString *)date time:(NSString *)time place:(NSString *)place classname:(NSString *)classname{
    
    
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
