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

/// 全局单例对象
+ (instancetype)shareInstance;

/// 开始监控网络
- (void)startMonitor;

/// 当前网络状态
- (NSString *)currentStatus;

@end

NS_ASSUME_NONNULL_END
