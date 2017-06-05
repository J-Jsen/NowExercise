//
//  StarHeaderView.h
//  NowExercise
//
//  Created by Suger on 17/6/2.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StarViewDelegate <NSObject>

- (void)StarViewSelectIndex:(NSInteger )index;

@end

@interface StarHeaderView : UITableViewHeaderFooterView
@property (nonatomic , weak) id<StarViewDelegate> delegate;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier star:(NSInteger )starindex;
@end
