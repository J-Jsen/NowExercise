//
//  EvaluateViewController.m
//  NowExercise
//
//  Created by 朱学森 on 2017/5/12.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "EvaluateViewController.h"
//#import "ZJD_StarEvaluateView.h"
#import "NSString+Suger.h"

#import "questionCell.h"
#import "EvaluateCell.h"
#import "StarHeaderView.h"

#import "EvaluateModel.h"
#import "PostModel.h"

#define QUESTION_CELL @"QUESTIONCELL"
#define EVALUATE_CELL @"EVALUATECELL"
#define STAR_CELL @"STARCELL"
@interface EvaluateViewController ()<UITableViewDelegate , UITableViewDataSource,StarViewDelegate , EvaluateDelegate>
{
    UITableView * tableV;
    NSMutableArray * dataArr;
    NSInteger star;
    NSString * adviseStr;
//    PostModel * postmodel;
    BOOL isStar;
}
@end

@implementation EvaluateViewController
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
    titleLabel.text = @"订单评价";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];

    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(SaveBtnClick)];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createNavigationView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self createTabelViewHeaderView];
    [self createTabelViewFooterView];
    [self loadData];
//    self.view.backgroundColor = THEMECOLOR;
//    self.TextView.layer.cornerRadius = 4;
//    self.TextView.layer.masksToBounds = YES;
//    self.TextView.layer.borderColor = MAKA_JIN_COLOR.CGColor;
//    self.TextView.layer.borderWidth = 1;
//    self.TextView.backgroundColor = MAKA_JIN_COLOR;
    // Do any additional setup after loading the view from its nib.
}
- (void)initData{
    dataArr = [[NSMutableArray alloc]init];
//    postmodel = [[PostModel alloc]init];
    
    star = 0;
}
#pragma mark 加载数据
- (void)loadData{
//    NSString * url = [NSString stringWithFormat:@"%@",BASEURL];
    NSString * url = @"http://192.168.1.90:5050/api/?method=order.reasons";
    [HttpRequest GetHttpwithUrl:url parameters:nil andsuccessBlock:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"问题数据::::::*((((()))))))%@",responseObject);
        if ([[responseObject objectForKey:@"rc"] integerValue] == 0) {
            //成功返回数据
            NSArray * arr = responseObject[@"data"];
            EvaluateModel * model = [[EvaluateModel alloc]init];
            model.content = @"是否出现以下现象:";
            model.ID = 100;
            for (NSDictionary * dic in arr) {
                EvaluateModel * model = [[EvaluateModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [dataArr addObject:model];
            }
            
//            [tableV reloadData];
        }
        
    } andfailBlock:^(NSError * _Nonnull error) {
        [HttpRequest showAlertWithTitle:@"服务器开小差了..."];
    }];
}
- (void)createUI{
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64) style:UITableViewStylePlain];
    tableV.backgroundColor = MAKA_JIN_COLOR;
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.bounces = NO;
    tableV.separatorColor = [UIColor clearColor];
    [tableV registerClass:[questionCell class] forCellReuseIdentifier:QUESTION_CELL];
    [tableV registerClass:[EvaluateCell class] forHeaderFooterViewReuseIdentifier:EVALUATE_CELL];
    [tableV registerClass:[StarHeaderView class] forHeaderFooterViewReuseIdentifier:STAR_CELL];
    [self.view addSubview:tableV];
    
}
- (void)createTabelViewHeaderView{
    UIView * tabelViewHeaderV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, HEIGHT_6(230))];
    tabelViewHeaderV.backgroundColor = MAKA_JIN_COLOR;
    tableV.tableHeaderView = tabelViewHeaderV;
    
    UIImageView * backgroundV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, HEIGHT_6(185))];
    backgroundV.image = [UIImage imageNamed:@"评价顶图.png"];
    [tabelViewHeaderV addSubview:backgroundV];
    
    UIImageView * titleImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    titleImageV.layer.cornerRadius = 30;
    titleImageV.layer.masksToBounds = YES;
    titleImageV.center = CGPointMake(tabelViewHeaderV.center.x, HEIGHT_6(75));
    [titleImageV sd_setImageWithURL:[NSURL URLWithString:self.model.coach_info[@"headimg"]]];
    titleImageV.backgroundColor = [UIColor grayColor];
    [tabelViewHeaderV addSubview:titleImageV];
    
    UILabel * coachName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, HEIGHT_6(25))];
    coachName.textColor = [UIColor blackColor];
    coachName.font = [UIFont systemFontOfSize:HEIGHT_6(17)];
    coachName.textAlignment = NSTextAlignmentCenter;
    coachName.center = CGPointMake(tabelViewHeaderV.center.x, HEIGHT_6(125));
    coachName.text = self.model.coach_info[@"username"];
    [tabelViewHeaderV addSubview:coachName];
    
    UILabel * classLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT_6(150), SCREEN_W, 30)];
    classLabel.textAlignment = NSTextAlignmentCenter;
    classLabel.text = self.model.course;
    classLabel.font = [UIFont boldSystemFontOfSize:25];
    classLabel.textColor = [UIColor blackColor];
    [tabelViewHeaderV addSubview:classLabel];
    
    UILabel * time = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT_6(190), SCREEN_W, HEIGHT_6(20))];
    time.textAlignment = NSTextAlignmentCenter;
    time.textColor = [UIColor blackColor];
    [tabelViewHeaderV addSubview:time];
    
    NSString * t = [NSString dateToString:[NSString stringWithFormat:@"%ld",self.model.pre_time] Format:@"yyyy年MM月dd日 hh:mm"];
    NSString * t1 = [NSString dateToString:[NSString stringWithFormat:@"%ld",self.model.pre_time] Format:@"hh:mm"];
    NSString * classtime = [NSString stringWithFormat:@"%@-%@",t,t1];
    
    time.text = classtime;
    
    UILabel * label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor grayColor];
    [tabelViewHeaderV addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.bottom.offset(-1);
        make.height.mas_equalTo(1);
    }];
}

