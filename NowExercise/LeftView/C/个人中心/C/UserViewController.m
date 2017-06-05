//
//  UserViewController.m
//  NowExercise
//
//  Created by mac on 17/1/21.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "UserViewController.h"

#import "UserTableViewCell.h"
#import "UserPlaceCell.h"
#import "IconViewController.h"
#import "NameViewController.h"
#import "AddPlaceViewController.h"

#import "UserModel.h"
#import "PlaceModel.h"
#define CellID    @"USERCELL"
#define PLACECELL @"PLACECELL"
@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource,NameViewDelegate,UserTableViewDelegate,UserPlaceDelegate,AddPlaceViewControllerDelegate>
{
    UITableView * tableV;
    NSMutableArray * dataArr;
    NSMutableArray * placeArr;
    UserModel * model;
    
    UIView * birthdayView;
    UIDatePicker * birthdayPicker;
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
    [self loadData];
    
//    self.view.backgroundColor = [UIColor redColor];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)loadData{
    [placeArr removeAllObjects];
    NSString * url = [NSString stringWithFormat:@"%@api/?method=user.get_userinfo",BASEURL];
    [HttpRequest GetHttpwithUrl:url parameters:nil andsuccessBlock:^(NSDictionary *responseObject) {
        NSLog(@"***************************%@",responseObject);
        if ([[responseObject objectForKey:@"rc"] integerValue] == 0) {
            NSDictionary * dict = responseObject[@"data"];
            [model setValuesForKeysWithDictionary:dict];
            NSArray * arr = dict[@"address"];
            
            for (NSDictionary * dic in arr) {
                PlaceModel * placemodel = [[PlaceModel alloc]init];
                [placemodel setValuesForKeysWithDictionary:dic];
                [placeArr addObject:placemodel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }
    } andfailBlock:^(NSError *error) {
        [HttpRequest showAlertWithTitle:@"服务器开小差了..."];
    }];
}
//自定制导航栏
- (void)createNavigationView{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
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
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.backgroundColor = THEMECOLOR;
    tableV.separatorColor = THEMECOLOR;
    [tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableV registerClass:[UserTableViewCell class] forCellReuseIdentifier:CellID];
    [tableV registerClass:[UserPlaceCell class] forCellReuseIdentifier:PLACECELL];
    [self.view addSubview:tableV];
    //去掉多余的分割线
    tableV.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 200)];
}
- (void)dataInit{
    dataArr = [[NSMutableArray alloc]initWithObjects:@"头像",@"用户名",@"性别",@"出生年月日",@"所在城市",@"身高(cm)",@"体重(kg)",@"BMI", nil];
    placeArr = [[NSMutableArray alloc]init];
    model = [[UserModel alloc]init];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return dataArr.count;
    }else if (section == 1){
        return placeArr.count + 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UserTableViewCell * cell = [[UserTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.index = indexPath.row;
        [cell creatCellWithTitle:dataArr[indexPath.row]];
        switch (indexPath.row) {
            case 0:
            {//头像
                [cell createCellWithCellType:CellImage];
                [cell createCellWithStr:model.headimg];
            }
                break;
            case 1:
            {//用户名
                [cell createCellWithCellType:CellTitle];
                [cell createCellWithStr:model.nickname];
                [cell CellTFCanUse];
            }
                break;
            case 2:
            {//性别
                [cell createCellWithCellType:CellTitle];
                if (model.gender == 1) {
                    [cell createCellWithStr:@"男"];
                }else{
                    [cell createCellWithStr:@"女"];
                }
                [cell CellTFCanUse];
            }
                break;
            case 3:
            {//出生年月
                [cell createCellWithCellType:CellTitle];
                [cell createCellWithStr:model.birthday];
                [cell CellTFCanUse];
            }
                break;
            case 4:
            {//所在城市
                [cell createCellWithCellType:CellTitle];
                [cell createCellWithStr:[Default objectForKey:@"city"]];
                cell.userInteractionEnabled = NO;
            }
                break;
            case 5:
            {//身高
                cell.delegate = self;
                [cell createCellWithCellType:CellTitle];
                [cell createCellWithStr:[NSString stringWithFormat:@"%ld",(long)model.height]];
            }
                break;
            case 6:
            {//体重
                cell.delegate = self;
                [cell createCellWithCellType:CellTitle];
                [cell createCellWithStr:[NSString stringWithFormat:@"%ld",(long)model.weight]];
            }
                break;
            case 7:
            {//bmi
                [cell createCellWithCellType:CellTitle];
                float bmi = (float)model.weight / (model.height * model.height * 0.0001);
                [cell createCellWithStr:[NSString stringWithFormat:@"%.2f",bmi]];
                [cell hide];
                cell.userInteractionEnabled = NO;
            }

                break;
            default:
                break;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        if (indexPath.row < placeArr.count) {
            UserPlaceCell * cell = [[UserPlaceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PLACECELL];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (placeArr.count > 0) {
                PlaceModel * placemodel = placeArr[indexPath.row];
                [cell createCellWithModel:placemodel];
            }
            return cell;

        }else{
            UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            cell.detailTextLabel.text = @"新增地址  ";
            cell.backgroundColor = MAKA_JIN_COLOR;
            return cell;
        }
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 1){
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_W, 40)];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = THEMECOLOR;
        label.text = @"  地址";
        return label;
    }
    return [[UIView alloc]init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                return WIDTH_6(60);
                break;
                
            default:
                return WIDTH_6(45);
                break;
        }

    }else{
        if (indexPath.row == placeArr.count) {
            return 40;
        }
        return HEIGHT_6(80);
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 60;
}
#pragma mark --tableViewdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UserTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];

    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                IconViewController * iconVC = [[IconViewController alloc]init];
                iconVC.image = cell.detailImageV.image;
                iconVC.iconBackBlock = ^(UIImage * image){
                    [cell createCellImage:image];
                    
                };
                [self.navigationController pushViewController:iconVC animated:YES];
                
            }
                break;
            case 1:
            {
                NameViewController * name = [[NameViewController alloc]init];
                name.name = model.nickname;
                name.delegate = self;

                [self.navigationController pushViewController:name animated:YES];
            }
                break;
            case 2:
            {
                [LSActionSheet showWithTitle:@"性别" destructiveTitle:@"女" otherTitles:@[@"男"] block:^(int index) {
                    
                    NSString * url = [NSString stringWithFormat:@"%@api/?method=user.set_userinfo&gender=%d",BASEURL,index + 1];
                    [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:^(NSProgress *progress) {
                        
                    } andsuccessBlock:^(NSDictionary *responseObject) {
                        NSLog(@"性别修改成功");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            model.gender = index + 1;
                            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
                            [tableV reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];

                        });

                        
                    } andfailBlock:^(NSError *error) {
                        
                    }];
                }];
            }
                break;
            case 3:
            {
                [self showBirthDayView];
            }
                break;
            default:
                break;
        }

    }else{
        if (indexPath.row == placeArr.count) {
            [self addplaceBtnClick];
        }
    }
}
- (void)showBirthDayView{
    
    birthdayView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    birthdayView.backgroundColor = [UIColor grayColor];

    [[UIApplication sharedApplication].keyWindow addSubview:birthdayView];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sureButton.frame     = CGRectMake(0, SCREEN_H - HEIGHT_6(256), SCREEN_W, HEIGHT_6(40));
    sureButton.backgroundColor  = MAKA_JIN_COLOR;
    sureButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:HEIGHT_6(16)];
    [sureButton setTintColor:[UIColor whiteColor]];
    [sureButton setTitle:@"完成" forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureBirthdayClick:) forControlEvents:UIControlEventTouchUpInside];
    [birthdayView addSubview:sureButton];

    birthdayPicker       = [UIDatePicker new];
    birthdayPicker.frame = CGRectMake(0, CGRectGetMaxY(sureButton.frame), SCREEN_W, HEIGHT_6(216));
    birthdayPicker.backgroundColor = [UIColor whiteColor];
    birthdayPicker.datePickerMode  = UIDatePickerModeDate;
    [birthdayView addSubview:birthdayPicker];

    
}
- (void)sureBirthdayClick:(UIButton *)button {
    UserTableViewCell * cell = [tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString* dateString = [formatter stringFromDate:birthdayPicker.date];


    NSString * birthdayTimeString = [NSString stringWithFormat:@"%ld", (long)[birthdayPicker.date timeIntervalSince1970]];
    NSString * url = [NSString stringWithFormat:@"%@api/?method=user.set_userinfo&birthday=%@",BASEURL,birthdayTimeString];
    [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(NSDictionary *responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell createCellWithStr:dateString];
            NSLog(@"生日");
        });
    } andfailBlock:^(NSError *error) {
        
    }];
    
    [birthdayView removeFromSuperview];
}
#pragma mark 用户名代理
- (void)NameStr:(NSString *)name{
    UserTableViewCell * cell = [tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [cell createCellWithStr:name];
    model.nickname = name;
}
//height=175&weight=60
- (void)detailTitle:(NSString *)str andindex:(NSInteger)index{
    UserTableViewCell * cell = [tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    switch (index) {
        case 5:
        {//身高
            NSString * url = [NSString stringWithFormat:@"%@api/?method=user.set_userinfo&height=%ld",BASEURL,(long)[str integerValue]];
            [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:^(NSProgress *progress) {
                
            } andsuccessBlock:^(NSDictionary *responseObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    model.height = [str integerValue];
                    [cell createCellWithStr:str];
                    UserTableViewCell * bmicell = [tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
                    float bmif = (float)model.weight / (model.height * model.height * 0.0001) * 1.0;
                    NSString * bmi = [NSString stringWithFormat:@"%0.2f",bmif];
                    [bmicell createCellWithStr:bmi];
                });

            } andfailBlock:^(NSError *error) {
                
            }];
        }
            break;
        case 6:
        {//体重
            NSString * url = [NSString stringWithFormat:@"%@api/?method=user.set_userinfo&weight=%ld",BASEURL,(long)[str integerValue]];
            [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(NSDictionary *responseObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    model.weight = [str integerValue];
                    [cell createCellWithStr:str];
                    UserTableViewCell * bmicell = [tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
                    float bmif =  (float)model.weight / (model.height * model.height * 0.0001) * 1.0;
                    NSString * bmi = [NSString stringWithFormat:@"%0.2f",bmif];
                    [bmicell createCellWithStr:bmi];
  
                });
            } andfailBlock:^(NSError *error) {
                
            }];
        }
            break;
            
 
        default:
            break;
    }
}
- (void)placeChangeWithmodel:(PlaceModel *)placemodel type:(NSInteger)type index:(NSInteger)index{
    WeakSelf
    switch (type) {
        case 1:
        {//设为默认
            NSString * url = [NSString stringWithFormat:@"%@api/?method=address.default&address_id=%ld",BASEURL,(long)placemodel.placeID];
            [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(NSDictionary *responseObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf loadData];
                });
            } andfailBlock:^(NSError *error) {
                
            }];
        }
            break;
        case 2:
        {//删除
            [LSActionSheet showWithTitle:@"是否删除地址" destructiveTitle:@"否" otherTitles:@[@"是"] block:^(int index) {
                if (index == 0) {
                    NSString * url = [NSString stringWithFormat:@"%@api/?method=address.delete&address_id=%ld",BASEURL,(long)placemodel.placeID];
                    [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:^(NSProgress *progress) {
                        
                    } andsuccessBlock:^(NSDictionary *responseObject) {
                        [placeArr removeObject:placemodel];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
                            [tableV reloadSections:indexSet withRowAnimation:UITableViewRowAnimationLeft];

                        });
                    } andfailBlock:^(NSError *error) {
                        
                    }];
                }
            }];
        }
            break;

        default:
            break;
    }
}
- (void)addplaceBtnClick{
    //添加新地址
    AddPlaceViewController * placeVC = [[AddPlaceViewController alloc]init];
    placeVC.delegate = self;
    [self.navigationController pushViewController:placeVC animated:YES];
}
-(void)AddPlace{
    [self loadData];
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

