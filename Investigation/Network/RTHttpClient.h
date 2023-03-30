

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//HTTP REQUEST METHOD TYPE
typedef NS_ENUM(NSInteger, RTHttpRequestType) {
    RTHttpRequestGet,
    RTHttpRequestPost,
    RTHttpRequestDelete,
    RTHttpRequestPut,
};

/**
 *  開始前にブロックの前処理を要請します。
 */
typedef void(^PrepareBlock)(void);

/****************   RTHttpClient   ****************/
@interface RTHttpClient : NSObject

+ (RTHttpClient *)defaultClient;

/**
 *  HTTP要求（GET、POST、DELETE、PUT）
 *
 *  @param path
 *  @param method     RESTFul要求の種類
 *  @param parameters 要求パラメータ
 *  @param prepare    要求前前前処理ブロック
 *  @param success    要求成功処理ブロック
 *  @param failure    要求失敗処理ブロック
 */
- (void)requestWithPath:(NSString *)url
                method:(NSInteger)method
            parameters:(id)parameters
               prepare:(PrepareBlock)prepare
               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 *  HTTP要求（GET、POST、DELETE、PUT）
 *
 *  @param path
 *  @param method     RESTFul要求の種類
 *  @param parameters 要求パラメータ
 *  @param prepare    要求前前前処理ブロック
 *  @param success    要求成功処理ブロック
 *  @param failure    要求失敗処理ブロック
 */
- (void)requestBodyPostWithPath:(NSString *)url
             jsonParameters:(id)parameters
                prepare:(PrepareBlock)prepare
                success:(void (^)(NSURLSessionDataTask *, id))success
                failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(id)parameters
                keyName:(NSString *)key
               fileName:(NSString *)fileName
                   data:(NSData *)fileData
                prepare:(PrepareBlock)prepare
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
