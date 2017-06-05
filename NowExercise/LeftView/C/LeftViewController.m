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
#import "LeftModel.h"
#import "PGIndexBannerSubiew.h"

#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"

#import <UIButton+WebCache.h>

@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>
{
    
    UITableView * tableV;
    NSMutableArray * dataArr;
    NSMutableArray * titleImageArr;
    
    NSString * url;
    
    NSString * CELL_1;
    NSString * CELL_2;
    //最下方banner按钮
//    UIButton * bannerBtn;
    //tableView高度
    CGFloat MenuHeight;
    
    NSInteger  package;
    
    UIView * bannerView;
    NSMutableArray * bannerArr;
    BOOL first;
}
@property (nonatomic , strong) NewPagedFlowView * pageFlowView;


@end

@implementation LeftViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    first = YES;

    if (first) {
        [self reloaddata];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self Datainit];
    
    [self setUrl];
    [self createUI];
    if (!first) {
        [self reloaddata];
    }

    // Do any additional setup after loading the view from its nib.
}
- (void)Datainit{
    
    MenuHeight = 325;
    CELL_1 = @"CELL_1";
    CELL_2 = @"CELL_2";
    package = 0;
    bannerArr = [[NSMutableArray alloc]init];
    dataArr = [[NSMutableArray alloc]initWithObjects:@"个人中心",@"课时",@"订单",@"购买套餐",@"健身数据",@"私人定制",@"设置", nil];
    titleImageArr = [[NSMutableArray alloc]initWithObjects:@"个人中心.png",@"课时.png",@"订单.png",@"购买套餐.png",@"健身数据.png",@"私人定制.png",@"设置.png", nil];
    
}
- (void)setUrl{
    url = [NSString stringWithFormat:@"%@api/?method=index.menu",BASEURL];
}

#pragma mark 加载数据
- (void)reloaddata{
    [bannerArr removeAllObjects];
    [HttpRequest GetHttpwithUrl:url parameters:nil andsuccessBlock:^(NSDictionary * responseObject) {
        NSDictionary * dict = responseObject[@"data"];
        package = [dict[@"package_balance"] integerValue];
//        NSArray * carousel = dict[@"carousel"];
//        for (NSDictionary * dic in carousel) {
//            if ([dic[@"type"] integerValue] == 2) {
//                LeftModel * model = [[LeftModel alloc]init];
//                [model setValuesForKeysWithDictionary:dic];
                [bannerArr addObject:dict[@"img_url"]];
        [bannerArr addObject:dict[@"img_url"]];

//            }
//        }
        NSLog(@"汉堡栏数据:*****************\n%@\n***************",responseObject);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.pageFlowView reloadData];
            [tableV reloadData];
            
        });
    } andfailBlock:^(NSError *error) {
        NSLog(@"服务器异常:%@",error.localizedDescription);
        [HttpRequest showAlert];
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
    
    [self createBannerView];
    
//    bannerBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, SCREEN_H - 10 - HEIGHT_6(205), MENU_WIDTH - 20, HEIGHT_6(205))];
//    
//    bannerBtn.backgroundColor = [UIColor orangeColor];
//    [bannerBtn addTarget:self action:@selector(bannerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:bannerBtn];
}
- (void)createBannerView{
    bannerView = [[UIView alloc]initWithFrame:CGRectMake(10, SCREEN_H - 10 - HEIGHT_6(135), MENU_WIDTH - 20, HEIGHT_6(135))];
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, MENU_WIDTH - 20, HEIGHT_6(135))];
    pageFlowView.backgroundColor = THEMECOLOR;
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageScale = 1;
    pageFlowView.isOpenAutoScroll = NO;
    //是否轮播
//    pageFlowView.isCarousel = NO;
    //初始化pageControl
//    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 10, SCREEN_W, 8)];
//    pageControl.pageIndicatorTintColor = MAKA_JIN_COLOR;
//    pageFlowView.pageControl = pageControl;
//    [pageFlowView addSubview:pageControl];
    
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MENU_WIDTH - 20, HEIGHT_6(135))];
    [pageFlowView reloadData];
    [bottomScrollView addSubview:pageFlowView];
    [bannerView addSubview:bottomScrollView];
    
    
    self.pageFlowView = pageFlowView;
    [self.view addSubview:bannerView];

}
#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(MENU_WIDTH - 20, HEIGHT_6(135));
}
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        
    }];
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
//    LeftModel * model = bannerArr[subIndex];
    if ([self.delegate respondsToSelector:@selector(PushActivityViewControllerWithUrl:)]) {
        [self.delegate PushActivityViewControllerWithUrl:@"1"];
    }
    //    if (subIndex == 0) {
    //        SellViewController * sell = [[SellViewController alloc]init];
    //        [self.navigationController pushViewController:sell animated:YES];
    //    }else{
    //        HomeModel * model = self.dataArr[subIndex];
    //        ClassViewController * classVC = [[ClassViewController alloc]init];
    //        classVC.class_id = [NSString stringWithFormat:@"%ld",model.func_id];
    //        [self.navigationController pushViewController:classVC animated:YES];
    //    }
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
//    return ;
    return bannerArr.count;
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    PGIndexBannerSubiew *bannerV = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerV) {
        bannerV = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, MENU_WIDTH - 20, HEIGHT_6(135))];
//        bannerV.layer.cornerRadius = 5;
//        bannerV.layer.masksToBounds = YES;
        bannerV.mainImageView.contentMode = UIViewContentModeScaleAspectFit;
        bannerV.mainImageView.layer.masksToBounds = YES;
    }
//    bannerV.backgroundColor = [UIColor redColor];
    //在这里下载网络图片
//    LeftModel * model = bannerArr[index];
    NSString * imageurl = bannerArr[index];
    [bannerV.mainImageView sd_setImageWithURL:[NSURL URLWithString:imageurl]placeholderImage:[UIImage imageNamed:@"引导页1.png"]];
    
    return bannerV;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
//    page_index = pageNumber;
//    if (pageNumber == 0) {
//        self.ExerciseBtn.userInteractionEnabled = NO;
//    }else if ([[Default objectForKey:@"citycode"] integerValue]){
//        self.ExerciseBtn.userInteractionEnabled = YES;
//    }
//    [self.TableV reloadData];
    NSLog(@"TestViewController 滚动到了第%ld页",(long)pageNumber);
}

#pragma mark --tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (dataArr.count > 0) {
        switch (indexPath.row) {
            case 1:
            {
                LeftCell_2 * cell = [[LeftCell_2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_2];
                [cell crateCellWithImageName:titleImageArr[indexPath.row] andtitleName:dataArr[indexPath.row]];
                [cell packagenumber:[NSString stringWithFormat:@"%ld",(long)package]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.userInteractionEnabled = NO;
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
