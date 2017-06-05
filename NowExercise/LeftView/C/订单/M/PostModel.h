//
//  PostModel.h
//  NowExercise
//
//  Created by Suger on 17/6/2.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostModel : NSObject

STRING_PROPERTY(order_id)
STRING_PROPERTY(conent)
STRING_PROPERTY(star)
ARRAY_PROPERTY(question)

@end
