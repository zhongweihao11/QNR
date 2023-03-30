
#import "QuestionnaireListTableViewCell.h"
#import "NSString+Size.h"
#import "PushListEntity.h"

@implementation QuestionnaireListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    
    self.clipsToBounds = YES;
    
    self.v_back = [[UIView alloc]init];
    self.v_back.layer.cornerRadius = 8;
    self.v_back.clipsToBounds = YES;
    self.v_back.backgroundColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN alpha:0.1];
    [self.contentView addSubview:self.v_back];
    
    self.lb_state = [[UILabel alloc]init];
    self.lb_state.textColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN];
    self.lb_state.layer.borderColor = [[UIColor colorWithHexString:COLOR_BLUE_MAIN]CGColor];
    self.lb_state.layer.borderWidth = 1;
    self.lb_state.layer.cornerRadius = 8;
    self.lb_state.layer.masksToBounds = YES;
    self.lb_state.textAlignment = NSTextAlignmentCenter;
    self.lb_state.font = [UIFont systemFontOfSize:FONT_SIZE_SMALL];
    [self.contentView addSubview:self.lb_state];
    
    self.lb_title = [[UILabel alloc]init];
    self.lb_title.preferredMaxLayoutWidth = SCREEN_WIDTH - 80;
    self.lb_title.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.lb_title];
    
    self.btn_answer = [[UIButton alloc]init];
    [self.btn_answer setTitle:@"回答" forState:UIControlStateNormal];
    [self.btn_answer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btn_answer.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
    [self.btn_answer setBackgroundColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
    self.btn_answer.layer.borderWidth = 1;
    self.btn_answer.layer.cornerRadius = 8;
    self.btn_answer.layer.borderColor = [[UIColor clearColor] CGColor];
    self.btn_answer.layer.masksToBounds = YES;
    [self.contentView addSubview:self.btn_answer];
    
    self.v_line = [[UIView alloc]init];
    [self.v_line setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_TEXT]];
    [self.contentView addSubview:self.v_line];
    
    self.lb_subtitle = [[UILabel alloc]init];
    self.lb_subtitle.numberOfLines = 0;
    self.lb_subtitle.preferredMaxLayoutWidth = SCREEN_WIDTH - 180;
    self.lb_subtitle.lineBreakMode = NSLineBreakByCharWrapping;
    self.lb_subtitle.textColor = [UIColor colorWithHexString:COLOR_GRAY_TEXT];
    self.lb_subtitle.font = [UIFont systemFontOfSize:FONT_SIZE_MEMO];
    [self.contentView addSubview:self.lb_subtitle];
    
    self.lb_time = [[UILabel alloc]init];
    self.lb_time.textColor = [UIColor colorWithHexString:COLOR_GRAY_TEXT];
    self.lb_time.font = [UIFont systemFontOfSize:FONT_SIZE_MEMO];
    self.lb_time.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.lb_time];
    
    self.lb_desc = [[UILabel alloc]init];
    self.lb_desc.numberOfLines = 0;
    self.lb_desc.preferredMaxLayoutWidth = SCREEN_WIDTH - 50;
    self.lb_desc.textColor = [UIColor colorWithHexString:COLOR_GRAY_TEXT];
    self.lb_desc.font = [UIFont systemFontOfSize:FONT_SIZE_MEMO];
    self.lb_desc.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:self.lb_desc];

    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(10);
      make.top.mas_equalTo(15);
      make.width.mas_equalTo(SCREEN_WIDTH - 140);
      make.height.mas_equalTo(25);
    }];
    
    [self.v_back mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(0);
      make.top.mas_equalTo(0);
      make.width.mas_equalTo(SCREEN_WIDTH - 30);
    }];
    
    [self.btn_answer mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.equalTo(self.v_back.mas_right).offset(-10);
      make.width.mas_equalTo(80);
      make.height.mas_equalTo(25);
      make.top.mas_equalTo(13);
    }];
    
    [self.lb_state mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.width.height.equalTo(self.btn_answer);
    }];
    
    [self.v_line mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(10);
      make.top.mas_equalTo(50);
      make.width.mas_equalTo(SCREEN_WIDTH - 50);
      make.height.mas_equalTo(0.5);
    }];
    
    [self.lb_time mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.mas_equalTo(-15);
      make.top.equalTo(self.v_line.mas_bottom).offset(10);
      make.width.mas_equalTo(130);
    }];
      
    [self.lb_subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(10);
      make.top.equalTo(self.v_line.mas_bottom).offset(10);
      make.width.mas_equalTo(SCREEN_WIDTH - 180);
    }];

    [self.lb_desc mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(10);
      make.top.equalTo(self.lb_subtitle.mas_bottom).offset(10);
      make.width.mas_equalTo(SCREEN_WIDTH - 50);
    }];

    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.mas_equalTo(0);
      make.width.mas_equalTo(SCREEN_WIDTH - 30);
      make.bottom.equalTo(self.v_back.mas_bottom).offset(15);
    }];
      
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

- (void)setFrameWithQuestionnaireObject:(PushListEntity *)obj{
  self.lb_title.text = obj.pushTitle;
  self.lb_subtitle.text = obj.pushTitle;
  self.lb_desc.text = obj.pushMemo;
  self.lb_time.text = obj.pushTime;
  if (obj.answerStatus == unansweredType) {
    self.v_back.backgroundColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN alpha:0.1];
    self.lb_state.hidden = YES;
    self.btn_answer.hidden = NO;
  }else{
    self.v_back.backgroundColor = [UIColor colorWithHexString:COLOR_LINE_LIGHTGRAY];
    self.lb_state.hidden = NO;
    self.btn_answer.hidden = YES;
    if (obj.answerStatus == answeredType) {
      [self.lb_state setText:@"回答済み"];
    } else {
      [self.lb_state setText:@"回答期限切れ"];
    }
  }
  if (obj.isOpen == NO) {
    [self.lb_subtitle setHidden:YES];
    [self.lb_desc setHidden:YES];
    [self.v_line setHidden:YES];
    [self.lb_time setHidden:YES];
    [self.v_back mas_updateConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(self.v_line.mas_bottom);
    }];
  } else {
    [self.lb_subtitle setHidden:NO];
    [self.lb_desc setHidden:NO];
    [self.v_line setHidden:NO];
    [self.lb_time setHidden:NO];
    [self.v_back mas_updateConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(self.lb_desc.mas_bottom).offset(10);
    }];
  }
}

@end
