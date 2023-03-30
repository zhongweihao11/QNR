//
//  DocumentCollectionViewCell.h
//  Investigation
//
//  Created by mutou on 2023/03/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DocumentCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView  *iv_image;
@property (nonatomic,strong)UIButton     *btn_delete;
@property (nonatomic,strong)UIImageView  *iv_play;

@end

NS_ASSUME_NONNULL_END
