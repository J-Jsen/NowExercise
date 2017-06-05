//
//  UserPlaceCell.h
//  NowExercise
//
//  Created by 朱学森 on 2017/5/8.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceModel.h"
typedef enum : NSUInteger {
    PlaceDefault,
    PlacePlace,
} PlaceType;

@protocol UserPlaceDelegate <NSObject>

- (void)placeChangeWithmodel:(PlaceModel *)placemodel type:(NSInteger)type index:(NSInteger)index;

@end

@interface UserPlaceCell : UITableViewCell
@property (nonatomic , assign) NSInteger index_row;
@property (nonatomic , weak) id<UserPlaceDelegate>delegate;

- (void)creatCellWithStr:(NSString *)str andplaceid:(NSString *)placeid;
- (void)statusHide;
- (void)setDefaultHide;
- (void)createCellWithModel:(PlaceModel *)placemodel;
@end
