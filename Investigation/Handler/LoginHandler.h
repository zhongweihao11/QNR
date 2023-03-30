//
//  LoginHandler.h
//  Investigation
//
//  Created by mutou on 2023/02/22.
//

#import "BaseHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginHandler : BaseHandler

//ログイン
+ (void)loginWithUuid:(NSString *)uuid name:(NSString *)name prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//fcmTokenをアップロード
+ (void)uploadFcmToken:(NSString *)fcmToken prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

+ (void)checkVersionPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

@end

NS_ASSUME_NONNULL_END
