//
//  NameViewController.h
//  NowExercise
//
//  Created by 朱学森 on 2017/5/8.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NameViewDelegate <NSObject>

- (void)NameStr:(NSString *)name;

@end

@interface NameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (nonatomic , copy) NSString * name;
@property (nonatomic , assign) void(^nameBackBlock)(NSString * name);
@property (nonatomic , weak) id<NameViewDelegate>delegate;
@end
