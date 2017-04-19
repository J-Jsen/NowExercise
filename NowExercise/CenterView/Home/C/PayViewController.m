//
//  PayViewController.m
//  NowExercise
//
//  Created by mac on 17/3/27.
//  Copyright © 2017年 Guodong. All rights reserved.
//
//支付


#import "PayViewController.h"

#import "PayCell.h"

#define PAY_CELL @"PAYCELL"

@interface PayViewController ()<UITableViewDelegate , UITableViewDataSource>
{
    UITableView * tableV;
    UIButton * payBtn;
    
    NSMutableArray * dataArr;
    PayCell * lastCell;
    
    NSString * payTypeString;
}

@end

@implementation PayViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self createNavigationView];
}
- (void)createNavigationView{
    self.navigationController.navigationBarHidden = NO;
    //关闭导航栏毛玻璃效果
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏颜色
    self.navigationController.navigationBar.barTintColor = COLOR(31, 31, 31);
    //导航栏标题
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(20)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"我的支付";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    /*
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*cmps= [calendar components:NSCalendarUnitSecond fromDate:userLastOpenDate toDate:currentDate options:NSCalendarMatchStrictly];
     */
    [UIApplication sharedApplication].statusBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = THEMECOLOR;
    [self initData];
    [self createUI];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)initData{
    dataArr = [[NSMutableArray alloc]initWithObjects:@"ali_pay",@"wechat_pay",@"yinlian_pay", nil];
}
- (void)createUI{
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - HEIGHT_6(45) -64) style:UITableViewStylePlain];
    tableV.backgroundColor = THEMECOLOR;
    tableV.delegate = self;
    tableV.dataSource = self;
    [tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"defultcell"];
    [tableV registerClass:[PayCell class] forCellReuseIdentifier:PAY_CELL];
    tableV.separatorInset = UIEdgeInsetsMake(0, 45, 0, 0);
    tableV.separatorColor = MAKA_JIN_COLOR;
    tableV.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];
    tableV.tableFooterView.backgroundColor = MAKA_JIN_COLOR;

    
    [self.view addSubview:tableV];
    //确认支付按钮
    payBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_H - HEIGHT_6(50) - 64, SCREEN_W, HEIGHT_6(50))];
    
    payBtn.backgroundColor = MAKA_JIN_COLOR;
    payBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [payBtn setTintColor:[UIColor blackColor]];
    [payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [payBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [payBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [self.view addSubview:payBtn];
    [self createTableViewHeaderView];

    PayCell * cell = [tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    lastCell = cell;
    [tableV deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES];
    _paytype = PayTypeWithAliPay;
    
}
- (void)createTableViewHeaderView{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, HEIGHT_6(160))];
    
    headerView.backgroundColor = THEMECOLOR;
    UILabel * headerlabel = [[UILabel alloc]init];
    headerlabel.textColor = MAKA_JIN_COLOR;
    headerlabel.font = [UIFont systemFontOfSize:HEIGHT_6(14)];
    headerlabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:headerlabel];
    
    UILabel * timeLabel = [[UILabel alloc]init];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(24)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:timeLabel];
    
    UILabel * line = [[UILabel alloc]init];
    line.backgroundColor = MAKA_JIN_COLOR;
    line.alpha = 0.5;
    [headerView addSubview:line];
    
    UILabel * classLabel = [[UILabel alloc]init];
    classLabel.textColor = MAKA_JIN_COLOR;
    classLabel.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
    [headerView addSubview:classLabel];
    
    UILabel * preferentialLabel = [[UILabel alloc]init];
    preferentialLabel.font = [UIFont systemFontOfSize:HEIGHT_6(14)];
    preferentialLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:preferentialLabel];
    
    UILabel * valueLabel = [[UILabel alloc]init];
    valueLabel.textColor = MAKA_JIN_COLOR;
    valueLabel.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
    valueLabel.textAlignment = NSTextAlignmentRight;
    [headerView addSubview:valueLabel];
    
    UIButton * chooseBtn = [[UIButton alloc]init];
    [chooseBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:chooseBtn];
    
    headerlabel.text = @"支付剩余时间";
    timeLabel.text = @"15:00";
    classLabel.text = @"课程名称";
    valueLabel.text = @"¥499";
    preferentialLabel.text = @"查看优惠券";
    
    if (!self.ispay_money) {
        preferentialLabel.alpha = 0.4;
        chooseBtn.alpha = 0.4;
        chooseBtn.userInteractionEnabled = NO;
    }
    
    [headerlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(HEIGHT_6(20));
        make.width.mas_equalTo(WIDTH_6(100));
        make.height.mas_equalTo(HEIGHT_6(15));
        make.centerX.offset(0);
    }];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerlabel.mas_bottom).offset(HEIGHT_6(10));
        make.width.mas_equalTo(WIDTH_6(100));
        make.height.mas_equalTo(HEIGHT_6(25));
        make.centerX.offset(0);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_W - 20);
        make.top.mas_equalTo(timeLabel.mas_bottom).offset(20);
        make.height.mas_equalTo(1);
        make.centerX.offset(0);
    }];
    
    [classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.mas_equalTo(line.mas_bottom).offset(10);
        make.width.mas_equalTo(WIDTH_6(100));
        make.height.mas_equalTo(HEIGHT_6(18));
    }];
    
    [valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.mas_equalTo(line.mas_bottom).offset(10);
        make.width.mas_equalTo(WIDTH_6(100));
        make.height.mas_equalTo(HEIGHT_6(18));
        
    }];
    
    [preferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.width.mas_equalTo(WIDTH_6(100));
        make.height.mas_equalTo(HEIGHT_6(16));
        make.top.mas_equalTo(classLabel.mas_bottom).offset(10);
    }];
    
    [chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.mas_equalTo(valueLabel.mas_bottom).offset(10);
        make.width.and.height.mas_equalTo(HEIGHT_6(17));
    }];
    tableV.tableHeaderView = headerView;
}

#pragma mark tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayCell * cell = [[PayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PAY_CELL];
    [cell createCellWithTitleImage:[UIImage imageNamed:@""]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (!_ispay_money) {
        cell.userInteractionEnabled = NO;
    }
    if (indexPath.row == 0) {
        [cell selectCell];
        lastCell = cell;
    }
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * label = [[UILabel alloc]init];
    label.backgroundColor = COLOR(142, 142, 142);
    label.text = @"    选择支付方式";
    label.font = [UIFont systemFontOfSize:HEIGHT_6(14)];
    label.textColor = [UIColor whiteColor];
    
    return label;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_6(50);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取出选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            payTypeString = @"支付宝";
        }
            break;
        case 1:
        {
            payTypeString = @"微信";
        }
            break;
        case 2:
        {
            payTypeString = @"银联";
        }
            break;
            
        default:
            break;
    }
    [lastCell disselectCell];
    PayCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell selectCell];
    lastCell = cell;
    
}
#pragma mark 优惠券选择
- (void)chooseBtnClick:(UIButton *)chooseBtn{
    
    
}
#pragma mark 确认支付
- (void)payBtnClick:(UIButton *)payBtn{
    //调起支付
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.payback();
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
