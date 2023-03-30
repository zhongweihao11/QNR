//
//  OutsideTableViewCell.m
//  Investigation
//
//  Created by mutou on 2023/03/09.
//

#import "OutsideTableViewCell.h"
#import "OutsideCollectionViewCell.h"
#import "ChoiceEntity.h"

@implementation OutsideTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.estimatedItemSize = CGSizeMake(80,40);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
        [self.collectionView registerClass:[OutsideCollectionViewCell class] forCellWithReuseIdentifier:@"OutsideCollectionViewCell"];
        [self.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        self.collectionView.backgroundColor = [UIColor clearColor];
        self.collectionView.scrollEnabled = NO;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:self.collectionView];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH - 30);
            make.height.mas_equalTo(100);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];


    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arr_data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OutsideCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OutsideCollectionViewCell" forIndexPath:indexPath];
    ChoiceEntity *entity = [self.arr_data objectAtIndex:indexPath.row];
    if (entity.indexPath.count > 0) {
        UIImage *img = [[UIImage alloc]init];
        if (entity.isSelect == YES) {
            img = [UIImage imageNamed:@"checkbox_select"];
        } else {
            img = [UIImage imageNamed:@"checkbox_normal"];
        }
        [cell.iv_status setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        [cell.lb_title setHidden:YES];
        [cell.iv_status setHidden:NO];
    } else {
        cell.lb_title.text = entity.optionValue;
        [cell.iv_status setHidden:YES];
        [cell.lb_title setHidden:NO];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ChoiceEntity *selectedEntity = [self.arr_data objectAtIndex:indexPath.row];
    if (selectedEntity.indexPath.count > 0) {
        selectedEntity.isSelect = !selectedEntity.isSelect;
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }
}

- (void)contentCellWithQuestionnaireEntity:(QuestionnaireEntity *)questionnaireEntity {
    self.questionnaireEntity = questionnaireEntity;
    
    if (questionnaireEntity.outsideData.count > 0) {
        self.arr_data = questionnaireEntity.outsideData;
    } else {
        self.arr_data = [NSMutableArray array];
        NSMutableArray *arr_horizontal = [NSMutableArray array];
        NSMutableArray *arr_vertical = [NSMutableArray array];
        for (ChoiceEntity *choiceEntity in questionnaireEntity.option) {
            if (choiceEntity.rowColFlg == rowHorizontal) {
                [arr_horizontal addObject:choiceEntity];
            } else {
                [arr_vertical addObject:choiceEntity];
            }
       }
        
       for (int i = 0; i < (arr_vertical.count + 1) * (arr_horizontal.count + 1); i++) {
            if (i == 0) {
                [self.arr_data addObject:[[ChoiceEntity alloc] init]];
            } else if (i <= arr_vertical.count) {
                [self.arr_data addObject:[arr_vertical objectAtIndex:i - 1]];
            } else if (i % (arr_vertical.count + 1) == 0) {
                [self.arr_data addObject:[arr_horizontal objectAtIndex:i / (arr_vertical.count + 1) - 1]];
            } else {
                ChoiceEntity *verticalEntity = [arr_vertical objectAtIndex:i % (arr_vertical.count + 1) - 1];
                ChoiceEntity *horizontalEntity = [arr_horizontal objectAtIndex:i / (arr_vertical.count + 1) - 1];
                ChoiceEntity *demoEntity = [[ChoiceEntity alloc]init];
                demoEntity.indexPath = @[horizontalEntity.optionId,verticalEntity.optionId];
                [self.arr_data addObject:demoEntity];
            }
        }
        questionnaireEntity.outsideData = self.arr_data;
        questionnaireEntity.rowHorizontalNum = arr_horizontal.count;
    }
    
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];

}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return ((SCREEN_WIDTH - 30) - (self.questionnaireEntity.rowHorizontalNum + 1) * 80) / self.questionnaireEntity.rowHorizontalNum  - 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChoiceEntity *entity = [self.arr_data objectAtIndex:indexPath.row];
    if (entity.optionValue.length > 0) {
        CGFloat height = [entity.optionValue fittingLabelHeightWithWidth:80 andFontSize:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
        return CGSizeMake(80, height);
    } else {
        return CGSizeMake(80, 40);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"])
    {
        CGFloat height = self.collectionView.contentSize.height;
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
