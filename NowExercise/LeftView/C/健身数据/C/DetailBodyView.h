//
//  DetailBodyView.h
//  NowExercise
//
//  Created by mac on 17/4/10.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol detailBodyViewDelegate <NSObject>

- (void)showImageScrollerViewArr:(NSArray *)arr index:(NSInteger )index;

@end

@interface DetailBodyView : UIView
@property (nonatomic , weak) id<detailBodyViewDelegate> delegate;
@end
