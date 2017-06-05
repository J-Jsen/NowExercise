//
//  EvaluateCell.h
//  NowExercise
//
//  Created by Suger on 17/6/1.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EvaluateDelegate <NSObject>

- (void)Advise:(NSString *)advise;

@end

@interface EvaluateCell : UITableViewHeaderFooterView

@property (nonatomic , strong) UITextView * textView;
@property (nonatomic , weak) id <EvaluateDelegate> delegate;

@end
