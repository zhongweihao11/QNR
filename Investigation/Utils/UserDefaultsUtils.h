

#import <Foundation/Foundation.h>

@interface UserDefaultsUtils : NSObject

+(void)saveValue:(id) value forKey:(NSString *)key;

+(id)valueWithKey:(NSString *)key;

+(BOOL)boolValueWithKey:(NSString *)key;

+(void)saveBoolValue:(BOOL)value withKey:(NSString *)key;

+(void)print;

+(void)saveObject:(id)object forKey:(NSString *)key;

+(id)objectWithKey:(NSString *)key;

+(void)saveNSInteger:(NSInteger)integer forKey:(NSString *)key;

+(void)saveDoubleValue:(double)value forKey:(NSString *)key;

+(double)doubleValueWithKey:(NSString *)key;

+(NSInteger)integerWithKey:(NSString *)key;

@end
