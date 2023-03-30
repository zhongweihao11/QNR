//
//  SliderTableViewCell.h
//  Investigation
//
//  Created by mutou on 2023/02/28.
//

#import <UIKit/UIKit.h>
#import "QuestionnaireEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProgressTableViewCell : UITableViewCell

@property (nonatomic,strong)UISlider       *slider;
@property (nonatomic,strong)UILabel        *lb_value;
@property (nonatomic,strong)UILabel        *lb_left;
@property (nonatomic,strong)UILabel        *lb_right;
@property (nonatomic,strong)UIView         *v_leftView;
@property (nonatomic,strong)UIView         *v_rightView;

- (void)contentCellWithQuestionnaireEntity:(QuestionnaireEntity *)entity;

@end

NS_ASSUME_NONNULL_END
