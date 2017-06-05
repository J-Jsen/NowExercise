//
//  StarHeaderView.m
//  NowExercise
//
//  Created by Suger on 17/6/2.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "StarHeaderView.h"
#import "ZJD_StarEvaluateView.h"
@interface StarHeaderView()
{
    UILabel * titleLabel;
    ZJD_StarEvaluateView * StarV;
    
}

@end

@implementation StarHeaderView
//{
//star: 3
//wenti:[1,2,3,4]
//xiangqing:"还可以"
//order_id:43294832904
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier star:(NSInteger )starindex{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WIDTH_6(140), HEIGHT_6(50))];
        titleLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(16)];
        titleLabel.text = @"对课程的满意程度";
        [self addSubview:titleLabel];
        
        StarV = [[ZJD_StarEvaluateView alloc]initWithFrame:CGRectMake(WIDTH_6(150), 0, WIDTH_6(104), HEIGHT_6(50)) starIndex:starindex starWidth:20 space:1 defaultImage:nil lightImage:nil isCanTap:YES];
        
        WeakSelf
        StarV.starEvaluateBlock = ^(ZJD_StarEvaluateView *starView,NSInteger index){
            if ([weakSelf.delegate respondsToSelector:@selector(StarViewSelectIndex:)]) {
                [weakSelf.delegate StarViewSelectIndex:index];
            }
        };
        [self addSubview:StarV];
        
    }
    return self;
}


@end
