//
//  HomeModel.h
//  NowExercise
//
//  Created by Suger on 17/4/24.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

STRING_PROPERTY(intro)
INTEGER_PROPERTY(func_id)
STRING_PROPERTY(course_name)
STRING_PROPERTY(img)
STRING_PROPERTY(videos)
INTEGER_PROPERTY(class_id)
STRING_PROPERTY(name)
@property (nonatomic , assign) CGFloat Cell_Height;
@end
