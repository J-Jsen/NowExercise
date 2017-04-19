//
//  PreferentialViewController.m
//  NowExercise
//
//  Created by mac on 17/1/21.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "PreferentialViewController.h"
#import "PreferentialCell.h"
@interface PreferentialViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * tableV;
    NSMutableArray * dataArr;
    
    //cell 标识
    NSString * cellID;
    
    
}
@property (nonatomic , copy) NSString * url;

@end

@implementation PreferentialViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createNavigationView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataInit];
    [self createUI];
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)dataInit{
    dataArr = [[NSMutableArray alloc]initWithObjects:@"1",@"2", nil];
    cellID = @"PREFERENTIAL";
}
- (void)createUI{
    self.view.backgroundColor = THEMECOLOR;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    tableV.backgroundColor = THEMECOLOR;

    tableV.separatorColor = [UIColor clearColor];
    [tableV registerClass:[PreferentialCell class] forCellReuseIdentifier:cellID];
    [tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tableV.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    tableV.delegate = self;
    tableV.dataSource = self;
    [self.view addSubview:tableV];
    
}
/**
 重写url set方法

 @return url
 */
- (NSString *)url{
    NSString * ur = [NSString stringWithFormat:@"%@",BASEURL];
    return ur;
}
/**
 导航栏订制
 */
- (void)createNavigationView{
    self.navigationController.navigationBarHidden = NO;
    //导航栏左按钮图片
    [self.navigationItem.leftBarButtonItem setImage:[UIImage imageNamed:@""]];
    
    //导航栏标题
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(20)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"优惠券";
    self.navigationItem.titleView = titleLabel;
    
}

#pragma mark tableViewDataSourceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (dataArr.count > 0) {
        return dataArr.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!kArrayIsEmpty(dataArr)) {
        PreferentialCell * cell = [[PreferentialCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        return cell;
    }
    
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}
#pragma mark tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return HEIGHT_6(90);
    
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
