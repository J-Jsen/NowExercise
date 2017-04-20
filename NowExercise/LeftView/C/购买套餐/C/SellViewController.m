//
//  SellViewController.m
//  NowExercise
//
//  Created by mac on 17/1/21.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "SellViewController.h"

#import "SellCell.h"

#define SELL_CELL @"SELLCELL"


@interface SellViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * dataArr;
    UITableView * tableV;
}
@end

@implementation SellViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createNavigationView];
}
//自定制导航栏
- (void)createNavigationView{
    self.navigationController.navigationBarHidden = NO;
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];

    //关闭导航栏毛玻璃效果
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏颜色
    self.navigationController.navigationBar.barTintColor = NAV_COLOR;
    //导航栏标题
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(20)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"购买套餐";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = THEMECOLOR;
    [self initData];
    [self createUI];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)initData{
    dataArr = [[NSMutableArray alloc]initWithObjects:@"特想套餐",@"白银套餐",@"黄金套餐",@"铂金套餐",@"钻石套餐" ,nil];
    
}
- (void)createUI{
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64) style:UITableViewStylePlain];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.backgroundColor = THEMECOLOR;
    tableV.delegate = self;
    tableV.dataSource =self;
    tableV.bounces = NO;
    [tableV registerClass:[SellCell class] forCellReuseIdentifier:SELL_CELL];
    [self.view addSubview:tableV];
    [self tableViewAddTableHeaderView];
    
    
}
- (void)tableViewAddTableHeaderView{
    UILabel * headerView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, HEIGHT_6(50))];
    headerView.backgroundColor = THEMECOLOR;
    headerView.text = @"    ＊购买黄金套餐及以上享私人定制服务";
    headerView.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
    headerView.textColor = MAKA_JIN_COLOR;
    tableV.tableHeaderView = headerView;
}

#pragma mark tableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SellCell * cell = [[SellCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SELL_CELL];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
#pragma mark tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_6(100);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"hadhjsakhd");
//    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeAnnularDeterminate;
//    hud.activityIndicatorColor = [UIColor blueColor];
//    hud.color = [UIColor blackColor];
//    hud.labelText = @"cehngggg";
//    hud.dimBackground = YES;
//    [hud setColor:MAKA_JIN_COLOR];
//    hud.labelColor = [UIColor blackColor];
//    hud.minSize = CGSizeMake(SCREEN_W * 0.5, HEIGHT_6(90));
//    [hud hide:YES afterDelay:2];
    [SVProgressHUD setBackgroundColor:MAKA_JIN_COLOR];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD showSuccessWithStatus:@"正在加载"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//    [SVProgressHUD showWithStatus:@"正在加载"];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlertWithStr:(NSString *)title{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W * 0.4, HEIGHT_6(80))];
    label.backgroundColor = [UIColor yellowColor];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    [SRAlertView suger_showAlertWithView:label];
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
