//
//  DetailBodyView.m
//  NowExercise
//
//  Created by mac on 17/4/10.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "DetailBodyView.h"
#import "DetailBodyCollectionViewCell.h"

#define DETAILBODY_CELL @"DETAILBODYCELL"

@interface DetailBodyView ()<UICollectionViewDelegate,UICollectionViewDataSource,DetailBodyCollectionViewCellDelegate,UIScrollViewDelegate>
{
    UICollectionView * collectionV;
    NSMutableArray * dataArr;
    DetailBodyCollectionViewCell * lastCell;
    BOOL first;
}


@end

@implementation DetailBodyView
- (instancetype)init{
    if (self = [super init]) {
        [self dataInit];
        [self createUI];
    }
    return self;
}
- (void)dataInit{
    dataArr = [NSMutableArray array];
    first = YES;
}
- (void)createUI{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //行距
    flowLayout.minimumLineSpacing = 0;
    //列距
    flowLayout.minimumInteritemSpacing = 0;
    //设置每个item的大小
    flowLayout.itemSize = CGSizeMake(SCREEN_W *3 / 10, HEIGHT_6(1230) + 40);
    //设置 uicollectionView 的滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    collectionV.backgroundColor = THEMECOLOR;
    collectionV.delegate = self;
    collectionV.dataSource = self;
    [collectionV registerClass:[DetailBodyCollectionViewCell class] forCellWithReuseIdentifier:DETAILBODY_CELL];
    [self addSubview:collectionV];
    
    [collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


#pragma mark --collectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
    return dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailBodyCollectionViewCell * cell = (DetailBodyCollectionViewCell *)[collectionV dequeueReusableCellWithReuseIdentifier:DETAILBODY_CELL forIndexPath:indexPath];
    if (indexPath.row == 0 && first) {
        lastCell = cell;
        [cell selectCell];
        first = NO;
    }
    cell.delegate = self;
    return cell;
}

- (void)presentDetailPhotoViewImageArr:(NSArray *)arr index:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(showImageScrollerViewArr:index:)]) {
        [self.delegate showImageScrollerViewArr:arr index:index];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint  p  = scrollView.contentOffset;
    int row = p.x / (SCREEN_W *3 / 10);
    float rows = p.x / (SCREEN_W * 3 / 10);
    if (rows > row + 0.6 && row < 4) {
        DetailBodyCollectionViewCell * collectioncell = (DetailBodyCollectionViewCell *)[collectionV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:row + 1 inSection:0]];
        if (collectioncell != lastCell) {
            [collectioncell selectCell];
            [lastCell disselectCell];
            lastCell = collectioncell;
        }
        
    }
    if (p.x <= 0 && collectionV.subviews.count != 0) {
        DetailBodyCollectionViewCell * cell = (DetailBodyCollectionViewCell *)[collectionV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        if (cell != lastCell) {
            [cell selectCell];
            [lastCell disselectCell];
            lastCell = cell;
        }
    }

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
