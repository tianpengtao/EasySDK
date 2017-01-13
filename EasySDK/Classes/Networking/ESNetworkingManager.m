//
//  ESNetworkingManager.m
//  EasySDKExample
//
//  Created by 田鹏涛 on 2016/12/12.
//  Copyright © 2016年 tian. All rights reserved.
//


#import "ESNetworkingManager.h"

@interface ESNetworkingManager()<NSURLSessionDelegate>
@property (readwrite, nonatomic, strong) NSOperationQueue *operationQueue;
@property (readwrite, nonatomic, strong) NSURLSession *session;

@end
@implementation ESNetworkingManager
+(instancetype)manager
{
    static dispatch_once_t pred;
    static ESNetworkingManager *sharedInstance = nil;
    
    dispatch_once(&pred, ^{
      sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
-(instancetype)init
{
  self=[super init];
  if (self) {
    self.timeout=120;
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.operationQueue.maxConcurrentOperationCount = 1;
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:configuration
                                                 delegate:self
                                            delegateQueue:self.operationQueue];

  }
  return self;
}
-(void)cancelDataTask
{
  [_session invalidateAndCancel];
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
  NSURLRequest *urlRequest=[self configURLRequestWithHTTPMethod:method URLString:URLString parameters:parameters];
  NSURLSessionDataTask * dataTask = [self.session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (error) {
      failure(dataTask,error);
    }else{
      success(dataTask,data);
    }
  }];
  [dataTask resume];
  return dataTask;
}

- (NSURLRequest*)configURLRequestWithHTTPMethod:(NSString *)method
                                     URLString:(NSString *)URLString
                                    parameters:(id)parameters
{
  NSMutableURLRequest *urlRequest=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:_timeout];
  [urlRequest setHTTPMethod:method];
    [urlRequest setValue:@"application/x-www-form-urlencoded"
      forHTTPHeaderField:@"Content-Type"];
    NSMutableDictionary *parameterDic=[[NSMutableDictionary alloc] init];
    [parameterDic setDictionary:_baseParameter];
    [parameterDic setDictionary:parameters];
    NSString *query=[self handleParameter:parameterDic];
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
  if ([method isEqualToString:POST])
  {
    NSData *queryData=[query dataUsingEncoding:NSUTF8StringEncoding];
    [urlRequest setHTTPBody:queryData];
  }
  else
  {
    urlRequest.URL=[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",URLString,query]];
  }
  return urlRequest;
}
- (NSString*)handleParameter:(NSDictionary*)parameters
{
  NSMutableString *parametersStr=[[NSMutableString alloc] init];
  [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
    [parametersStr appendFormat:@"%@=%@&",key,obj];
  }];
  if (parametersStr.length>0) {
    return [parametersStr substringToIndex:parametersStr.length-1];
  }
  return nil;
}
#pragma mark - NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler
{
  // Certificate Authority颁发的证书，直接交给系统去验证是否信任
  if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
    NSURLCredential *cre = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
    // 调用block
    completionHandler(NSURLSessionAuthChallengeUseCredential,cre);
  }
}

@end
