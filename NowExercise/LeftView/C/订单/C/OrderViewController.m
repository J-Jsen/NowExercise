//
//  OrderViewController.m
//  NowExercise
//
//  Created by mac on 17/1/21.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "OrderViewController.h"
#import "EvaluateViewController.h"
#import "OrderCell.h"
#import "PackageCell.h"
#import "OrderModel.h"
#define ORDER_CELL @"ORDERCELL"
#define PACKAGECELL @"PACKAGECELL"
@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,OrderDelegate,EvaluateViewControllerDelegate>
{
    UITableView * tableV;
    NSMutableArray * dataArr;
    NSInteger page;
}
@end

@implementation OrderViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    //去掉滑动打开侧边栏
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self createNavigationView];
}
//自定制导航栏
- (void)createNavigationView{
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    //关闭导航栏毛玻璃效果
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏颜色
    self.navigationController.navigationBar.barTintColor = NAV_COLOR;
    //导航栏标题
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(20)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"我的订单";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [tableV.mj_header beginRefreshing];
    // Do any additional setup after loading the view from its nib.
}
- (void)initData{
    dataArr = [[NSMutableArray alloc]init];
    page = 0;
    
}
- (void)loadData{
    NSString * url = [NSString stringWithFormat:@"%@api/?method=gdcourse.order&status=0&page=%ld",BASEURL,(long)page];
    if (page == 0) {
        [dataArr removeAllObjects];
    }
    [HttpRequest GetHttpwithUrl:url parameters:nil andsuccessBlock:^(NSDictionary *responseObject) {
        if ([[responseObject objectForKey:@"rc"] integerValue] == 0) {
            NSDictionary * dict = responseObject[@"data"];
            NSArray * arr = dict[@"order_info"];
            for (NSDictionary * dic in arr) {
                OrderModel * model = [[OrderModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                if ([dic[@"gd_status"] integerValue] != 6) {
                    [dataArr addObject:model];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV.mj_header endRefreshing];
                [tableV.mj_footer endRefreshing];
                [tableV reloadData];
            });
            if (arr.count == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter forwardingTargetForSelector:nil];
                    [footer setTitle:@"到底啦..." forState:MJRefreshStateIdle];
                    tableV.mj_footer = footer;
                });
            }
        }else{
            NSLog(@"身份验证已过期");
        }
    } andfailBlock:^(NSError *error) {
        [HttpRequest showAlertWithTitle:@"服务器开小差了..."];
        
    }];
}
#pragma mark createUI
- (void)createUI{
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64)];
    tableV.separatorColor = [UIColor clearColor];
    tableV.backgroundColor = THEMECOLOR;
    tableV.delegate = self;
    tableV.dataSource = self;
    [tableV registerClass:[OrderCell class] forCellReuseIdentifier:ORDER_CELL];
    tableV.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:tableV];

    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerLoadData)];
    tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerLoadData)];
}
- (void)headerLoadData{
    page = 0;
//    [tableV.mj_header beginRefreshing];
    [self loadData];
}
- (void)footerLoadData{
    page ++;
  //  [tableV.mj_footer beginRefreshing];
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --tableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (dataArr.count > 0) {
        OrderModel * model = dataArr[indexPath.row];
        if ([model.type isEqualToString:@"package"]) {
            //购买套餐的订单
            PackageCell * cell = [[PackageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PACKAGECELL];
            cell.userInteractionEnabled = NO;
            [cell createCellWithModel:model];
            return cell;
        }else{
            OrderCell * cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ORDER_CELL];
            [cell createCellWithModel:model];
            cell.delegate = self;
            cell.index_row = indexPath.row;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}
#pragma mark tableviewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArr.count > 0) {
        OrderModel * model = dataArr[indexPath.row];
        if ([model.type isEqualToString:@"package"]) {
            return HEIGHT_6(120);
        }else{
            return HEIGHT_6(180);
        }
    }
    return 0;
}
- (void)deleteOrderWithIndexRow:(NSInteger)index_row{
    if (dataArr.count - 1 >= index_row) {
        [SRAlertView sr_showAlertViewWithTitle:@"提示" message:@"您确定要删除订单" leftActionTitle:@"确定" rightActionTitle:@"取消" animationStyle:AlertViewAnimationZoom selectAction:^(AlertViewActionType actionType) {
            if (actionType == AlertViewActionTypeLeft) {
                
                OrderModel * model = dataArr[index_row];
                NSString * url = [NSString stringWithFormat:@"%@api/?method=gdcourse.delete_order&order_id=%@",BASEURL,model.order_id];
                [HttpRequest GetHttpwithUrl:url parameters:nil andsuccessBlock:^(NSDictionary *responseObject) {
                    if ([[responseObject objectForKey:@"rc"] integerValue] == 0) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"删除成功");
                            [HttpRequest showAlertWithTitle:@"删除成功"];
                            [dataArr removeObjectAtIndex:index_row];
                            [tableV reloadData];
                        });
                    }
                } andfailBlock:^(NSError *error) {
                    [HttpRequest showAlertWithTitle:@"服务器开小差了..."];
                }];
            }
        }];
    }
}
- (void)evaluateOrderWithIndexRow:(NSInteger)index_row{
    OrderModel * model = dataArr[index_row];
    EvaluateViewController * evaluate = [[EvaluateViewController alloc]init];
    evaluate.model = model;
    evaluate.order_id = model.order_id;
    evaluate.delegate = self;
    [self.navigationController pushViewController:evaluate animated:YES];
    
//    OrderModel * model = dataArr[index_row];
//    model.gd_status = 4;
//    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:index_row];
//    [tableV reloadSections:indexSet withRowAnimation:UITableViewRowAnimationLeft];

}
- (void)EvaluateSuceess:(NSUInteger)index{
        OrderModel * model = dataArr[index];
        model.gd_status = 4;
    model.order_status = @"已完成";
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:index];
        [tableV reloadSections:indexSet withRowAnimation:UITableViewRowAnimationLeft];

}
- (void)dealloc{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
