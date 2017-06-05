//
//  UserTableViewCell.h
//  NowExercise
//
//  Created by mac on 17/3/21.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    CellImage,
    CellTitle,
    CellBtn,
} CellImageViewType;

@protocol  UserTableViewDelegate<NSObject>

- (void)detailTitle:(NSString *)str andindex:(NSInteger )index;
@end

@interface UserTableViewCell : UITableViewCell

@property (nonatomic , assign) CellImageViewType CellType;

@property (nonatomic ,strong) UILabel * titleLabel;

@property (nonatomic , strong)  UIImageView * detailImageV;

@property (nonatomic , assign) NSInteger index;

@property (nonatomic , weak) id<UserTableViewDelegate>delegate;

- (void)createCellWithCellType:(CellImageViewType)CellType;
- (void)createCellWithStr:(NSString *)str;
- (void)CellTFCanUse;
- (void)hide;
- (void)creatCellWithTitle:(NSString *)title;
- (void)createCellImage:(UIImage *)image;

@end
