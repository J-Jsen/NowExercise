//
//  BodyDataViewController.m
//  NowExercise
//
//  Created by mac on 17/1/21.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "BodyDataViewController.h"
#import "BodyTableViewCell.h"

#import "LoginViewController.h"

#import "PhotoScrollerViewController.h"
#define BODY_CELL @"BODYCELL"

@interface BodyDataViewController ()<UITableViewDelegate, UITableViewDataSource,BodyTableViewCellDelegate>
{
    UITableView * tableV;
    NSMutableArray * dataArr;
    NSInteger pages;
}
@end

@implementation BodyDataViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createNavigationView];
    
}
//自定制导航栏
- (void)createNavigationView{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    //关闭导航栏毛玻璃效果
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏颜色
    self.navigationController.navigationBar.barTintColor = COLOR(31, 31, 31);
    //导航栏标题
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(20)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"健身数据";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}
- (void)initData{
    dataArr = [[NSMutableArray alloc]init];
    pages = 0;
}
- (void)loadData{
    NSString * url = [NSString stringWithFormat:@"%@api/?method=user.body&pages=0",BASEURL];
    [HttpRequest GetHttpwithUrl:url parameters:nil andsuccessBlock:^(NSDictionary *responseObject) {
        if ([[responseObject objectForKey:@"rc"] integerValue] == 3) {
            LoginViewController * login = [[LoginViewController alloc]init];
            login.backBtn.hidden = NO;
            [self presentViewController:login animated:YES completion:^{
               //添加弹出动画
                
            }];
        }else{
            NSDictionary * dic = responseObject[@"data"];
            NSString * webStr = dic[@"text"];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (dic.count == 0) {
                    [HttpRequest showAlertWithTitle:@"您还没有上过任何课程"];
                }
                [self createHeaderViewWithWebStr:webStr];
            });
        }
    } andfailBlock:^(NSError *error) {
        [HttpRequest showAlert];
    }];
}
- (void)createUI{
    self.view.backgroundColor = THEMECOLOR;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64) style:UITableViewStylePlain];
    tableV.backgroundColor = THEMECOLOR;
    tableV.dataSource = self;
    tableV.delegate = self;
    [self.view addSubview:tableV];
    
}
- (void)createHeaderViewWithWebStr:(NSString *)webStr{
//    UIWebView * web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, HEIGHT_6(120))];
//    tableV.tableHeaderView = web;
//    web.backgroundColor = THEMECOLOR;
//    [web loadHTMLString:webStr baseURL:nil];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, HEIGHT_6(140))];
    label.numberOfLines = 0;
    label.backgroundColor = THEMECOLOR;
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithData:
           [webStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    label.attributedText = str;
    tableV.tableHeaderView = label;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --tableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BodyTableViewCell * cell = [[BodyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BODY_CELL];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_6(1230) + 40;
}
- (void)ShowImageScrollerViewWithImageArr:(NSArray *)imageArr index:(NSInteger )index{
    
    PhotoScrollerViewController * photoVC = [[PhotoScrollerViewController alloc]init];
    photoVC.index = index;
    photoVC.dataArr = imageArr;
    NSLog(@"长度:%ld",(unsigned long)imageArr.count);
    [self presentViewController:photoVC animated:YES completion:^{
        photoVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        photoVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
    }];
    

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
