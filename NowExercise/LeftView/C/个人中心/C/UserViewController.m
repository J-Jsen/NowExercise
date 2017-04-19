//
//  UserViewController.m
//  NowExercise
//
//  Created by mac on 17/1/21.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "UserViewController.h"

#import "UserTableViewCell.h"

#import "IconViewController.h"

#define CellID    @" USERCELL"

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * tableV;
    NSMutableArray * dataArr;
    
}
@end

@implementation UserViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationView];
    [self createUI];
    [self dataInit];
    
    self.view.backgroundColor = [UIColor redColor];
    
    // Do any additional setup after loading the view from its nib.
}
//自定制导航栏
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
    titleLabel.text = @"个人中心";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
}
//UI布局
- (void)createUI{
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.backgroundColor = THEMECOLOR;
    
    [tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableV registerClass:[UserTableViewCell class] forCellReuseIdentifier:CellID];
    [self.view addSubview:tableV];
    //去掉多余的分割线
    tableV.tableFooterView = [[UIView alloc]init];
    
    
}
- (void)dataInit{
    dataArr = [[NSMutableArray alloc]initWithObjects:@"头像",@"用户名",@"性别", nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (dataArr.count) {
        return dataArr.count;
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArr.count) {
        UserTableViewCell * cell = [[UserTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        [cell createCellWithCellType:CellImageWithDetail];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            return WIDTH_6(60);
            break;
            
        default:
            return WIDTH_6(45);
            break;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 10)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}
#pragma mark --tableViewdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            IconViewController * iconVC = [[IconViewController alloc]init];
            [self.navigationController pushViewController:iconVC animated:YES];
            
        }
            break;
            
        default:
            break;
    }
    
    
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
