//
//  DatePickerView.m
//  Investigation
//
//  Created by mutou on 2023/03/27.
//

#import "DatePickerView.h"

@implementation DatePickerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.3];
        
        UIView *v_footer = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 300, SCREEN_WIDTH, 300)];
        [v_footer setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:v_footer];
        
        UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 300, SCREEN_WIDTH, 40)];
        [v_header setBackgroundColor:[UIColor colorWithHexString:COLOR_LINE_LIGHTGRAY]];
        [self addSubview:v_header];
        
        self.btn_cancel = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        [self.btn_cancel setTitle:@"キャンセル" forState:UIControlStateNormal];
        self.btn_cancel.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
        [self.btn_cancel setTitleColor:[UIColor colorWithHexString:COLOR_GRAY_TEXT] forState:UIControlStateNormal];
        [self.btn_cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [v_header addSubview:self.btn_cancel];
        
        self.btn_submit = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 0, 100, 40)];
        [self.btn_submit setTitle:@"確認" forState:UIControlStateNormal];
        [self.btn_submit setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN] forState:UIControlStateNormal];
        [self.btn_submit addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        [v_header addSubview:self.btn_submit];
        
        self.datePicker = [[UIDatePicker alloc] init];
        self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"ja_JP"];
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        if (@available(iOS 13.4, *)) {
            self.datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        }
        self.datePicker.frame = CGRectMake(0, SCREEN_HEIGHT - 260, SCREEN_WIDTH, 260);
        [self.datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.datePicker];
        
    }
    return self;
}

- (void)show {
    if (self.str_date.length > 0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSDate *dateTime = [formatter dateFromString:self.str_date];
        self.datePicker.date = dateTime;
    } else {
        self.datePicker.date = [NSDate date];
    }
    [self setHidden:NO];
}

- (void)hide {
    [self setHidden:YES];
}

- (void)cancelAction {
    [self hide];
    [self removeFromSuperview];
}

- (void)submitAction {
    if (self.str_date.length == 0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy/MM/dd";
        self.str_date = [formatter  stringFromDate:[NSDate date]];
    }
    self.submitBlock();
    [self hide];
    [self removeFromSuperview];
}

- (void)dateChange:(UIDatePicker *)datePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    formatter.dateFormat = @"yyyy/MM/dd";
    self.str_date = [formatter  stringFromDate:datePicker.date];
}

@end
