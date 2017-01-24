//
//  UIViewController+ESCategory.m
//  EasySDKExample
//
//  Created by 田鹏涛 on 2017/1/17.
//  Copyright © 2017年 tian. All rights reserved.
//

#import "UIViewController+ESCategory.h"
#import <objc/runtime.h>
@implementation UIViewController (ESCategory)
+(void)configStyle
{

}
+ (void)load
{
  
 
  SEL viewWillAppearSel = @selector(viewWillAppear:);
  SEL es_viewWillAppearSel = @selector(es_viewWillAppear:);
  [self swizzleMethods:[self class] originalSelector:viewWillAppearSel swizzledSelector:es_viewWillAppearSel];
  
  SEL viewDidAppearSel = @selector(viewDidAppear:);
  SEL es_viewDidAppearSel = @selector(es_viewDidAppear:);
  [self swizzleMethods:[self class] originalSelector:viewDidAppearSel swizzledSelector:es_viewDidAppearSel];
  
  SEL viewWillDisappearSel = @selector(viewWillDisappear:);
  SEL es_viewWillDisappearSel = @selector(es_viewWillDisappear:);
  [self swizzleMethods:[self class] originalSelector:viewWillDisappearSel swizzledSelector:es_viewWillDisappearSel];

  SEL viewDidDisappearSel = @selector(viewDidDisappear:);
  SEL es_viewDidDisappearSel = @selector(es_viewDidDisappear:);
  [self swizzleMethods:[self class] originalSelector:viewDidDisappearSel swizzledSelector:es_viewDidDisappearSel];
  
  SEL viewDidLoadSel = @selector(viewDidLoad);
  SEL es_viewDidLoadSel = @selector(es_viewDidLoad);
  [self swizzleMethods:[self class] originalSelector:viewDidLoadSel swizzledSelector:es_viewDidLoadSel];
  
  
}

//exchange implementation of two methods
+ (void)swizzleMethods:(Class)class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel
{
  Method origMethod = class_getInstanceMethod(class, origSel);
  Method swizMethod = class_getInstanceMethod(class, swizSel);
  
  //向此类中添加原函数
  BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
  
  //原函数不存在
  if (didAddMethod)
  {
    class_replaceMethod(class, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
  }
  //原函数已存在
  else
  {
    method_exchangeImplementations(origMethod, swizMethod);
  }
}

- (void)es_viewWillAppear:(BOOL)animated
{
  NSLog(@"I am in - [es_viewWillAppear:]");
  //handle viewController transistion counting here, before ViewController instance calls its -[viewDidAppear:] method
  //需要注入的代码写在此处
  [self es_viewWillAppear:animated];
}

- (void)es_viewDidAppear:(BOOL)animated
{
  NSLog(@"I am in - [es_viewDidAppear:]");
  //handle viewController transistion counting here, before ViewController instance calls its -[viewDidAppear:] method
  //需要注入的代码写在此处
  [self es_viewDidAppear:animated];
}

- (void)es_viewWillDisappear:(BOOL)animated
{
  NSLog(@"I am in - [es_viewWillDisappear:]");
  //handle viewController transistion counting here, before ViewController instance calls its -[viewDidAppear:] method
  //需要注入的代码写在此处
  [self es_viewWillDisappear:animated];
}

- (void)es_viewDidDisappear:(BOOL)animated
{
  NSLog(@"I am in - [es_viewDidDisappear:]");
  //handle viewController transistion counting here, before ViewController instance calls its -[viewDidAppear:] method
  //需要注入的代码写在此处
  [self es_viewDidDisappear:animated];
}

- (void)es_viewDidLoad
{
  NSLog(@"I am in - [es_viewDidLoad:]");
  //handle viewController transistion counting here, before ViewController instance calls its -[viewDidAppear:] method
  //需要注入的代码写在此处
  [self es_viewDidLoad];
}



@end
