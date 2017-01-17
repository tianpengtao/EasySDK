//
//  DialogManager.m
//  EasySDKExample
//
//  Created by 田鹏涛 on 2017/1/17.
//  Copyright © 2017年 tian. All rights reserved.
//

#import "DialogManager.h"
#import "MBProgressHUD.h"

@implementation DialogManager
+ (void)showDlg:(NSString *)label
{
  [self showDlg:[[UIApplication sharedApplication].delegate window] withLabel:label];
}
+ (void)showDlg:(NSString *)label yOffset:(CGFloat)yOffset
{
  [self showDlg:[UIApplication sharedApplication].delegate.window withLabel:label afterDelay:2 yOffset:yOffset];
  
}
+ (void)showDlg:(UIView *)view  withLabel:(NSString *) label
{
  [self showDlg:view withLabel:label afterDelay:2];
}

+ (void)showDlg:(UIView *)view  withLabel:(NSString *)label afterDelay:(NSTimeInterval)afterDelay
{
  
  [self showDlg:view withLabel:label afterDelay:afterDelay yOffset:150.0];
  
}
+ (void)showDlg:(UIView *)view  withLabel:(NSString *)label afterDelay:(NSTimeInterval)afterDelay yOffset:(CGFloat)yOffset
{
  dispatch_async(dispatch_get_main_queue(), ^
                 {
                   MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
                   [view addSubview:hud];
                   hud.mode = MBProgressHUDModeText;
                   hud.label.font = [UIFont systemFontOfSize:16];
                   hud.label.text = label;
                   hud.margin = 5.f;
                   hud.bezelView.layer.cornerRadius = 5.f;
                   CGPoint offset=CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, yOffset);
                   hud.offset = offset;
                   [hud showAnimated:YES];
                   [hud hideAnimated:YES afterDelay:afterDelay];
                 });
}

@end
