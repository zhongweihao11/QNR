

#import <Foundation/Foundation.h>
#import "RTHttpClient.h"
#import "ErrorMessageEntity.h"

/// NSError userInfo key that will contain response data
#define JSONResponseSerializerWithDataKey @"JSONResponseSerializerWithDataKey"

#define CompleteBlockErrorCode  -1
/**
 *  Handler処理完了後に呼び出したBlock
 */
typedef void (^CompleteBlock)();

/**
 *  Handler処理が成功した時に呼び出すBlock
 */
typedef void (^SuccessBlock)(id obj);
//リストタイプインターフェース，戻り時にcountを付ける
typedef void (^SuccessPlusBlock)(NSDictionary *otherInfo, id obj);

/**
 *  Handler処理に失敗した時に呼び出したBlock
 */
typedef void (^FailedBlock)(NSInteger statusCode, id json);

//_____________________________________________________________________________
@interface BaseHandler : NSObject

/**
 *  異常エラー処理
 *
 *  @param task
 *  @param error
 *  @param failed
 */
+ (void)handlerErrorWithTask:(NSURLSessionDataTask *)task error:(NSError *)error complete:(FailedBlock)failed;

/**
 * jsonのstatus Codeを取得します。
 *
 *  @param task
 */
+ (NSInteger)statusCodeWithTask:(NSURLSessionDataTask *)task;


@end
