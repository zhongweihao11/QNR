

#import "UserDefaultsUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserStorage : UserDefaultsUtils

+ (void)saveUuid:(NSString *)uuid;
+ (NSString *)uuid;

+ (void)saveName:(NSString *)name;
+ (NSString *)name;

+ (void)saveUserId:(NSInteger)userId;
+ (NSString *)userId;

+ (void)saveToken:(NSString *)token;
+ (NSString *)token;

@end

NS_ASSUME_NONNULL_END
