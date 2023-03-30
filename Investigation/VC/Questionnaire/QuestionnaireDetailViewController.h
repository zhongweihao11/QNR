

#import "BaseViewController.h"
#import "QuestionnaireEntity.h"
#import "PushListEntity.h"
#import "QuestionnaireListViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^AnswerSuccess)();

@interface QuestionnaireDetailViewController : BaseViewController
@property (nonatomic,strong)PushListEntity         *obj_questionnaire;
@property (nonatomic,strong)NSMutableArray         *arr_questions;
@property (nonatomic,assign)BOOL                    isBaseQuestion;
@property (nonatomic,copy) AnswerSuccess answerSuccess;
@end

NS_ASSUME_NONNULL_END
