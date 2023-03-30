//
//  LevelTableViewCell.m
//  Investigation
//
//  Created by mutou on 2023/03/01.
//

#import "LevelTableViewCell.h"
#import "CheckCollectionViewCell.h"
#import "ChoiceEntity.h"

@implementation LevelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(25,45);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
        [self.collectionView registerClass:[CheckCollectionViewCell class] forCellWithReuseIdentifier:@"CheckCollectionViewCell"];
        self.collectionView.backgroundColor = [UIColor clearColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:self.collectionView];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.width.mas_equalTo(SCREEN_WIDTH - 30 - 60);
            make.height.mas_equalTo(45);
            make.left.mas_equalTo(30);
        }];
        
        self.lb_left = [[UILabel alloc]init];
        [self.lb_left setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
        [self.lb_left setTextAlignment:NSTextAlignmentRight];
        [self.lb_left setNumberOfLines:0];
        self.lb_left.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:self.lb_left];
        
        [self.lb_left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2) * 2);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(70);
        }];
        
        self.lb_right = [[UILabel alloc]init];
        [self.lb_right setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
        [self.lb_right setTextAlignment:NSTextAlignmentLeft];
        [self.lb_right setNumberOfLines:0];
        self.lb_right.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:self.lb_right];
        
        [self.lb_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2) * 2);
            make.left.mas_equalTo(SCREEN_WIDTH - 60 - ((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2));
            make.top.mas_equalTo(70);
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
    CheckCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CheckCollectionViewCell" forIndexPath:indexPath];
    ChoiceEntity *entity = [self.arr_data objectAtIndex:indexPath.row];
    cell.lb_title.text = entity.optionValue;
    UIImage *img = [[UIImage alloc]init];
    if (entity.isSelect == YES) {
        img = [UIImage imageNamed:@"radio_select"];
    } else {
        img = [UIImage imageNamed:@"radio_normal"];
    }
    [cell.iv_status setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ChoiceEntity *selectedEntity = [self.arr_data objectAtIndex:indexPath.row];
    for (ChoiceEntity *entity in self.arr_data) {
        if (entity != selectedEntity) {
            entity.isSelect = NO;
        } else {
            entity.isSelect = YES;
        }
    }
    [self.collectionView reloadData];
}

- (void)contentCellWithQuestionnaireEntity:(QuestionnaireEntity *)entity {
    self.lb_left.text = entity.startValue;
    self.lb_right.text = entity.endValue;
    self.arr_data = entity.option;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(25,45);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = ((SCREEN_WIDTH - 90) - 25 * self.arr_data.count) * 100.00 / ((self.arr_data.count - 1) * 100.00);
    self.collectionView.collectionViewLayout = flowLayout;
    [self.collectionView reloadData];
    if (entity.startValue.length > entity.endValue.length) {
        [self.lb_left mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2) * 2);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(70);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        [self.lb_right mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2) * 2);
            make.left.mas_equalTo(SCREEN_WIDTH - 60 - ((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2));
            make.top.mas_equalTo(70);
        }];
    } else {
        [self.lb_left mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2) * 2);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(70);
        }];
        [self.lb_right mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2) * 2);
            make.left.mas_equalTo(SCREEN_WIDTH - 60 - ((SCREEN_WIDTH - 30)/2 - (SCREEN_WIDTH - 90)/2));
            make.top.mas_equalTo(70);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
