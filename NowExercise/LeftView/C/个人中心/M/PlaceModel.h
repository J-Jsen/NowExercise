//
//  PlaceModel.h
//  NowExercise
//
//  Created by 朱学森 on 2017/5/9.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceModel : NSObject
//default	true
//id	45
//address
@property (nonatomic , assign) BOOL default_place;
INTEGER_PROPERTY(placeID);
STRING_PROPERTY(address);

@end
