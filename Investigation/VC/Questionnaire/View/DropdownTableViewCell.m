//
//  DropdownTableViewCell.m
//  Investigation
//
//  Created by mutou on 2023/03/10.
//

#import "DropdownTableViewCell.h"

@implementation DropdownTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.btn_select = [[UIButton alloc]init];
        [self.btn_select setTitle:@"選択してください" forState:UIControlStateNormal];
        self.btn_select.layer.cornerRadius = 8;
        self.btn_select.layer.masksToBounds = YES;
        self.btn_select.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
        [self.btn_select setBackgroundColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
        [self.btn_select addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.btn_select];
        
        [self.btn_select mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.width.mas_equalTo(SCREEN_WIDTH - 60);
            make.height.mas_equalTo(35);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        }];

    }
    return self;
}

- (void)contentCellWithQuestionnaireEntity:(QuestionnaireEntity *)questionnaireEntity {
    self.questionnaireEntity = questionnaireEntity;
    if (questionnaireEntity.textValue.length > 0) {
        [self.btn_select setTitle:questionnaireEntity.textValue forState:UIControlStateNormal];
    }
}

- (void)selectAction {
    [self.superview endEditing:YES];
    NSInteger index = 0;
    for (int i = 0; i < self.questionnaireEntity.option.count; i++) {
        ChoiceEntity *entity = [self.questionnaireEntity.option objectAtIndex:i];
        if (entity.isSelect == YES) {
            index = i;
        }
    }
    self.pickerView = [[PickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.pickerView.arr_data = self.questionnaireEntity.option;
    [self.pickerView.pickerView selectRow:index inComponent:0 animated:NO];
    self.pickerView.select_entity = [self.questionnaireEntity.option objectAtIndex:index];
    self.pickerView.submitBlock = ^{
        [self.btn_select setTitle:self.pickerView.select_entity.optionValue forState:UIControlStateNormal];
        for (int i = 0; i < self.questionnaireEntity.option.count; i++) {
            ChoiceEntity *entity = [self.questionnaireEntity.option objectAtIndex:i];
            if (self.pickerView.select_entity == entity) {
                entity.isSelect = YES;
            } else {
                entity.isSelect = NO;
            }
        }
        self.questionnaireEntity.textValue = self.pickerView.select_entity.optionValue;
    };
    [[UIApplication sharedApplication].keyWindow addSubview:self.pickerView];
    [self.pickerView show];
}

@end
