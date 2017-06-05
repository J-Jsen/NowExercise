//
//  UserModel.h
//  NowExercise
//
//  Created by 朱学森 on 2017/5/5.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic , strong) NSMutableArray * address;
STRING_PROPERTY(user_id);
STRING_PROPERTY(nickname);
STRING_PROPERTY(headimg);
INTEGER_PROPERTY(weight);
INTEGER_PROPERTY(height);
INTEGER_PROPERTY(balance);
STRING_PROPERTY(birthday);
INTEGER_PROPERTY(gender);


@end
