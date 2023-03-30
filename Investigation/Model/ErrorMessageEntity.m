
#import "ErrorMessageEntity.h"

@implementation ErrorMessageEntity

+ (ErrorMessageEntity *)parseErrorMessageEntityWithJson:(id)json{
    return [self parseObjectWithKeyValues:json];
}

+ (NSArray *)parsetErrorMessageListWWithJson:(id)json{
    return [self parseObjectArrayWithKeyValues:json];
}

@end
