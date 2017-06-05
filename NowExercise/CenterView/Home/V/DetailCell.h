//
//  DetailCell.h
//  NowExercise
//
//  Created by mac on 17/2/15.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell

//标题
@property (weak, nonatomic) IBOutlet UILabel *DetailLabel;
//课程介绍标题
@property (weak, nonatomic) IBOutlet UILabel *ClassLabel;
//课程介绍内容
@property (weak, nonatomic) IBOutlet UILabel *ClassShowLabel;
//注意事项标题
@property (weak, nonatomic) IBOutlet UILabel *MatterLabel;
//注意事项内容
@property (weak, nonatomic) IBOutlet UILabel *MatterShowLabel;
//立炼告知标题
@property (weak, nonatomic) IBOutlet UILabel *NowExerciseInformLabel;
//立炼告知内容
@property (weak, nonatomic) IBOutlet UILabel *NowExerciseLabel;

@property (nonatomic , assign) CGFloat Cell_H;


- (void)createCellWith:(NSString *)detailStr title:(NSString *)title;


@end
