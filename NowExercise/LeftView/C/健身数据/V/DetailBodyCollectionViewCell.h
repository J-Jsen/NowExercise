//
//  DetailBodyCollectionViewCell.h
//  NowExercise
//
//  Created by mac on 17/4/10.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDataModel.h"
@protocol DetailBodyCollectionViewCellDelegate <NSObject>

- (void)presentDetailPhotoViewImageArr:(NSArray *)arr index:(NSInteger )index;

@end

@interface DetailBodyCollectionViewCell : UICollectionViewCell

@property(nonatomic , weak) id<DetailBodyCollectionViewCellDelegate> delegate;

- (void)disselectCell;
- (void)selectCell;
- (void)createCellWithModel:(MyDataModel *)model;

@end
