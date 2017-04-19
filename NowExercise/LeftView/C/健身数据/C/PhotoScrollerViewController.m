//
//  PhotoScrollerViewController.m
//  NowExercise
//
//  Created by Suger on 17/4/14.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "PhotoScrollerViewController.h"
#import "PhotoImgeView.h"
@interface PhotoScrollerViewController ()
{
    UIScrollView * scrollV;
    
}
@end

@implementation PhotoScrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)createUI{
    scrollV = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollV.pagingEnabled = YES;
//    scrollV.maximumZoomScale = 1.0;
//    scrollV.minimumZoomScale = 1.0;
    //scrollV.bounces = NO;
    scrollV.contentSize = CGSizeMake(SCREEN_W * 2, SCREEN_H);
    //scrollV.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    //scrollV.showsVerticalScrollIndicator = NO;
    //scrollV.showsHorizontalScrollIndicator = NO;
    //scrollV.backgroundColor = [UIColor blackColor];
    scrollV.zoomScale = 1;
    [self.view addSubview:scrollV];
    
    
    for (int i = 0; i < self.dataArr.count; i ++) {
        PhotoImgeView * imageV = [[PhotoImgeView alloc]initWithFrame:CGRectMake(i * SCREEN_W, 0, SCREEN_W, SCREEN_H)];
        [imageV setImage:_dataArr[i]];
        [scrollV addSubview:imageV];
    }
    scrollV.contentOffset = CGPointMake(SCREEN_W * _index, 0);
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
}
- (void)tap:(UITapGestureRecognizer *)tap{
    [self dismissViewControllerAnimated:YES completion:nil];
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
