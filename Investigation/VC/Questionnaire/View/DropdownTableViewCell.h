//
//  DropdownTableViewCell.h
//  Investigation
//
//  Created by mutou on 2023/03/10.
//

#import <UIKit/UIKit.h>
#import "QuestionnaireEntity.h"
#import "PickerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DropdownTableViewCell : UITableViewCell

@property (nonatomic,strong)UIButton            *btn_select;
@property (nonatomic,strong)QuestionnaireEntity *questionnaireEntity;
@property (nonatomic,strong)PickerView *pickerView;

- (void)contentCellWithQuestionnaireEntity:(QuestionnaireEntity *)questionnaireEntity;

@end

NS_ASSUME_NONNULL_END
