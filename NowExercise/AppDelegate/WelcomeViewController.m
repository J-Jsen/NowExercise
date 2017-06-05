//
//  WelcomeViewController.m
//  NowExercise
//
//  Created by mac on 17/1/20.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "WelcomeViewController.h"
#import "PGIndexBannerSubiew.h"
@interface WelcomeViewController ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.imageArray = [[NSMutableArray alloc]initWithObjects:@"引导页1.png",@"引导页2.png", nil];
    [self setUpUI];
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)setUpUI{
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    pageFlowView.backgroundColor = [UIColor whiteColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
//    pageFlowView.minimumPageAlpha = 0.4;
//    pageFlowView.minimumPageScale = 0.85;
//    pageFlowView.orginPageCount = self.imageArray.count;
    pageFlowView.isOpenAutoScroll = NO;
    pageFlowView.isCarousel = NO;
    //初始化pageControl
//    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 10, SCREEN_W, 8)];
//    pageControl.pageIndicatorTintColor = [UIColor redColor];
//    pageFlowView.pageControl = pageControl;
//    [pageFlowView addSubview:pageControl];
    
    //    [self.view addSubview:pageFlowView];
    
    /****************************
     使用导航控制器(UINavigationController)
     如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件
     请使用UIScrollView作为NewPagedFlowView的容器View,才会显示正常,如下
     *****************************/
    
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [pageFlowView reloadData];
    [bottomScrollView addSubview:pageFlowView];
    [self.view addSubview:bottomScrollView];
    
    [bottomScrollView addSubview:pageFlowView];
    
    self.pageFlowView = pageFlowView;

}
#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return [UIScreen mainScreen].bounds.size;
}
#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArray.count;
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        bannerView.layer.cornerRadius = 4;
//        bannerView.layer.masksToBounds = YES;
    }
    
    //在这里下载网络图片
    //[bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    
    bannerView.mainImageView.image = [UIImage imageNamed:self.imageArray[index]];
    bannerView.backgroundColor = [UIColor clearColor];
    return bannerView;
}
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    if (subIndex == 1) {
        self.WelcomeChangeRootView();

    }
}

- (IBAction)ChangeRootView:(id)sender {
    self.WelcomeChangeRootView();
    
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
