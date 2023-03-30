//
//  PushHandler.m
//  Investigation
//
//  Created by mutou on 2023/02/23.
//

#import "PushHandler.h"
#import "PushListEntity.h"

@implementation PushHandler

+ (void)getPushListWithPageNo:(NSInteger)pageNo prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed {
    
    NSString *str_url = [SERVER_HOST stringByAppendingString:API_GET_PUSH_LIST];
    NSDictionary *dic = @{@"pageNo":[NSNumber numberWithInteger:pageNo]};
    [[RTHttpClient defaultClient] requestBodyPostWithPath:str_url
                                           jsonParameters:dic
                                                  prepare:prepare
                                                  success:^(NSURLSessionDataTask *task, id responseObject) {
        if([[(NSDictionary *)responseObject objectForKey:@"status"] intValue] == 0) {
            NSArray *arr_data = [PushListEntity pushListInfoWithJson:[(NSDictionary *)responseObject objectForKey:@"data"]];
            success(arr_data);
        } else {
            ErrorMessageEntity *entity = [ErrorMessageEntity parseErrorMessageEntityWithJson:[responseObject objectForKey:@"message"]];
            failed([[responseObject objectForKey:@"status"] intValue],entity.messageContent);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(ERROR_NETWORK_CODE,ERROR_NETWORK);
    }];
    
}

+ (void)submitAnswerWithDic:(NSDictionary *)dic prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed {
    
    NSString *str_url = [SERVER_HOST stringByAppendingString:API_SUBMIT_ANSWER];
    [[RTHttpClient defaultClient] requestBodyPostWithPath:str_url
                                           jsonParameters:dic
                                                  prepare:prepare
                                                  success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[(NSDictionary *)responseObject objectForKey:@"status"] intValue] == 0) {
            success(responseObject);
        } else {
            ErrorMessageEntity *entity = [ErrorMessageEntity parseErrorMessageEntityWithJson:[responseObject objectForKey:@"message"]];
            failed([[responseObject objectForKey:@"status"] intValue],entity.messageContent);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(ERROR_NETWORK_CODE,ERROR_NETWORK);
    }];
    
}

+ (void)sendPushWithPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed {
    NSString *str_url = [SERVER_HOST stringByAppendingString:API_SEND_PUSH];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
        if([[(NSDictionary *)responseObject objectForKey:@"status"] intValue] == 0) {
            success(responseObject);
        } else {
            ErrorMessageEntity *entity = [ErrorMessageEntity parseErrorMessageEntityWithJson:[responseObject objectForKey:@"message"]];
            failed([[responseObject objectForKey:@"status"] intValue],entity.messageContent);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(ERROR_NETWORK_CODE,ERROR_NETWORK);
    }];
}

+ (void)uploadFileWithPushId:(NSString *)pushId questionnaireId:(NSString *)questionnaireId questionId:(NSString *)questionId fileData:(NSData *)fileData fileType:(NSString *)fileType questionType:(NSNumber *)questionType Prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed {
    
    NSString *str_url = [SERVER_HOST stringByAppendingString:API_FILE_UPLOAD];
    NSDictionary *dic = @{@"pushId":pushId,@"questionnaireId":questionnaireId,@"questionId":questionId,@"fileType":fileType,@"questionType":questionType,@"userId":[UserStorage userId]};
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          keyName:@"multipartFiles"
                                         fileName:fileType
                                             data:fileData prepare:prepare success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[(NSDictionary *)responseObject objectForKey:@"status"] intValue] == 0) {
            success(responseObject);
        } else {
            ErrorMessageEntity *entity = [ErrorMessageEntity parseErrorMessageEntityWithJson:[responseObject objectForKey:@"message"]];
            failed([[responseObject objectForKey:@"status"] intValue],entity.messageContent);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(ERROR_NETWORK_CODE,ERROR_NETWORK);
    }];
    
}

@end
