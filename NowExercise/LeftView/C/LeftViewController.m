//
//  LeftViewController.m
//  NowExercise
//
//  Created by mac on 17/1/19.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftCell_1.h"
#import "LeftCell_2.h"

#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView * tableV;
    NSMutableArray * dataArr;
    NSMutableArray * titleImageArr;
    
    NSString * url;
    
    NSString * CELL_1;
    NSString * CELL_2;
    //最下方banner按钮
    UIButton * bannerBtn;
    //tableView高度
    CGFloat MenuHeight;
    
}


@end

@implementation LeftViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self Datainit];
    
    [self setUrl];
    [self createUI];

    //[self reloaddata];

    // Do any additional setup after loading the view from its nib.
}
- (void)Datainit{
    MenuHeight = 325;
    CELL_1 = @"CELL_1";
    CELL_2 = @"CELL_2";
    dataArr = [[NSMutableArray alloc]initWithObjects:@"个人中心",@"课时",@"订单",@"优惠劵:",@"购买套餐",@"健身数据",@"私人定制",@"设置", nil];
    titleImageArr = [[NSMutableArray alloc]initWithObjects:@"个人中心.png",@"课时.png",@"订单.png",@"优惠券.png",@"购买套餐.png",@"健身数据.png",@"私人定制.png",@"设置.png", nil];
    
}
- (void)setUrl{
    url = [NSString stringWithFormat:@"%@api/?method=user.personal_center",BASEURL];
}

#pragma mark 加载数据
- (void)reloaddata{

    [HttpRequest GetHttpwithUrl:url parameters:nil andsuccessBlock:^(id responseObject) {
        NSMutableDictionary * datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (datadic && [datadic[@"rc"] integerValue] == 0) {
         
            [tableV reloadData];
            
        }else{
            NSLog(@"加载失败");
        }
    } andfailBlock:^(NSError *error) {
        NSLog(@"服务器异常:%@",error.localizedDescription);
    }];
}

#pragma mark UI
- (void)createUI{
    self.view.backgroundColor = THEMECOLOR;
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT_6(70), WIDTH_6(MENU_WIDTH), HEIGHT_6(MenuHeight)) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.separatorColor = [UIColor clearColor];
    tableV.bounces = NO;
    tableV.backgroundColor = THEMECOLOR;
    [tableV registerClass:[LeftCell_1 class] forCellReuseIdentifier:CELL_1];
    [tableV registerClass:[LeftCell_2 class] forCellReuseIdentifier:CELL_2];
    
    [self.view addSubview:tableV];
    
    bannerBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, SCREEN_H - 10 - HEIGHT_6(205), MENU_WIDTH - 20, HEIGHT_6(205))];
    
    bannerBtn.backgroundColor = [UIColor orangeColor];
    [bannerBtn addTarget:self action:@selector(bannerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bannerBtn];
    
    
    
}
#pragma mark --tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (dataArr.count > 0) {
        switch (indexPath.row) {
            case 0://用户
            {
                LeftCell_2 * cell = [[LeftCell_2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_2];
                [cell crateCellWithImageName:titleImageArr[indexPath.row] andtitleName:dataArr[indexPath.row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                //数据
                return cell;
                
            }
                break;
            case 1:
            {
                LeftCell_2 * cell = [[LeftCell_2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_2];
                [cell crateCellWithImageName:titleImageArr[indexPath.row] andtitleName:dataArr[indexPath.row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                return cell;

            }
                break;
            case 3:
            {
                LeftCell_2 * cell = [[LeftCell_2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_2];
                [cell crateCellWithImageName:titleImageArr[indexPath.row] andtitleName:dataArr[indexPath.row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                return cell;

            }
                break;

            default:
            {
                LeftCell_1 * cell = [[LeftCell_1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_1];
                [cell crateCellWithImageName:titleImageArr[indexPath.row] andtitleName:dataArr[indexPath.row]];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                return cell;
            }
                break;
        }
    }
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"defultcell"];
    
    return cell;
}

#pragma mark --tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(PushViewControllerWithKey:)]) {
        [self.delegate PushViewControllerWithKey:indexPath.row];
   }

    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_6(MenuHeight)/8.0;
}

#pragma mark bannerBtnClick
- (void)bannerBtnClick:(UIButton *)bannerBtn{
    if ([self.delegate respondsToSelector:@selector(PushViewControllerWithKey:)]) {
        
        [self.delegate PushViewControllerWithKey:100];
    }
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
