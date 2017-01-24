//
//  ESSecurityManager.h
//  Pods
//
//  Created by 田鹏涛 on 2017/1/17.
//
//  模拟器上用

#import <Foundation/Foundation.h>

@interface ESSecurityManager : NSObject
+(instancetype)manager;
-(void)saveUserName:(NSString*)userName passWord:(NSString*)passWord;
-(NSString*)userName;
-(NSString*)passWord;
@end
