
#import <UIKit/UIKit.h>
#import "PushListEntity.h"

@interface QuestionnaireListTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel         *lb_state;
@property (nonatomic,strong)UIView          *v_back;
@property (nonatomic,strong)UILabel         *lb_title;
@property (nonatomic,strong)UIImageView     *iv_arrow;
@property (nonatomic,strong)UIButton        *btn_answer;
@property (nonatomic,strong)UIView          *v_line;
@property (nonatomic,strong)UILabel         *lb_subtitle;
@property (nonatomic,strong)UILabel         *lb_desc;
@property (nonatomic,strong)UILabel         *lb_time;

- (void)setFrameWithQuestionnaireObject:(PushListEntity *)obj;

@end

