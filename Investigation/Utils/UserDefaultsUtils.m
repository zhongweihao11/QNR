

#import "UserDefaultsUtils.h"

@implementation UserDefaultsUtils

+(void)saveValue:(id) value forKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}

+(id)valueWithKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

+(BOOL)boolValueWithKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:key];
}

+(void)saveBoolValue:(BOOL)value withKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:key];
    [userDefaults synchronize];
}

+(void)print{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
}

+(void)saveObject:(id)object forKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //studentタイプをNSDataタイプに変更します。
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [userDefaults setObject:data forKey:key];
    [userDefaults synchronize];
}

+(id)objectWithKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+(void)saveNSInteger:(NSInteger)integer forKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:integer forKey:key];
    [userDefaults synchronize];
}

+(void)saveDoubleValue:(double)value forKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setDouble:value forKey:key];
    [userDefaults synchronize];
}

+(double)doubleValueWithKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger data = [userDefaults doubleForKey:key];
    return data;
}

+(NSInteger)integerWithKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger data = [userDefaults integerForKey:key];
    return data;
}

@end
