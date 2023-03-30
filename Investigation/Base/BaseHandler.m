
#import "BaseHandler.h"
#import "UserDefaultsUtils.h"
#import "BaseEntity.h"
#import "NSString+URLEncoding.h"

@implementation BaseHandler

+ (void)handlerErrorWithTask:(NSURLSessionDataTask *)task error:(NSError *)error complete:(FailedBlock)failed
{

    id json = error.userInfo[JSONResponseSerializerWithDataKey];
    if(!json){
        if (failed) {
            failed(404,@"データの取得に失敗しました");
        }
        return;
    }
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if (failed) {
        if([NSJSONSerialization isValidJSONObject:dic_json])
        {
            BaseEntity *result = [BaseEntity parseObjectWithKeyValues:dic_json];
            if (result.code == 4002) {
//                [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
            }else{
                failed(result.status,result.message);
            }
        }else{
            failed(404,@"データの取得に失敗しました");
        }
    }
}

+ (NSInteger)statusCodeWithTask:(NSURLSessionDataTask *)task
{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = response.statusCode;
    return statusCode;
}



@end
