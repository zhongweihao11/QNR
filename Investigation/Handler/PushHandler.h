//
//  PushHandler.h
//  Investigation
//
//  Created by mutou on 2023/02/23.
//

#import "BaseHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface PushHandler : BaseHandler

//メッセージ一覧取得
+ (void)getPushListWithPageNo:(NSInteger)pageNo prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//回答の送信
+ (void)submitAnswerWithDic:(NSDictionary *)dic prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

+ (void)sendPushWithPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

+ (void)uploadFileWithPushId:(NSString *)pushId questionnaireId:(NSString *)questionnaireId questionId:(NSString *)questionId fileData:(NSData *)fileData fileType:(NSString *)fileType questionType:(NSNumber *)questionType Prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

@end

NS_ASSUME_NONNULL_END
