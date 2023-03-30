//
//  DocumentTableViewCell.m
//  Investigation
//
//  Created by mutou on 2023/03/10.
//

#import "DocumentTableViewCell.h"
#import "DocumentCollectionViewCell.h"
#import "FileEntity.h"

@implementation DocumentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.lb_memo = [[UILabel alloc]init];
        [self.lb_memo setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
        [self.lb_memo setTextColor:[UIColor redColor]];
        [self.lb_memo setTextAlignment:NSTextAlignmentCenter];
        [self.lb_memo setNumberOfLines:0];
        [self.lb_memo setBackgroundColor:[UIColor whiteColor]];
        self.lb_memo.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:self.lb_memo];
        
        [self.lb_memo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(10);
            make.width.mas_equalTo(SCREEN_WIDTH - 30);
        }];
        
        self.btn_select = [[UIButton alloc]init];
        [self.btn_select setBackgroundColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
        [self.btn_select setTitle:BUTTON_SELECTFILE_TEXT forState:UIControlStateNormal];
        self.btn_select.layer.cornerRadius = 20;
        self.btn_select.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
        self.btn_select.layer.masksToBounds = YES;
        [self.btn_select setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.btn_select];
        
        [self.btn_select mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lb_memo.mas_bottom).offset(10);
            make.width.mas_equalTo(180);
            make.height.mas_equalTo(40);
            make.left.mas_equalTo((SCREEN_WIDTH - 30 - 180)/2);
        }];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.estimatedItemSize = CGSizeMake(90,90);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = (((SCREEN_WIDTH - 60) - (90 * 3)) * 100.00) / (2 * 100.00);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
        [self.collectionView registerClass:[DocumentCollectionViewCell class] forCellWithReuseIdentifier:@"DocumentCollectionViewCell"];
        [self.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        self.collectionView.backgroundColor = [UIColor clearColor];
        self.collectionView.scrollEnabled = NO;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.showsVerticalScrollIndicator = NO;
        [self.contentView addSubview:self.collectionView];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btn_select.mas_bottom).offset(15);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(SCREEN_WIDTH - 60);
            make.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(0);
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
    DocumentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DocumentCollectionViewCell" forIndexPath:indexPath];
    FileEntity *entity = [self.arr_data objectAtIndex:indexPath.row];
    [cell.iv_play setHidden:YES];
    if (entity.fileType == ImageType || entity.fileType == VideoType) {
        cell.iv_image.image = entity.image;
        [cell.iv_image setContentMode:UIViewContentModeScaleAspectFill];
        if (entity.fileType == VideoType) {
            [cell.iv_play setHidden:NO];
        }
    } else {
        cell.iv_image.image = [UIImage imageNamed:@"file"];
        [cell.iv_image setContentMode:UIViewContentModeCenter];
    }
    cell.btn_delete.tag = indexPath.row;
    [cell.btn_delete addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.iv_image setBackgroundColor:[UIColor colorWithHexString:COLOR_LINE_LIGHTGRAY]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)contentCellWithQuestionnaireEntity:(QuestionnaireEntity *)questionnaireEntity {
    self.questionnaireEntity = questionnaireEntity;
    [self.lb_memo setText:questionnaireEntity.requiredValue];
    self.arr_data = questionnaireEntity.documentData;
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
}

- (void)deleteAction:(UIButton *)btn_sender{
    [self.arr_data removeObjectAtIndex:btn_sender.tag];
    self.questionnaireEntity.documentData = self.arr_data;
    [self.tb_list reloadSections:[NSIndexSet indexSetWithIndex:self.btn_select.tag] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
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

@end
