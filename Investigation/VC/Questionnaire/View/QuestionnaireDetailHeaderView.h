

#import <UIKit/UIKit.h>
#import "QuestionnaireEntity.h"
NS_ASSUME_NONNULL_BEGIN

@interface QuestionnaireDetailHeaderView : UIView

@property (nonatomic,strong)UILabel   *lb_state;
@property (nonatomic,strong)UILabel   *lb_title;
@property (nonatomic,strong)UILabel   *lb_detail;
@property (nonatomic,assign)BOOL      isStateHidden;

- (void)setQuestionnaireTitleViewWithQuestionnaireObject:(QuestionnaireEntity *)obj withIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
