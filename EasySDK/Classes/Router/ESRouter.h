//
//  ESRouter.h
//  Pods
//
//  Created by 田鹏涛 on 2017/1/24.
//
//
#import <Foundation/Foundation.h>


typedef NS_ENUM (NSInteger, ESRouteType) {
  ESRouteTypeNone = 0,
  ESRouteTypeViewController = 1,
  ESRouteTypeBlock = 2
};

typedef id (^ESRouterBlock)(NSDictionary *params);

@interface ESRouter : NSObject
+ (instancetype)shared;

- (void)map:(NSString *)route toControllerClass:(Class)controllerClass;
- (UIViewController *)matchController:(NSString *)route;
- (void)map:(NSString *)route toBlock:(ESRouterBlock)block;
- (ESRouterBlock)matchBlock:(NSString *)route;
- (id)callBlock:(NSString *)route;
- (ESRouteType)canRoute:(NSString *)route;
@end
