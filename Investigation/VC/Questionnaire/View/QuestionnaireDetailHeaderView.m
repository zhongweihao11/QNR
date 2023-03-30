

#import "QuestionnaireDetailHeaderView.h"
#import "UILabel+LineSpace.h"
#import "PushListEntity.h"

@implementation QuestionnaireDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.lb_state = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 80, 25)];
        self.lb_state.textColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN];
        [self.lb_state setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
        self.lb_state.layer.borderColor = [[UIColor colorWithHexString:COLOR_BLUE_MAIN] CGColor];
        self.lb_state.layer.borderWidth = 1;
        self.lb_state.layer.cornerRadius = 8;
        self.lb_state.layer.masksToBounds = YES;
        self.lb_state.textAlignment = NSTextAlignmentCenter;
        self.lb_state.hidden = YES;
        [self addSubview:self.lb_state];
        
        self.lb_title = [[UILabel alloc]initWithFrame:CGRectMake(0, self.lb_state.bottom + 10, SCREEN_WIDTH - 30,20)];
        self.lb_title.textColor = [UIColor blackColor];
        [self.lb_title setFont:[UIFont systemFontOfSize:FONT_SIZE_TITLE]];
        self.lb_title.numberOfLines = 0;
        [self addSubview:self.lb_title];
        
    }
    return self;
}

- (void)setQuestionnaireTitleViewWithQuestionnaireObject:(QuestionnaireEntity *)obj withIndex:(NSInteger)index {
    NSString *str_required = obj.required == 1 ? @"(必須)" : @"";
    NSString *str_number = [NSString stringWithFormat:@"Q%ld．",(long)index + 1];
    NSString *str_title = [NSString stringWithFormat:@"%@%@%@",str_number,str_required,obj.questionValue];
    CGFloat height_title = [self.lb_title getSpaceJustifiedLabelHeightWithText:str_title withWidth:SCREEN_WIDTH - 30 withRange:NSMakeRange(str_number.length, str_required.length)];
    self.lb_state.hidden = YES;
    [self.lb_title setFrame:CGRectMake(0, 15, SCREEN_WIDTH - 30, height_title)];
    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30, self.lb_title.bottom)];
}

@end
