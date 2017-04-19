//
//  BannerCell.h
//  NowExercise
//
//  Created by mac on 17/2/14.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BannerDelegate <NSObject>

- (void)didScrollToIndex:(NSInteger)row;
- (void)didSelectedIndexPageInPages:(NSInteger)row;

@end

@interface BannerCell : UITableViewCell

@property (nonatomic , weak) id<BannerDelegate> delegete;

- (void)createCellWithDataArr:(NSMutableArray *)DataArr;

@end
