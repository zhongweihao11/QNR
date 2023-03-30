//
//  QuestionnaireListEntity.h
//  アンケート
//
//  Created by mutou on 2023/02/16.
//

#import "BaseEntity.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    unansweredType = 1,
    answeredType,
    timeoutType
} PushType;

@interface PushListEntity : BaseEntity

@property (nonatomic,strong)NSString            *pushTitle;
@property (nonatomic,strong)NSString            *pushMemo;
@property (nonatomic,strong)NSString            *pushTime;
@property (nonatomic,strong)NSString            *pushId;
@property (nonatomic,strong)NSString            *questionnaireId;
@property (nonatomic,strong)NSMutableArray      *question;
@property (nonatomic,strong)NSMutableArray      *baseQuestion;
@property (nonatomic,assign)PushType            answerStatus;
@property (nonatomic,assign)BOOL                isOpen;

+ (NSArray *)pushListInfoWithJson:(id)json;

@end

NS_ASSUME_NONNULL_END
