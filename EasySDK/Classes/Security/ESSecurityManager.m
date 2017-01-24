//
//  ESSecurityManager.m
//  Pods
//
//  Created by 田鹏涛 on 2017/1/17.
//
//

#import "ESSecurityManager.h"
static NSString *ESSecurityUserNameKey=@"ESSecurityUserNameKey";
static NSString *ESSecurityPassWordKey=@"ESSecurityPassWordKey";

@interface ESSecurityManager()

@property (readonly, nonatomic) NSString *service;
/**
 *  Access Group for Keychain item sharing. If it's nil no keychain sharing is possible. Default value is nil.
 */
@property (readonly, nullable, nonatomic) NSString *accessGroup;
@end
@implementation ESSecurityManager
+(instancetype)manager
{
  static dispatch_once_t pred;
  static ESSecurityManager *sharedInstance = nil;
  
  dispatch_once(&pred, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

-(void)saveUserName:(NSString*)userName passWord:(NSString*)passWord
{
#if TARGET_IPHONE_SIMULATOR
  if (userName)
  {
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:ESSecurityUserNameKey];
  }
  if (passWord)
  {
    [[NSUserDefaults standardUserDefaults] setObject:passWord forKey:ESSecurityPassWordKey];
  }

#elif TARGET_OS_IPHONE
  
  
#endif
}
-(NSString*)userName
{
#if TARGET_IPHONE_SIMULATOR
 return [[NSUserDefaults standardUserDefaults] objectForKey:ESSecurityUserNameKey];
#elif TARGET_OS_IPHONE
  
  
#endif
}
-(NSString*)passWord
{
#if TARGET_IPHONE_SIMULATOR
  return [[NSUserDefaults standardUserDefaults] objectForKey:ESSecurityPassWordKey];
#elif TARGET_OS_IPHONE
  
  
#endif
}

- (NSData *)dataForKey:(NSString *)key promptMessage:(NSString *)message error:(NSError**)err {
  if (!key) {
    return nil;
  }
  
  NSDictionary *query = [self queryFetchOneByKey:key message:message];
  CFTypeRef data = nil;
  OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &data);
  if (status != errSecSuccess) {
    if(err != nil) {
    }
    return nil;
  }
  
  NSData *dataFound = [NSData dataWithData:(__bridge NSData *)data];
  if (data) {
    CFRelease(data);
  }
  
  return dataFound;
}
- (NSDictionary *)queryFetchOneByKey:(NSString *)key message:(NSString *)message {
  NSMutableDictionary *query = [self baseQuery];
  [query addEntriesFromDictionary:@{
                                    (__bridge id)kSecReturnData: @YES,
                                    (__bridge id)kSecMatchLimit: (__bridge id)kSecMatchLimitOne,
                                    (__bridge id)kSecAttrAccount: key,
                                    }];
#if TARGET_OS_IPHONE
    if (message && floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
      query[(__bridge id)kSecUseOperationPrompt] = message;
    }
#endif
  
  return query;
}
- (NSMutableDictionary *)baseQuery {
  NSMutableDictionary *attributes = [@{
                                       (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                                       (__bridge id)kSecAttrService: self.service,
                                       } mutableCopy];
#if !TARGET_IPHONE_SIMULATOR
  if (self.accessGroup) {
    attributes[(__bridge id)kSecAttrAccessGroup] = self.accessGroup;
  }
#endif
  
  return attributes;
}
@end
