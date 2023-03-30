
#import "RTHttpClient.h"
#import "RTJSONResponseSerializerWithData.h"
#import "AFNetworking.h"
#import <Reachability/Reachability.h>
#import <netinet/in.h>
#import "BaseHandler.h"
#import "AppUtils.h"

@interface RTHttpClient()

@property(nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation RTHttpClient

- (id)init{
    if (self = [super init]){
        self.manager = [AFHTTPSessionManager manager];
        
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        [securityPolicy setAllowInvalidCertificates:YES];
        
        self.manager.securityPolicy = securityPolicy;
        
//        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.manager.requestSerializer.timeoutInterval = 20;
        [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        self.manager.securityPolicy.allowInvalidCertificates = YES;
        [self.manager.securityPolicy setValidatesDomainName:NO];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];

    }
    return self;
}

+ (RTHttpClient *)defaultClient
{
    static RTHttpClient *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(id)parameters
                prepare:(PrepareBlock)prepare
                success:(void (^)(NSURLSessionDataTask *, id))success
                failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{

    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    [securityPolicy setAllowInvalidCertificates:YES];
    
    self.manager.securityPolicy = securityPolicy;
   
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
   
    [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.manager.requestSerializer.timeoutInterval = 20;
    [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
   
    self.manager.securityPolicy.allowInvalidCertificates = YES;
    [self.manager.securityPolicy setValidatesDomainName:NO];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    [self.manager.requestSerializer setValue:[UserStorage userId] forHTTPHeaderField:@"userId"];
    [self.manager.requestSerializer setValue:[UserStorage uuid] forHTTPHeaderField:@"uuid"];
    [self.manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"OS"];


    //前処理
    if (prepare) {
        prepare();
    }
    
    //ブロックfailure追加登録が失効した4002の処理
    void (^tFailure)(NSURLSessionDataTask*, id) = ^(NSURLSessionDataTask *task, NSError *error) {
        
        id json = error.userInfo[JSONResponseSerializerWithDataKey];
        if (!json) {
            failure(task,error);
            return;
        }
        
        NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        id json_object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        if ([json_object isKindOfClass:[NSDictionary class]]) {
            NSDictionary* dic_json = (NSDictionary*)json_object;
            if (dic_json.count) {
                if ([dic_json objectForKey:@"status"]) {
                    NSInteger code = [[dic_json objectForKey:@"status"] integerValue];
                }
            }
        }
        failure(task,error);
    };
    
    if ([AppUtils isConnectionAvailable]) {
        switch (method) {
            case RTHttpRequestGet:
            {

              [self.manager GET:url parameters:parameters headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
              } success:success failure:failure];
            }
                break;
            case RTHttpRequestPost:
            {
              [self.manager POST:url parameters:parameters headers:nil constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
                
              } success:success failure:failure];
            }
                break;
            case RTHttpRequestDelete:
            {
                [self.manager DELETE:url parameters:parameters headers:nil success:success failure:tFailure];
            }
                break;
            case RTHttpRequestPut:
            {
                [self.manager PUT:url parameters:parameters headers:nil success:success failure:tFailure];
            }
                break;
            default:
                break;
        }
    }else{
        [SVProgressHUD dismiss];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"k_NOTI_NETWORK_ERROR" object:nil];
    }
    
}

- (void)requestBodyPostWithPath:(NSString *)url
             jsonParameters:(id)parameters
                prepare:(PrepareBlock)prepare
                success:(void (^)(NSURLSessionDataTask *, id))success
                failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    [securityPolicy setAllowInvalidCertificates:YES];
   
    self.manager.securityPolicy = securityPolicy;
   
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
   
    [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.manager.requestSerializer.timeoutInterval = 20;
    [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
   
    self.manager.securityPolicy.allowInvalidCertificates = YES;
    [self.manager.securityPolicy setValidatesDomainName:NO];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    [self.manager.requestSerializer setValue:[UserStorage userId] forHTTPHeaderField:@"userId"];
    [self.manager.requestSerializer setValue:[UserStorage uuid] forHTTPHeaderField:@"uuid"];
    [self.manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"OS"];

    //前処理
    if (prepare) {
        prepare();
    }
    
    NSError*parseError = nil;

    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&parseError];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    request.timeoutInterval = 20;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[UserStorage userId] forHTTPHeaderField:@"userId"];
    [request setValue:[UserStorage uuid] forHTTPHeaderField:@"uuid"];
    [request setValue:@"1" forHTTPHeaderField:@"OS"];
    [request setHTTPBody:jsonData];
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failure(dataTask,error);
        } else {
            success(dataTask,responseObject);
        }
    }];
    [dataTask resume];
}

- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(id)parameters
                keyName:(NSString *)key
               fileName:(NSString *)fileName
                   data:(NSData *)fileData
                prepare:(PrepareBlock)prepare
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{

    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    [securityPolicy setAllowInvalidCertificates:YES];
   
    self.manager.securityPolicy = securityPolicy;
   
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
   
    [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.manager.requestSerializer.timeoutInterval = 1000;
    [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
   
    self.manager.securityPolicy.allowInvalidCertificates = YES;
    [self.manager.securityPolicy setValidatesDomainName:NO];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    [self.manager.requestSerializer setValue:[UserStorage userId] forHTTPHeaderField:@"userId"];
    [self.manager.requestSerializer setValue:[UserStorage uuid] forHTTPHeaderField:@"uuid"];
    [self.manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"OS"];

    //前処理
    if (prepare) {
        prepare();
    }
    
    //ブロックfailure追加登録が失効した4002の処理
    void (^tFailure)(NSURLSessionDataTask*, id) = ^(NSURLSessionDataTask *task, NSError *error) {
        
        id json = error.userInfo[JSONResponseSerializerWithDataKey];
        if (!json) {
            failure(task,error);
            return;
        }
        
        NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        id json_object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        if ([json_object isKindOfClass:[NSDictionary class]]) {
            NSDictionary* dic_json = (NSDictionary*)json_object;
            if (dic_json.count) {
                if ([dic_json objectForKey:@"status"]) {
                    NSInteger code = [[dic_json objectForKey:@"status"] integerValue];
                }
            }
        }
        failure(task,error);
    };
    
    if ([AppUtils isConnectionAvailable]) {
        [self.manager POST:url parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            if (fileName.length > 0) {
                [formData appendPartWithFileData:fileData name:key fileName:fileName mimeType:@"application/octet-stream"];
            }
        }  progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:success failure:tFailure];

    }else{
        [SVProgressHUD dismiss];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"k_NOTI_NETWORK_ERROR" object:nil];
    }
    
}

- (void)cancelRequest
{
    [_manager.operationQueue cancelAllOperations];
}

@end
