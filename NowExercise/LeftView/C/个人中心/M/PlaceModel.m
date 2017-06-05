//
//  PlaceModel.m
//  NowExercise
//
//  Created by 朱学森 on 2017/5/9.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "PlaceModel.h"

@implementation PlaceModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _placeID = [value integerValue];
    }
    if ([key isEqualToString:@"default"]) {
        _default_place = [value boolValue];
    }
}
@end
