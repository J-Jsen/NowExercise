//
//  UIImageView+Suger.m
//  NowExercise
//
//  Created by mac on 17/4/6.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "UIImageView+Suger.h"

@implementation UIImageView (Suger)
- (instancetype)initImageView{
    if (self = [super init]) {
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundColor = THEMECOLOR;
    }
    return self;
}
@end