- (void)createTabelViewFooterView{
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 60)];
    footerView.backgroundColor = MAKA_JIN_COLOR;
    
    UIButton * saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 125, 40)];
    saveBtn.layer.cornerRadius = 20;
    [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveBtn setTitle:@"保  存" forState:UIControlStateNormal];
    saveBtn.backgroundColor = COLOR(255, 255, 255);
    saveBtn.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    saveBtn.layer.shadowOffset = CGSizeMake(2,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    saveBtn.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    saveBtn.layer.shadowRadius = 4;//阴影半径，默认3
    saveBtn.center = CGPointMake(SCREEN_W / 2, 30);
    [saveBtn addTarget:self action:@selector(SaveEvaluateClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:saveBtn];
    tableV.tableFooterView = footerView;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (!isStar) {
            return dataArr.count;
        }else{
            return 0;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    questionCell * cell = [[questionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QUESTION_CELL];
    if (dataArr.count > 1) {
        EvaluateModel * model = dataArr[indexPath.row];
        if (model.select) {
            [cell select];
        }
        if (indexPath.row == 0) {
            cell.userInteractionEnabled = NO;
        }
        cell.textLabel.text = model.content;
    }

    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        StarHeaderView * starView = [[StarHeaderView alloc]initWithReuseIdentifier:STAR_CELL star:star];
        starView.delegate = self;
        return starView;
    }
    EvaluateCell * evaluate = [[EvaluateCell alloc]initWithReuseIdentifier:EVALUATE_CELL];
    evaluate.delegate = self;
    return evaluate;
    
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = MAKA_JIN_COLOR;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 50;
    }
    return 200;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
#pragma mark tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EvaluateModel * model = dataArr[indexPath.row];
    questionCell * cell = [tableV cellForRowAtIndexPath:indexPath];

    if (model.select) {
        [cell disselect];
    }else{
        [cell select];
    }
    model.select = !model.select;

}

#pragma mark EvaluateDelegate
- (void)Advise:(NSString *)advise{
    adviseStr = advise;
}
#pragma mark StarViewDelegate
- (void)StarViewSelectIndex:(NSInteger)index{
    NSLog(@"星级为:%ld",index);
//    postmodel.star = [NSString stringWithFormat:@"%ld",index];
    star = index;
    if (index == 5) {
        isStar = YES;
    }else{
        isStar = NO;
    }
    NSIndexSet * set = [NSIndexSet indexSetWithIndex:0];
    [tableV reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
- (void)SaveEvaluateClick:(UIButton *)saveBtn{
    //上传评价
    
    if (star == 0) {
        [HttpRequest showAlertWithTitle:@"请选择评价星级"];
        return;
    }
    if ([adviseStr isEqualToString:@""]) {
        [HttpRequest showAlertWithTitle:@"评价内容不能为空"];
        return;
    }
    NSLog(@"上传中");
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
//    for (EvaluateModel * model in dataArr) {
//        if (model.select) {
//            [arr addObject:[NSString stringWithFormat:@"%ld",model.ID]];
//        }
//    }
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic setObject:arr forKey:@"id"];
    [postDic setObject:@(star) forKey:@"star"];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setObject:arr forKey:@"id"];
    [dic setObject:@"222" forKey:@"info"];
    [dic setObject:@(3) forKey:@"star"];
    NSString * url = [NSString stringWithFormat:@"%@api/?method=order.feed&order_id=%@",BASEURL,_model.order_id];
    WeakSelf
//    NSString * url = @"http://www.antson.cn:8080/stars/";
//    NSString * url = @"http://192.168.1.90:5050/api/?method=order.feed&order_id=141706054D5E988";
    [HttpRequest PostHttpwithUrl:url andparameters:dic andProgress:nil andsuccessBlock:^(NSDictionary *responseObject) {
        [SRAlertView sr_showAlertViewWithTitle:@"提示" message:@"订单评价成功" leftActionTitle:@"确定" rightActionTitle:nil animationStyle:AlertViewAnimationZoom selectAction:^(AlertViewActionType actionType) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.delegate respondsToSelector:@selector(EvaluateSuceess:)]) {
                    [self.delegate EvaluateSuceess:self.index];
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }];
    } andfailBlock:^(NSError *error) {
        NSLog(@"失败");
    }];
}
///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
//    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
//    CGFloat offset = (_placeTF.frame.origin.y+_placeTF.frame.size.height) - (self.frame.size.height - kbHeight);
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    //    if(offset > 0) {
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0.0f, -kbHeight + 64, self.view.frame.size.width, self.view.frame.size.height);
    }];
    //    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    }];
}


- (void)SaveBtnClick{
    if (self.TextView.text.length == 0) {
        [HttpRequest showAlertWithTitle:@"评价内容不能为空"];
    }else{
        NSString * text = [NSString CanUseString:self.TextView.text];
        NSString * url = [NSString stringWithFormat:@"%@api/?method=order.feed&order_id=%@&content=%@",BASEURL,self.order_id,text];
        [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(NSDictionary *responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [HttpRequest showAlertWithTitle:@"订单评价成功"];
                if ([self.delegate respondsToSelector:@selector(EvaluateSuceess:)]) {
                    [self.delegate EvaluateSuceess:self.index];
                }
                [self.navigationController popViewControllerAnimated:YES];
            });
        } andfailBlock:^(NSError *error) {
            
        }];
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
