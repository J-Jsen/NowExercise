//
//  ClassModel.h
//  NowExercise
//
//  Created by 朱学森 on 2017/5/9.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassModel : NSObject

DIC_PROPERTY(userInfo)
ARRAY_PROPERTY(pre_times)
DIC_PROPERTY(freecourse)
INTEGER_PROPERTY(package_balance)
INTEGER_PROPERTY(class_id)
INTEGER_PROPERTY(fun_id)
STRING_PROPERTY(class_name);
ARRAY_PROPERTY(course)


@end
