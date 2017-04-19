//
//  BannerCell.m
//  NowExercise
//
//  Created by mac on 17/2/14.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "BannerCell.h"

@interface BannerCell()<RPRingedPagesDelegate,RPRingedPagesDataSource>

@property (nonatomic , strong) RPRingedPages * pages;
@property (nonatomic , strong) NSMutableArray * dataArr;

@end

@implementation BannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.dataArr = [NSMutableArray array];
        self.backgroundColor = [UIColor redColor];
        self.pages = [[RPRingedPages alloc]initWithFrame:CGRectMake(0, 20, SCREEN_W, 400)];
        
//        CGFloat height = _pages.frame.size.height - _pages.pageControlHeight - _pages.pageControlMarginTop - _pages.pageControlMarginBottom;
//        _pages.carousel.mainPageSize = CGSizeMake(height * 0.7, height);
        _pages.carousel.pageScale = 0.7;
        self.pages.carousel.mainPageSize = CGSizeMake(WIDTH_6(270), 380);
//        _pages.pageControlPosition = RPPageControlPositonAboveBody;
        _pages.delegate = self;
        _pages.dataSource = self;
        [self addSubview:self.pages];
        
    }
    return self;
}
- (void)createCellWithDataArr:(NSMutableArray *)DataArr{
    self.dataArr = DataArr;
    [self.pages reloadData];    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
#pragma mark 代理方法
- (void)didSelectedCurrentPageInPages:(RPRingedPages *)pages {
    NSLog(@"pages selected, the current index is %zd", pages.currentIndex);
    if ([self.delegete respondsToSelector:@selector(didSelectedIndexPageInPages:)]) {
        [self.delegete didSelectedIndexPageInPages:pages.currentIndex];
    }
}
- (void)pages:(RPRingedPages *)pages didScrollToIndex:(NSInteger)index {
    NSLog(@"pages scrolled to index: %zd", index);
    if ([self.delegete respondsToSelector:@selector(didScrollToIndex:)]) {
        [self.delegete didScrollToIndex:index];
    }
    
}
- (NSInteger)numberOfItemsInRingedPages:(RPRingedPages *)pages {
    return self.dataArr.count;
}
- (UIView *)ringedPages:(RPRingedPages *)pages viewForItemAtIndex:(NSInteger)index {

    UIImageView *imageV = (UIImageView *)[pages dequeueReusablePage];
    if (![imageV isKindOfClass:[UIView class]]) {
        imageV = [UIImageView new];
        imageV.image = [UIImage imageNamed:@"2-1.jpg"];
        imageV.layer.backgroundColor = [UIColor blackColor].CGColor;
        imageV.layer.cornerRadius = 5;
        imageV.layer.masksToBounds = YES;
        
        UIButton * button = [[UIButton alloc]init];
        button.center = CGPointMake(WIDTH_6(135), 190);
        
        button.layer.cornerRadius = 25;
        button.layer.masksToBounds = YES;
        button.layer.borderColor = COLOR(227, 209, 191).CGColor;
        button.layer.borderWidth = 2;
        [imageV addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
            make.width.and.height.mas_equalTo(50);
        }];
    }
    return imageV;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
