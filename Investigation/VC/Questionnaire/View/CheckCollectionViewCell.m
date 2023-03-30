//
//  CheckCollectionViewCell.m
//  Investigation
//
//  Created by mutou on 2023/03/01.
//

#import "CheckCollectionViewCell.h"

@implementation CheckCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.lb_title = [[UILabel alloc]init];
        self.lb_title.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
        [self.lb_title setTextColor:[UIColor blackColor]];
        [self.lb_title setTextAlignment:NSTextAlignmentCenter];
        self.lb_title.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:self.lb_title];
        
        [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.contentView);
            make.top.mas_equalTo(20);
            make.top.mas_equalTo(0);
        }];
        
        self.iv_status = [[UIImageView alloc]init];
        [self.iv_status setImage:[[UIImage imageNamed:@"radio_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        self.iv_status.contentMode = UIViewContentModeScaleAspectFill;
        self.iv_status.tintColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN];
        [self.contentView addSubview:self.iv_status];
        
        [self.iv_status mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.height.mas_equalTo(25);
            make.top.mas_equalTo(20);
        }];
        
    }
    return self;
}

@end
