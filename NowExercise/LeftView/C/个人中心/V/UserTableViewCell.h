//
//  UserTableViewCell.h
//  NowExercise
//
//  Created by mac on 17/3/21.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CellImageWithDetail,
    CellImageWithTitle,
} CellImageViewType;


@interface UserTableViewCell : UITableViewCell

@property (nonatomic , assign) BOOL titleImageViewHidden;

@property (nonatomic , assign) CellImageViewType CellType;

- (void)createCellWithCellType:(CellImageViewType)CellType;

@end
