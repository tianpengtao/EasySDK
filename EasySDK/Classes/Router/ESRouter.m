//
//  ESRouter.m
//  Pods
//
//  Created by 田鹏涛 on 2017/1/24.
//
//

#import "ESRouter.h"
#import "HHRouter.h"
@implementation ESRouter
+ (instancetype)shared
{
  static ESRouter *router = nil;
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
    if (!router) {
      router = [[self alloc] init];
    }
  });
  return router;
}

- (void)map:(NSString *)route toControllerClass:(Class)controllerClass
{
  [[HHRouter shared] map:route toControllerClass:controllerClass];
}

- (UIViewController *)matchController:(NSString *)route
{
  return [[HHRouter shared] matchController:route];
}

- (void)map:(NSString *)route toBlock:(ESRouterBlock)block
{

  [[HHRouter shared] map:route toBlock:block];
}


- (ESRouterBlock)matchBlock:(NSString *)route
{
  return (ESRouterBlock)[[HHRouter shared] matchBlock:route];
}
- (id)callBlock:(NSString *)route
{
  return [[HHRouter shared] callBlock:route];
}

- (ESRouteType)canRoute:(NSString *)route
{
  return (ESRouteType*)[[HHRouter shared] canRoute:route];
}
@end
