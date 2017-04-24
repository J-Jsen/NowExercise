//
//  HttpRequest.h
//  NowExerciseipad
//
//  Created by mac on 16/10/27.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//typedef void(^progressBlock)(NSProgress * downloadProgress);
//typedef void(^successBlock)(id data);
//typedef void(^failBlock)(NSError * error);



@interface HttpRequest : NSObject

+ (void)GetHttpwithUrl:(NSString *)url parameters:(NSDictionary *)parameters andsuccessBlock:(void(^)(NSDictionary * responseObject))successBlock andfailBlock:(void(^)(NSError * error))failBlock;


+ (void)PostHttpwithUrl:(NSString *)url andparameters:(NSDictionary *)parameters andProgress:(void(^)(NSProgress *progress))progress andsuccessBlock:(void(^)(NSDictionary * responseObject))successBlock andfailBlock:(void(^)(NSError * error))failBlock;

+ (void)showAlertCatController:(UIViewController *)viewcontroller andmessage:(NSString *)message;

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width;

/**
 是否是手机号

 @param textString 验证的字符串
 @return 返回是否
 */
+ (BOOL)phoneValidateNumber:(NSString *) textString;
+ (void)showAlert;
@end
