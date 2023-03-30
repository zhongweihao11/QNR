//
//  PickerView.m
//  Investigation
//
//  Created by mutou on 2023/03/13.
//

#import "PickerView.h"

@implementation PickerView

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
        
        self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 260, SCREEN_WIDTH, 260)];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        self.pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.pickerView];
        
    }
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.arr_data.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    ChoiceEntity *choiceEntity = [self.arr_data objectAtIndex:row];
    return choiceEntity.optionValue;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.select_entity = [self.arr_data objectAtIndex:row];
}

- (void)show {
    [self.pickerView reloadAllComponents];
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
    if (!self.select_entity) {
        self.select_entity = [self.arr_data firstObject];
    }
    self.submitBlock();
    [self hide];
    [self removeFromSuperview];
}

@end
