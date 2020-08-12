//
//  PublicValueSaverService.m
//  BasicTools
//
//  Created by pengchao yan on 2020/8/12.
//

#import "PublicValueSaverService.h"

@interface PublicValueSaverService ()

@property (nonatomic, strong) NSDictionary *infoDic;

@end

@implementation PublicValueSaverService

+ (instancetype)shareInstance {
    static PublicValueSaverService *sInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sInstance = [[PublicValueSaverService alloc] init];
        sInstance.infoDic = [NSDictionary dictionaryWithContentsOfFile:[sInstance filePathForSave]];
    });
    
    return sInstance;
}

- (void)saveStringValue:(NSString * _Nullable)string forKey:(NSString *)key {
    [self saveData:string forKey:key];
}

- (void)saveNumberValue:(NSNumber * _Nullable)number forKey:(NSString *)key {
    [self saveData:number forKey:key];
}

- (void)saveStringsArrayValue:(NSArray<NSString *> * _Nullable)stringsArray
                       forKey:(NSString *)key {
    [self saveData:stringsArray forKey:key];
}

- (void)saveNumbersArrayValue:(NSArray<NSNumber *> * _Nullable)numbersArray
                       forKey:(NSString *)key {
    [self saveData:numbersArray forKey:key];
}

- (NSString * _Nullable)getStringValueForKey:(NSString *)key {
    return [self dataForKey:key];
}

- (NSNumber * _Nullable)getNumberValueForKey:(NSString *)key {
    return [self dataForKey:key];
}

- (NSArray<NSString *> * _Nullable)getStringsArrayValueForKey:(NSString *)key {
    return [self dataForKey:key];
}

- (NSArray<NSNumber *> * _Nullable)getNumbersArrayValueForKey:(NSString *)key {
    return [self dataForKey:key];
}

- (void)clearData {
    @synchronized (_infoDic) {
        _infoDic = @{};
    }
    
    [self saveDataIntoFile];
}

#pragma mark - private functions

- (void)saveData:(id)data forKey:(NSString *)key {
    if (key.length > 0) {
        @synchronized (_infoDic) {
            NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:_infoDic];
            if (data != nil) {
                mDic[key] = data;
            } else {
                [mDic removeObjectForKey:key];
            }
            _infoDic = mDic;
        }
        
        [self saveDataIntoFile];
    }
}

- (id)dataForKey:(NSString *)key {
    return _infoDic[key];
}

- (void)saveDataIntoFile {
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(saveDataIntoFile:)
                                               object:[self filePathForSave]];
    
    // 3秒延时存储，避免大量调用多次无效写入
    [self performSelector:@selector(saveDataIntoFile:) withObject:[self filePathForSave] afterDelay:3.0];
}

- (void)saveDataIntoFile:(NSString *)filePath {
    if (filePath.length > 0) {
        [_infoDic writeToFile:filePath atomically:YES];
    }
}

- (NSString *)filePathForSave {
    static NSString *validPathForWritten = nil;
    if (validPathForWritten == nil) {
        NSArray *documentpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentRootPath = documentpaths[0];
        validPathForWritten = [documentRootPath stringByAppendingPathComponent:@"BasicTools/PublicValueSaver.plist"];
    }
    
    return validPathForWritten;
}

@end
