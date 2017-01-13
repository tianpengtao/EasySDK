//
//  ESNetworkingManager.h
//  EasySDKExample
//
//  Created by 田鹏涛 on 2016/12/12.
//  Copyright © 2016年 tian. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *POST = @"POST";
static NSString *GET = @"GET";

@interface ESNetworkingManager : NSObject

/**
 基础参数，每次网络请求都会默认添加基础参数
 */
@property(nonatomic,strong)NSDictionary *baseParameter;

/**
 超时时间，默认120s
 */
@property(nonatomic,assign)NSTimeInterval timeout;

+(instancetype)manager;

/**
 网络请求

 @param method HTTP方法,POST\GET
 @param URLString url字符
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 @return NSURLSessionDataTask对象，一般无用
 */
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

/**
 取消当前正在进行的网络请求
 */
- (void)cancelDataTask;
@end
