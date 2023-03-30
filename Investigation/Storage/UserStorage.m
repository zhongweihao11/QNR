

#import "UserStorage.h"
#import <SAMKeychain/SAMKeychain.h>

static NSString * const USER_UUID = @"userUuid";
static NSString * const USER_NAME = @"userName";
static NSString * const USER_ID = @"userId";
static NSString * const USER_TOKEN = @"userToken";


@implementation UserStorage

+ (void)saveUuid:(NSString *)uuid {
  [SAMKeychain setPassword:uuid forService:USER_UUID account:USER_UUID];
}

+ (NSString *)uuid {
  return [SAMKeychain passwordForService:USER_UUID account:USER_UUID];
}

+ (void)saveName:(NSString *)name {
  [SAMKeychain setPassword:name forService:USER_NAME account:USER_NAME];
}

+ (NSString *)name {
  return [SAMKeychain passwordForService:USER_NAME account:USER_NAME];
}

+ (void)saveUserId:(NSInteger)userId {
    [SAMKeychain setPassword:[NSString stringWithFormat:@"%ld",userId] forService:USER_ID account:USER_ID];
}

+ (NSString *)userId {
    return [SAMKeychain passwordForService:USER_ID account:USER_ID];
}

+ (void)saveToken:(NSString *)token {
    [UserDefaultsUtils saveValue:token forKey:USER_TOKEN];
}

+ (NSString *)token {
    return [UserDefaultsUtils valueWithKey:USER_TOKEN];
}

@end
