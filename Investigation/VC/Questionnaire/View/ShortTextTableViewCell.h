//
//  ShortTextTableViewCell.h
//  Investigation
//
//  Created by mutou on 2023/03/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShortTextTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel        *lb_title;
@property (nonatomic,strong)UITextField    *tf_input;

@end

NS_ASSUME_NONNULL_END
