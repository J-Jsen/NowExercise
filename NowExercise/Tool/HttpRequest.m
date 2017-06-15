//
//  HttpRequest.m
//  NowExerciseipad
//
//  Created by mac on 16/10/27.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "HttpRequest.h"
@implementation HttpRequest

+ (AFHTTPSessionManager *)sharemanager{
    static AFHTTPSessionManager *sharemanager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharemanager = [AFHTTPSessionManager manager];
    });
    
    // 2.设置返回类型
    sharemanager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    sharemanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];
    sharemanager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置请求类型
    [sharemanager.requestSerializer setValue:@"application/json;version=4.0" forHTTPHeaderField:@"Accept"];
    [sharemanager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"PLATFORM"];
    return sharemanager;
    
}

//下载任务
//+ (void)downloadTaskWithURL:(NSString *)url andwithProgress:(progressBlock *)progress andwithpath:(NSString *)path andSuccess:(successBlock *)successBlock andfail:(failBlock)failBlock{
//    
//        //1.创建管理者对象
//    AFHTTPSessionManager * manager = [HttpRequest sharemanager];
//        //2.确定请求的URL地址
//    NSURL * URL = [NSURL URLWithString:url];
//        //3.创建请求对象
//    NSURLRequest * request = [NSURLRequest requestWithURL:URL];
//    //下载任务
//    NSURLSessionTask * task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        
//        
//        
//        
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        
//        if (error) {
//            failBlock(error);
//        }else{
//  
//        }
//        
//    }];
//    
//    
//    
//}
//get请求
+ (void)GetHttpwithUrl:(NSString *)url parameters:(NSDictionary *)parameters andsuccessBlock:(void(^)(NSDictionary * responseObject))successBlock andfailBlock:(void(^)(NSError * error))failBlock{
    
            // 1.创建管理者对象
    AFHTTPSessionManager * manager = [HttpRequest sharemanager];
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
   
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([[dataDic objectForKey:@"rc"] integerValue] == 0 || [[dataDic objectForKey:@"rc"] integerValue] == 3) {
            successBlock(dataDic);
        }else{
            [SRAlertView sr_showAlertViewWithTitle:@"提示" message:[dataDic objectForKey:@"msg"] leftActionTitle:@"确定" rightActionTitle:nil animationStyle:AlertViewAnimationZoom selectAction:nil];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        failBlock(error);
    }];
  
    
}
//post请求
+ (void)PostHttpwithUrl:(NSString *)url andparameters:(NSDictionary *)parameters andProgress:(void(^)(NSProgress * _Nonnull progress))progress andsuccessBlock:(void(^)(NSDictionary * responseObject))successBlock andfailBlock:(void(^)(NSError * error))failBlock{
    
    AFHTTPSessionManager * manager = [HttpRequest sharemanager];
//    NSLog(@"加载:%@",url);
//    NSLog(@"字典:%@",parameters);
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
       
//        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([[dataDic objectForKey:@"rc"] integerValue] == 0 || [[dataDic objectForKey:@"rc"] integerValue] == 3) {
            successBlock(dataDic);
        }else{
            [SRAlertView sr_showAlertViewWithTitle:@"提示" message:[dataDic objectForKey:@"msg"] leftActionTitle:@"确定" rightActionTitle:nil animationStyle:AlertViewAnimationZoom selectAction:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
//        NSLog(@"问题:%@",error);
        [HttpRequest showAlertWithTitle:@"服务器开小差了..."];
    }];
}

+ (void)postHttpwithUrl:(NSString *)url andparameters:(NSDictionary *)parameters andProgress:(void(^)(NSProgress * _Nonnull progress))progress andsuccessBlock:(void(^)(NSDictionary * responseObject))successBlock andfailBlock:(void(^)(NSError * error))failBlock{
    
    AFHTTPSessionManager * manager = [HttpRequest sharemanager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    NSLog(@"加载:%@",url);
//    NSLog(@"字典:%@",parameters);
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([[dataDic objectForKey:@"rc"] integerValue] == 0 || [[dataDic objectForKey:@"rc"] integerValue] == 3) {
            successBlock(dataDic);
        }else{
            [SRAlertView sr_showAlertViewWithTitle:@"提示" message:[dataDic objectForKey:@"msg"] leftActionTitle:@"确定" rightActionTitle:nil animationStyle:AlertViewAnimationZoom selectAction:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
//        NSLog(@"问题:%@",error);
        [HttpRequest showAlertWithTitle:@"服务器开小差了..."];
    }];
}

#pragma mark Http的POST请求
+ (void)postWithUrl:(NSString*)urlStr params:(NSDictionary*)params body:(NSArray *)body progress:(void(^)(NSProgress * _Nonnull progress))progress success:(void(^)(NSDictionary * responseObject))success{
    AFHTTPSessionManager * manager = [HttpRequest sharemanager];
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
        
        if (body) {
            for (NSDictionary *dict in body) {
                
                NSString *name = [dict allKeys][0];
                [formData appendPartWithFileData:dict[name] name:name fileName:@"upload.png" mimeType:@"png"];
            }
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        progress(uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([[dataDic objectForKey:@"rc"] integerValue] == 0 || [[dataDic objectForKey:@"rc"] integerValue] == 3) {
            success(dataDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [HttpRequest showAlertWithTitle:@"服务器开小差了..."];
    }];
}

//上传本地文件
//+ (void)Postlocalfilewithurl:(NSString *)url andparameters:(NSDictionary *)parameters and

//无事件提示框
+ (void)showAlertCatController:(UIViewController *)viewcontroller andmessage:(NSString *)message{
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    [alertC addAction:action];
    
    [viewcontroller presentViewController:alertC animated:YES completion:nil];
}
+ (void)showAlert{
    [HttpRequest showAlertWithTitle:@"服务器开小差了..."];
}
/// 根据指定文本,字体和最大宽度计算尺寸
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return size;
}
//是否是手机号
+ (BOOL)phoneValidateNumber:(NSString *) textString
{
    NSString* number=@"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}

+ (void)showAlertWithTitle:(NSString *)title {
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
//    hud.activityIndicatorColor = [UIColor blueColor];
    hud.color = [UIColor blackColor];
    hud.labelText = title;
    hud.labelFont = [UIFont boldSystemFontOfSize:17];
    hud.dimBackground = YES;
    [hud setColor:MAKA_JIN_COLOR];
    hud.labelColor = [UIColor blackColor];
    hud.minSize = CGSizeMake(SCREEN_W * 0.5, HEIGHT_6(90));
    [hud hide:YES afterDelay:2];
}
//判断是否登录
+ (BOOL)judgeWhetherUserLogin {
    
    NSHTTPCookieStorage* sharedHTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* cookies = [sharedHTTPCookieStorage cookiesForURL:[NSURL URLWithString:BASEURL]];
    BOOL yesOrNo = NO;
    
    NSLog(@"cookies %@",cookies);
    for (NSHTTPCookie *cookie in cookies) {
        
            NSLog(@"cookie %@",cookie.properties);
        
        if (![cookie.value isEqualToString:@"0"]&&[cookie.name isEqualToString:@"uid"]) {
            yesOrNo = YES;
        }
        
    }
    NSLog(@"yesOrNO %d",yesOrNo);
    return yesOrNo;
    
}

@end
