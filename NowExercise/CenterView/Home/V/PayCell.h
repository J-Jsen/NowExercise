//
//  PayCell.h
//  NowExercise
//
//  Created by mac on 17/3/28.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayCell : UITableViewCell
//
- (void)createCellWithTitleImage:(UIImage *)image;
//选中Cell
- (void)selectCell;
//取消选择cell
- (void)disselectCell;

@end
