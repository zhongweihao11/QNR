

#import "RTJSONResponseSerializerWithData.h"

/// NSError userInfo key that will contain response data
#define JSONResponseSerializerWithDataKey @"JSONResponseSerializerWithDataKey"

@implementation RTJSONResponseSerializerWithData

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (*error != nil) {
            NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
            userInfo[JSONResponseSerializerWithDataKey] = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSError *newError = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
            (*error) = newError;
        }
        
        return (nil);
    }
    
    return ([super responseObjectForResponse:response data:data error:error]);
}

@end
