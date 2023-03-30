//
//  PickerView.h
//  Investigation
//
//  Created by mutou on 2023/03/13.
//

#import <UIKit/UIKit.h>
#import "ChoiceEntity.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SubmitBlock)(void);

@interface PickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)UIPickerView  *pickerView;
@property (nonatomic,strong)UIButton      *btn_cancel;
@property (nonatomic,strong)UIButton      *btn_submit;
@property (nonatomic,strong)ChoiceEntity  *select_entity;
@property (nonatomic,strong)NSArray       *arr_data;
@property (copy,nonatomic)SubmitBlock      submitBlock;

- (void)show;

@end

NS_ASSUME_NONNULL_END
