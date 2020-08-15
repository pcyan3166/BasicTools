//
//  NetworkService.h
//  BasicTools
//
//  Created by pengchao yan on 2020/8/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define BTNetworkStatusChangedNotification    @"BTNetworkStatusChangedNotificationKey"

@interface NetworkService : NSObject

/// 全局单例对象（比较粗犷，只能识别无网络、WIFI、移动网络三种）
+ (instancetype)shareInstance;

/// 全局单例对象（比较细致，能区分更多网络类型：3G、2G）
+ (instancetype)micromeshShareInstance;

/// 当前网络状态
@property (nonatomic, strong) NSString *networkStatus;

/// 开始监控网络
- (void)startMonitor;

@end

NS_ASSUME_NONNULL_END
