//
//  PublicValueSaverService.h
//  BasicTools
//
//  Created by pengchao yan on 2020/8/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublicValueSaverService : NSObject

/// 全局单例对象
+ (instancetype)shareInstance;

/// 保存一个字符串
/// @param string 需要保存的字符串，传 nil 时清除数据
/// @param key 取字符串时的标识
- (void)saveStringValue:(NSString * _Nullable)string forKey:(NSString *)key;

/// 保存一个数字
/// @param number 需要保存的数字，传 nil 时，清除数据
/// @param key 取字符串时的标识
- (void)saveNumberValue:(NSNumber * _Nullable)number forKey:(NSString *)key;

/// 保存一组字符串
/// @param stringsArray 需要保存的字符串数组，传 nil 时清除数据
/// @param key 取字符串时的标识
- (void)saveStringsArrayValue:(NSArray<NSString *> * _Nullable)stringsArray
                       forKey:(NSString *)key;

/// 保存一组数字
/// @param numbersArray 需要保存的数字数组，传 nil 时，清除数据
/// @param key 取字符串时的标识
- (void)saveNumbersArrayValue:(NSArray<NSNumber *> * _Nullable)numbersArray
                       forKey:(NSString *)key;

- (NSString * _Nullable)getStringValueForKey:(NSString *)key;
- (NSNumber * _Nullable)getNumberValueForKey:(NSString *)key;
- (NSArray<NSString *> * _Nullable)getStringsArrayValueForKey:(NSString *)key;
- (NSArray<NSNumber *> * _Nullable)getNumbersArrayValueForKey:(NSString *)key;

/// 清除数据
- (void)clearData;

@end

NS_ASSUME_NONNULL_END
