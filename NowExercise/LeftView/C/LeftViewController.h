//
//  LeftViewController.h
//  NowExercise
//
//  Created by mac on 17/1/19.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MenuDelegate <NSObject>

- (void)PushViewControllerWithKey:(NSInteger)key;


@end

@interface LeftViewController : UIViewController

@property (nonatomic , assign) id<MenuDelegate> delegate;


@end
