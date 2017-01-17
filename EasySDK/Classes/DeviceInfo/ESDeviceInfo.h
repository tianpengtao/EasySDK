//
//  ESDeviceInfo.h
//  EasySDKExample
//
//  Created by 田鹏涛 on 2016/12/12.
//  Copyright © 2016年 tian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESDeviceInfo : NSObject
//得到设备版本
+ (NSString *)deviceModel;

//系统版本
+ (CGFloat)systemVersion;

// 屏幕宽度
+ (NSInteger)screenWidth;

// 屏幕高度
+ (NSInteger)screenHeight;

// 设备类型
+ (NSString *)systemDeviceTypeFormatted:(BOOL)formatted;


//磁盘信息

// 总磁盘空间 e.g. 5.20G
+ (NSString *)diskSpace;

// 总的可用磁盘空间 e.g. 50%
+ (NSString *)freeDiskSpace:(BOOL)inPercent;

// 总使用的磁盘空间  e.g. 50%
+ (NSString *)usedDiskSpace:(BOOL)inPercent;

// 总磁盘空间 bytes
+ (long long)longDiskSpace;

// 可用磁盘空间 bytes
+ (long long)longFreeDiskSpace;

@end
