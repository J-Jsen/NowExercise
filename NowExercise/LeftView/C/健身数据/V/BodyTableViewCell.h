//
//  BodyTableViewCell.h
//  NowExercise
//
//  Created by mac on 17/4/5.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BodyTableViewCellDelegate <NSObject>

- (void)ShowImageScrollerViewWithImageArr:(NSArray *)imageArr index:(NSInteger )index;

@end

@interface BodyTableViewCell : UITableViewCell
@property (nonatomic , weak) id<BodyTableViewCellDelegate> delegate;

@end
