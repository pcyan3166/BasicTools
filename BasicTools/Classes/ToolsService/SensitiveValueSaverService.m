//
//  SensitiveValueSaverService.m
//  BasicTools
//
//  Created by pengchao yan on 2020/8/12.
//

#import "SensitiveValueSaverService.h"
#import "BasicTools+AppInfo.h"
#import <SAMKeychain/SAMKeychain.h>

@implementation SensitiveValueSaverService

+ (instancetype)shareInstance {
    static SensitiveValueSaverService *sInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sInstance = [[SensitiveValueSaverService alloc] init];
    });
    
    return sInstance;
}

- (void)saveStringValue:(NSString * _Nullable)string forKey:(NSString *)key {
    if (string == nil) {
        [SAMKeychain deletePasswordForService:[BasicTools appId] account:key];
    } else {
        [SAMKeychain setPassword:string forService:[BasicTools appId] account:key];
    }
}

- (void)saveNumberValue:(NSNumber * _Nullable)number forKey:(NSString *)key {
    if (number == nil) {
        [SAMKeychain deletePasswordForService:[BasicTools appId] account:key];
    } else {
        [self saveStringValue:[number stringValue] forKey:key];
    }
}

- (void)saveStringsArrayValue:(NSArray<NSString *> * _Nullable)stringsArray
                       forKey:(NSString *)key {
    if (stringsArray == nil) {
        [SAMKeychain deletePasswordForService:[BasicTools appId] account:key];
    } else {
        NSString *separateStr = [stringsArray componentsJoinedByString:@","];
        [self saveStringValue:separateStr forKey:key];
    }
}

- (void)saveNumbersArrayValue:(NSArray<NSNumber *> * _Nullable)numbersArray
                       forKey:(NSString *)key {
    if (numbersArray == nil) {
        [SAMKeychain deletePasswordForService:[BasicTools appId] account:key];
    } else {
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:numbersArray.count];
        for (NSNumber *number in numbersArray) {
            [mArray addObject:[number stringValue]];
        }
        
        [self saveStringsArrayValue:mArray forKey:key];
    }
}

- (NSString * _Nullable)getStringValueForKey:(NSString *)key {
    return [SAMKeychain passwordForService:[BasicTools appId] account:key];
}

- (NSNumber * _Nullable)getNumberValueForKey:(NSString *)key {
    NSString *strValue = [self getStringValueForKey:key];
    if (strValue != nil) {
        NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
        fmt.numberStyle = NSNumberFormatterDecimalStyle;
        return [fmt numberFromString:strValue];
    }
    
    return nil;
}

- (NSArray<NSString *> * _Nullable)getStringsArrayValueForKey:(NSString *)key {
    NSString *strValue = [self getStringValueForKey:key];
    if (strValue != nil) {
        return [strValue componentsSeparatedByString:@","];
    }
    
    return nil;
}

- (NSArray<NSNumber *> * _Nullable)getNumbersArrayValueForKey:(NSString *)key {
    NSString *strValue = [self getStringValueForKey:key];
    if (strValue != nil) {
        NSArray *strsArray = [strValue componentsSeparatedByString:@","];
        NSMutableArray<NSNumber *> *numsArray = [NSMutableArray arrayWithCapacity:strsArray.count];
        
        NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
        fmt.numberStyle = NSNumberFormatterDecimalStyle;
        for (NSString *str in strsArray) {
            NSNumber *num = [fmt numberFromString:str];
            if (num != nil) {
                [numsArray addObject:num];
            }
        }
        
        return numsArray;
    }
    
    return nil;
}

- (void)clearData {
    NSArray *accountsArray = [SAMKeychain accountsForService:[BasicTools appId]];
    if (accountsArray.count > 0) {
        for (NSString *account in accountsArray) {
            [SAMKeychain deletePasswordForService:[BasicTools appId] account:account];
        }
    }
}

@end
