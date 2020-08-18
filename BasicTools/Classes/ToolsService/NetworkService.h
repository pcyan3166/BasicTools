//
//  NetworkService.h
//  BasicTools
//
//  Created by pengchao yan on 2020/8/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define BTNetworkStatusChangedNotification    @"BTNetworkStatusChangedNotificationKey"

typedef NS_ENUM(NSInteger, ENetworkStatus) {
    eNetworkStatusNotReachable = 0,
    eNetworkStatus2G,
    eNetworkStatus3G,
    eNetworkStatus4G,
    eNetworkStatusMobileNetwork,
    eNetworkStatusWifi,
    eNetworkStatusUnkown
};

@interface NetworkService : NSObject

/// 全局单例对象（比较粗犷，只能识别无网络、WIFI、移动网络三种）
+ (instancetype)shareInstance;

/// 全局单例对象（比较细致，能区分更多网络类型：3G、2G）
+ (instancetype)micromeshShareInstance;

/// 当前网络状态
@property (nonatomic, assign) ENetworkStatus networkStatus;

/// 开始监控网络
- (void)startMonitor;

/// 根据状态枚举值给出网络状态描述字符串
/// @param networkStatus 网络状态枚举值
+ (NSString *)descriptionForNetworkStatus:(ENetworkStatus)networkStatus;

@end

NS_ASSUME_NONNULL_END
