//
//  SliderTableViewCell.m
//  Investigation
//
//  Created by mutou on 2023/02/28.
//

#import "ProgressTableViewCell.h"

@implementation ProgressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.slider = [[UISlider alloc] init];
        self.slider.maximumValue = 100;
        self.slider.minimumValue = 1;
        self.slider.value = 50;
        self.slider.tintColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN];
        self.slider.userInteractionEnabled = YES;
        [self.slider setThumbImage:[UIImage imageNamed:@"slider_thumb"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.slider];
        
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_WIDTH - 90);
            make.left.mas_equalTo(30);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(25);
        }];
        
        self.v_leftView = [[UILabel alloc]init];
        self.v_leftView.backgroundColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN];
        [self.contentView addSubview:self.v_leftView];
        
        [self.v_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(5);
            make.height.mas_equalTo(15);
            make.right.equalTo(self.slider.mas_left).offset(2);
            make.centerY.equalTo(self.slider);
        }];
        
        self.v_rightView = [[UILabel alloc]init];
        self.v_rightView.backgroundColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN];
        [self.contentView addSubview:self.v_rightView];
        
        [self.v_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(5);
            make.height.mas_equalTo(15);
            make.left.equalTo(self.slider.mas_right).offset(-2);
            make.centerY.equalTo(self.slider);
        }];
        
        self.lb_left = [[UILabel alloc]init];
        [self.lb_left setFont:[UIFont systemFontOfSize:FONT_SIZE_TITLE]];
        [self.lb_left setTextAlignment:NSTextAlignmentCenter];
        [self.lb_left setNumberOfLines:0];
        self.lb_left.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:self.lb_left];
        
        [self.lb_left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2) * 2);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(50);
        }];
        
        self.lb_right = [[UILabel alloc]init];
        [self.lb_right setFont:[UIFont systemFontOfSize:FONT_SIZE_TITLE]];
        [self.lb_right setTextAlignment:NSTextAlignmentCenter];
        [self.lb_right setNumberOfLines:0];
        self.lb_right.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:self.lb_right];
        
        [self.lb_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2) * 2);
            make.left.equalTo(self.slider.mas_right).offset(-((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2));
            make.top.mas_equalTo(50);
        }];

//        self.lb_value = [[UILabel alloc]init];
//        [self.lb_value setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
//        [self.lb_value setTextColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
//        [self.lb_value setText:@"50"];
//        [self.contentView addSubview:self.lb_value];
//
//        [self.lb_value mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.slider.mas_right).offset(15);
//            make.height.equalTo(self.slider);
//            make.centerY.equalTo(self.slider);
//        }];
        
    }
    return self;
}

- (void)contentCellWithQuestionnaireEntity:(QuestionnaireEntity *)entity {
    self.lb_left.text = entity.startValue;
    self.lb_right.text = entity.endValue;
    if (entity.startValue.length > entity.endValue.length) {
        [self.lb_left mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2) * 2);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(55);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        [self.lb_right mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2) * 2);
            make.left.equalTo(self.slider.mas_right).offset(-((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2));
            make.top.mas_equalTo(55);
        }];
    } else {
        [self.lb_left mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2) * 2);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(55);
        }];
        [self.lb_right mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2) * 2);
            make.left.equalTo(self.slider.mas_right).offset(-((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2));
            make.top.mas_equalTo(55);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
