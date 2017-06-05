//
//  IconViewController.h
//  NowExercise
//
//  Created by mac on 17/3/23.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IconViewController : UIViewController
@property (nonatomic , copy) void(^iconBackBlock)(UIImage * image);
@property (nonatomic , strong) UIImage * image;

@end
