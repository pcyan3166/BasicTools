//
//  BasicTools+AppInfo.h
//  BasicTools
//
//  Created by pengchao yan on 2020/8/3.
//

#import <BasicTools/BasicTools.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicTools (AppInfo)

/// 获取App唯一标识（com.apple.TestFlight）
+ (NSString *)appId;

/// 获取App的版本号（1.0.2）
+ (NSString *)appVersion;

/// 获取App带BuildNumber的完整版本号（1.0.2.333）
+ (NSString *)appFullVersion;

@end

NS_ASSUME_NONNULL_END
