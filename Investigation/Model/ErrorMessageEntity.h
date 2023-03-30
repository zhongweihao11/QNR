

#import "BaseEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ErrorMessageEntity : BaseEntity

@property(nonatomic,strong)NSString *messageId;
@property(nonatomic,assign)NSInteger messageType;
@property(nonatomic,strong)NSString *messageContent;

+ (ErrorMessageEntity *)parseErrorMessageEntityWithJson:(id)json;
+ (NSArray *)parsetErrorMessageListWWithJson:(id)json;

@end

NS_ASSUME_NONNULL_END
