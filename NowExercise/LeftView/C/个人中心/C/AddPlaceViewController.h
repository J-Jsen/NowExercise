//
//  AddPlaceViewController.h
//  NowExercise
//
//  Created by 朱学森 on 2017/5/9.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddPlaceViewControllerDelegate <NSObject>

- (void)AddPlace;

@end

@interface AddPlaceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *placeTF;
@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;
@property (nonatomic , weak) id <AddPlaceViewControllerDelegate>delegate;
@end
