//
//  LevelTableViewCell.h
//  Investigation
//
//  Created by mutou on 2023/03/01.
//

#import <UIKit/UIKit.h>
#import "QuestionnaireEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface LevelTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView  *collectionView;
@property (nonatomic,strong)NSArray           *arr_data;
@property (nonatomic,strong)UILabel           *lb_left;
@property (nonatomic,strong)UILabel           *lb_right;

- (void)contentCellWithQuestionnaireEntity:(QuestionnaireEntity *)entity;

@end

NS_ASSUME_NONNULL_END
