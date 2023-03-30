//
//  DocumentTableViewCell.h
//  Investigation
//
//  Created by mutou on 2023/03/10.
//

#import <UIKit/UIKit.h>
#import "QuestionnaireEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface DocumentTableViewCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UILabel             *lb_memo;
@property (nonatomic,strong)UIButton            *btn_select;
@property (nonatomic,strong)UICollectionView    *collectionView;
@property (nonatomic,strong)NSMutableArray      *arr_data;
@property (nonatomic,strong)QuestionnaireEntity *questionnaireEntity;
@property (nonatomic,strong)UITableView         *tb_list;

- (void)contentCellWithQuestionnaireEntity:(QuestionnaireEntity *)questionnaireEntity;

@end

NS_ASSUME_NONNULL_END
