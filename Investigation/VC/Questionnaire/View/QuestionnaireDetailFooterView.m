

#import "QuestionnaireDetailFooterView.h"

@implementation QuestionnaireDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.btn_submit = [[UIButton alloc]initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH - 30 - 40, 60)];
        self.btn_submit.backgroundColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN];
        [self.btn_submit setTitle:BUTTON_ANSWER_TEXT forState:UIControlStateNormal];
        self.btn_submit.titleLabel.font = [UIFont boldSystemFontOfSize:FONT_SIZE_TITLE];
        self.btn_submit.layer.cornerRadius = 8;
        self.btn_submit.layer.masksToBounds = YES;
        [self addSubview:self.btn_submit];
        
    }
    return self;
}



@end
