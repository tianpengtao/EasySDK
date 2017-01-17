//
//  DialogManager.h
//  EasySDKExample
//
//  Created by 田鹏涛 on 2017/1/17.
//  Copyright © 2017年 tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DialogManager : NSObject
/**
 *  @author 田鹏涛, 15-05-07 11:05:43
 *
 *  显示hud,默认延迟两秒
 *
 *  @param label 提示语
 */
+ (void)showDlg:(NSString *)label yOffset:(CGFloat)yOffset;


/**
 *  @author 田鹏涛, 15-05-07 11:05:43
 *
 *  显示hud,默认延迟两秒
 *
 *  @param label 提示语
 */
+ (void)showDlg:(NSString *)label;
/**
 *  @author 田鹏涛, 15-05-07 11:05:43
 *
 *  显示hud,默认延迟两秒
 *
 *  @param view  父view
 *  @param label 提示语
 */
+ (void)showDlg:(UIView *)view  withLabel:(NSString *)label;

/**
 *  @author 田鹏涛, 15-05-07 11:05:47
 *
 *  显示hud
 *
 *  @param view       父view
 *  @param label      提示语
 *  @param afterDelay 显示多少时间
 */
+ (void)showDlg:(UIView *)view  withLabel:(NSString *)label afterDelay:(NSTimeInterval)afterDelay;


@end
