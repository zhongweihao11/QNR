

#import "QuestionnaireDetailTableViewCell.h"
#import "UILabel+LineSpace.h"
#import "UIImage+Util.h"
#import "QuestionnaireEntity.h"

@implementation QuestionnaireDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {        
        self.iv_status = [[UIImageView alloc]init];
        [self.iv_status setImage:[[UIImage imageNamed:@"radio_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        self.iv_status.contentMode = UIViewContentModeScaleAspectFill;
        self.iv_status.tintColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN];
        [self.contentView addSubview:self.iv_status];
        
        self.lb_title = [[UILabel alloc]init];
        self.lb_title.font = [UIFont systemFontOfSize:FONT_SIZE_TITLE];
        [self.lb_title setTextColor:[UIColor blackColor]];
        self.lb_title.numberOfLines = 0;
        self.lb_title.preferredMaxLayoutWidth = SCREEN_WIDTH - 30 - 25 - 20 - 20;
        [self.contentView addSubview:self.lb_title];
        
        self.v_back = [[UIView alloc]init];
        self.v_back.backgroundColor = [UIColor whiteColor];
        self.v_back.alpha = 0.7;
        self.v_back.hidden = YES;
        [self.contentView addSubview:self.v_back];

        [self.iv_status mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(25);
            make.left.mas_equalTo(20);
            make.width.height.mas_equalTo(20);
        }];
        
        [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iv_status.mas_right).offset(5);
            make.top.equalTo(self.iv_status.mas_top).offset(-1);
            make.width.mas_equalTo(SCREEN_WIDTH - 30 - 25 - 20 - 20);
        }];
        
        [self.v_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH - 30);
            make.bottom.equalTo(self.lb_title.mas_bottom).offset(2);
        }];
        
        self.textview = [[UITextView alloc]init];
        self.textview.layer.borderWidth = 0.5;
        self.textview.layer.borderColor = [[UIColor grayColor] CGColor];
        self.textview.layer.cornerRadius = 8;
        self.textview.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
        [self.contentView addSubview:self.textview];
        
        [self.textview mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.lb_title.mas_left);
          make.width.mas_equalTo(SCREEN_WIDTH - 30 - 25 - 40);
          make.height.mas_equalTo(100);
          make.top.equalTo(self.lb_title.mas_bottom).offset(10);
        }];
    
    }
    return self;
}

- (void)setTitleText:(NSString *)str_title{
    [self.lb_title setText:str_title];
}

- (void)setQuestionnaireAnswerWithQuestionnaireObject:(QuestionnaireEntity *)questionnaireObj ChoiceObject:(ChoiceEntity *)choiceObj isLast:(BOOL)isLast{
    
    UIImage *img = [UIImage imageNamed:@"radio_normal"];
    if (questionnaireObj.questionType == radioType) {
        if (choiceObj.isSelect == YES) {
            img = [UIImage imageNamed:@"radio_select"];
            self.lb_title.textColor = [UIColor blackColor];
        } else {
            img = [UIImage imageNamed:@"radio_normal"];
        }
    } else {
        if (choiceObj.isSelect == YES) {
            img = [UIImage imageNamed:@"checkbox_select"];
            self.lb_title.textColor = [UIColor blackColor];
        }else{
            img = [UIImage imageNamed:@"checkbox_normal"];
            self.lb_title.textColor = [UIColor blackColor];
        }
    }
    
    [self.iv_status setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    if (questionnaireObj.otherType == WithCustomization && isLast == YES && choiceObj.isSelect == YES) {
        [self.textview setHidden:NO];
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH - 30);
            make.bottom.equalTo(self.textview.mas_bottom).offset(2);
        }];
        if (questionnaireObj.textValue.length == 0) {
            self.textview.text = INPUT_PLACEHOLDER;
            self.textview.textColor = [UIColor colorWithHexString:COLOR_LIGHTGRAY_TEXT];
        } else {
            self.textview.text = questionnaireObj.textValue;
            self.textview.textColor = [UIColor blackColor];
        }
    } else {
        [self.textview setHidden:YES];
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH - 30);
            make.bottom.equalTo(self.lb_title.mas_bottom).offset(2);
        }];
    }
    
}

@end
