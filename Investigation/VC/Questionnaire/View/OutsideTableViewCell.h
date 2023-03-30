//
//  OutsideTableViewCell.h
//  Investigation
//
//  Created by mutou on 2023/03/09.
//

#import <UIKit/UIKit.h>
#import "QuestionnaireEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface OutsideTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView    *collectionView;
@property (nonatomic,strong)NSMutableArray      *arr_data;
@property (nonatomic,strong)QuestionnaireEntity *questionnaireEntity;

- (void)contentCellWithQuestionnaireEntity:(QuestionnaireEntity *)questionnaireEntity;

@end

NS_ASSUME_NONNULL_END
