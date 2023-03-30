//
//  DatePickerView.h
//  Investigation
//
//  Created by mutou on 2023/03/27.
//

#import <UIKit/UIKit.h>

typedef void(^SubmitBlock)(void);

@interface DatePickerView : UIView

@property (nonatomic,strong)UIDatePicker  *datePicker;
@property (nonatomic,strong)UIButton      *btn_cancel;
@property (nonatomic,strong)UIButton      *btn_submit;
@property (nonatomic,strong)NSString      *str_date;

@property (copy,nonatomic)SubmitBlock      submitBlock;

- (void)show;

@end

