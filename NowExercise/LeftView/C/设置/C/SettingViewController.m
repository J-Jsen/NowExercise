//
//  SettingViewController.m
//  NowExercise
//
//  Created by mac on 17/1/21.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "SettingViewController.h"
#import "LoginViewController.h"
#import "AboutUsViewController.h"
#import "UserProtocolViewController.h"
#import "SettingCell.h"
@interface SettingViewController ()<UITableViewDelegate , UITableViewDataSource , LoginDelegate>
{
    UITableView * tableV;
    NSMutableArray * dataArr;
    UIButton * LoginOrOutBtn;
}
@end

@implementation SettingViewController
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
    titleLabel.text = @"设置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataInit];
    [self createUI];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)dataInit{
    dataArr = [[NSMutableArray alloc]initWithObjects:@"关于我们",@"清除缓存",@"用户协议",@"去APP Store评分",@"客服电话:010-65460058", nil];
    
}
- (void)createUI{
    self.view.backgroundColor = THEMECOLOR;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64) style:UITableViewStylePlain];
    tableV.dataSource = self;
    tableV.delegate = self;
    tableV.separatorColor = [UIColor grayColor];
    tableV.backgroundColor = THEMECOLOR;
    [self.view addSubview:tableV];
    [tableV registerClass:[SettingCell class] forCellReuseIdentifier:@"SetCell"];
    [self createTableViewHeaderAndFooter];
    
}
- (void)createTableViewHeaderAndFooter{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, HEIGHT_6(40) + 10)];
    
    LoginOrOutBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, SCREEN_W, HEIGHT_6(40) + 10)];
    LoginOrOutBtn.backgroundColor = MAKA_JIN_COLOR;
    [LoginOrOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    LoginOrOutBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [LoginOrOutBtn addTarget:self action:@selector(LoginOrOutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"((((((((((((((((((((((((______shifou登录:%d",[HttpRequest judgeWhetherUserLogin]);

    if ([HttpRequest judgeWhetherUserLogin]) {
        [LoginOrOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    }else{
        [LoginOrOutBtn setTitle:@"登录" forState:UIControlStateNormal];
    }
    [view addSubview:LoginOrOutBtn];
    tableV.tableFooterView = view;
    
    tableV.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 10)];
    
}
#pragma mark --tableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettingCell *cell = [[SettingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SetCell"];
//    cell.detailTextLabel.text = @">";
//    cell.imageView.image = [UIImage imageNamed:@"返回"];
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:HEIGHT_6(22)];
    cell.textLabel.text = dataArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:HEIGHT_6(15)];
    cell.backgroundColor = MAKA_JIN_COLOR;
    if (indexPath.row == 1) {
        //获取缓存大小。。
        NSString* cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        CGFloat fileSize = [self folderSizeAtPath:cachPath];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fMB", fileSize];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:HEIGHT_6(15)];
            
        });
    }else if (indexPath.row == 4) {
        cell.detailTextLabel.text = @"";
    }else{
        [cell createCellImageStr:@"详情"];
    }
    
    return cell;
}
#pragma  mark --tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0://关于我们
        {
            AboutUsViewController * about = [[AboutUsViewController alloc]init];
            [self.navigationController pushViewController:about animated:YES];
            
        }
            break;
        case 1://清除缓存
        {
            NSString* cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            [self cleanCaches:cachPath];
            UITableViewCell * cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fMB",[self folderSizeAtPath:cachPath]];
        }
            break;
            case 2://用户协议
        {
            UserProtocolViewController * userprtocol = [[UserProtocolViewController alloc]init];
            [self.navigationController pushViewController:userprtocol animated:YES];
            
        }
            break;
        case 3://去app store评分
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://itunes.apple.com/cn/app/guo-dong/id998425416?l=en&mt=8"]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/cn/app/guo-dong/id998425416?l=en&mt=8"] options:@{} completionHandler:nil];
                
            }
        }
            break;
        case 4://客服电话
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:010-65460058"]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:010-65460058"] options:@{} completionHandler:nil];
                
            }
        }
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 退出登陆或者登陆
- (void)LoginOrOutBtnClick:(UIButton *)Btn{
    NSLog(@"***********************登陆或退出************************");
    if ([HttpRequest judgeWhetherUserLogin]) {
       [SRAlertView sr_showAlertViewWithTitle:@"提示" message:@"您真的要退出么" leftActionTitle:@"确定" rightActionTitle:@"取消" animationStyle:AlertViewAnimationZoom selectAction:^(AlertViewActionType actionType) {
           if(actionType == AlertViewActionTypeLeft){
               //退出登录
               NSURL* url = [NSURL URLWithString:BASEURL];
               if (url) {
                   NSArray* cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
                   for (int i = 0; i < [cookies count]; i++) {
                       NSHTTPCookie* cookie = (NSHTTPCookie*)[cookies objectAtIndex:i];
                       [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
                   }
                   
                   NSHTTPCookieStorage* sharedHTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                   NSArray* cookiesaaa = [sharedHTTPCookieStorage cookiesForURL:[NSURL URLWithString:BASEURL]];
                   NSLog(@"退出登录 cookies %@",cookiesaaa);
                   NSLog(@"******************************退出登录%d",[HttpRequest judgeWhetherUserLogin]);
               }

               [HttpRequest showAlertWithTitle:@"退出成功"];
               dispatch_async(dispatch_get_main_queue(), ^{
                   [LoginOrOutBtn setTitle:@"登录" forState:UIControlStateNormal];
//                   [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeViewRefresh" object:nil];

               });
           }
                }];
    }else{
        LoginViewController * login = [[LoginViewController alloc]init];
        login.back = NO;
        login.delegate = self;
        [self presentViewController:login animated:YES completion:nil];
    }
}
//清除缓存
#pragma mark - 获取缓存大小
- (CGFloat)folderSizeAtPath:(NSString*)folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator* childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName = nil;
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize / (1024.0 * 1024.0);
}
- (long long)fileSizeAtPath:(NSString*)filePath

{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

#pragma mark 清除缓存
- (void)cleanCaches:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        // 获取该路径下面的文件名
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
            // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}
- (void)login{
    [LoginOrOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
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
