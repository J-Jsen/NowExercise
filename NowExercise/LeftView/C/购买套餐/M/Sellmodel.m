//
//  Sellmodel.m
//  NowExercise
//
//  Created by Suger on 17/4/27.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "Sellmodel.h"

@implementation Sellmodel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _Sell_id = [value integerValue];
    }
}

@end
