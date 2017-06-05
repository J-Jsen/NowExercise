//
//  PackageCell.h
//  NowExercise
//
//  Created by Suger on 17/5/4.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
@interface PackageCell : UITableViewCell
INTEGER_PROPERTY(index_row);
- (void)createCellWithModel:(OrderModel *)model;

@end
