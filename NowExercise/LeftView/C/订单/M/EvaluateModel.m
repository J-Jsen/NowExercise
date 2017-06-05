//
//  EvaluateModel.m
//  NowExercise
//
//  Created by Suger on 17/6/2.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "EvaluateModel.h"

@implementation EvaluateModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = [value integerValue];
    }
}
@end
