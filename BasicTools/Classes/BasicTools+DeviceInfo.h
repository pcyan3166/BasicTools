//
//  BasicTools+DeviceInfo.h
//  BasicTools
//
//  Created by pengchao yan on 2020/8/3.
//

#import "BasicTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface BasicTools (DeviceInfo)

/// 当前操作系统类型
+ (NSString *)osType;

/// 操作系统版本
+ (NSString *)osVersion;

/// 设备品牌
+ (NSString *)deviceBrand;

/// 设备具体型号
+ (NSString *)deviceType;

/// 当前网络条件
+ (NSString *)networkType;

/// 设备号
+ (NSString *)deviceId;

@end

NS_ASSUME_NONNULL_END
