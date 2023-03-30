//
//  LoginHandler.m
//  Investigation
//
//  Created by mutou on 2023/02/22.
//

#import "LoginHandler.h"

@implementation LoginHandler

+ (void)loginWithUuid:(NSString *)uuid name:(NSString *)name prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed {
  
  if (uuid.length == 0) {
      uuid = @"";
  }
  if (name.length == 0) {
      name = @"";
  }
  NSString *str_url = [SERVER_HOST stringByAppendingString:API_LOGIN];
  NSDictionary *dic = @{@"uuid":uuid,@"name":name};
  [[RTHttpClient defaultClient] requestBodyPostWithPath:str_url
                                         jsonParameters:dic
                                        prepare:prepare
                                        success:^(NSURLSessionDataTask *task, id responseObject) {
      if([[(NSDictionary *)responseObject objectForKey:@"status"] intValue] == 0) {
          [UserStorage saveUserId:[[[(NSDictionary *)responseObject objectForKey:@"data"] objectForKey:@"userId"] integerValue]];
          success(responseObject);
      } else {
          ErrorMessageEntity *entity = [ErrorMessageEntity parseErrorMessageEntityWithJson:[responseObject objectForKey:@"message"]];
          failed([[responseObject objectForKey:@"status"] intValue],entity.messageContent);
      }
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
      failed(ERROR_NETWORK_CODE,ERROR_NETWORK);
  }];
  
}

+ (void)uploadFcmToken:(NSString *)fcmToken prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed {
    if (fcmToken.length == 0) {
        fcmToken = @"";
    }

    NSString *str_url = [SERVER_HOST stringByAppendingString:API_SEND_FIREBASEID];
    NSDictionary *dic = @{@"firebaseId":fcmToken};
    [[RTHttpClient defaultClient] requestBodyPostWithPath:str_url
                                           jsonParameters:dic
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

+ (void)checkVersionPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed {
    NSString *str_url = [SERVER_HOST stringByAppendingString:API_VERSION_CHECK];
    NSDictionary *dic = @{@"appSysFlg":[NSNumber numberWithInt:0]};
    [[RTHttpClient defaultClient] requestBodyPostWithPath:str_url
                                           jsonParameters:dic
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

@end
