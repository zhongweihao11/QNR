

#import <UIKit/UIKit.h>
#import "QuestionnaireEntity.h"
NS_ASSUME_NONNULL_BEGIN

@interface QuestionnaireDetailTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView   *iv_status;
@property (nonatomic,strong)UILabel       *lb_title;
@property (nonatomic,strong)UIView        *v_back;
@property (nonatomic,strong)UITextView    *textview;

- (void)setTitleText:(NSString *)str_title;
- (void)setQuestionnaireAnswerWithQuestionnaireObject:(QuestionnaireEntity *)questionnaireObj ChoiceObject:(ChoiceEntity *)choiceObj isLast:(BOOL)isLast;

@end

NS_ASSUME_NONNULL_END
