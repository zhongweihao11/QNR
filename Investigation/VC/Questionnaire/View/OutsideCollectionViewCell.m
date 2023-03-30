//
//  OutsideCollectionViewCell.m
//  Investigation
//
//  Created by mutou on 2023/03/09.
//

#import "OutsideCollectionViewCell.h"
#import "ChoiceEntity.h"

@implementation OutsideCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.lb_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.lb_title.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
        [self.lb_title setTextColor:[UIColor blackColor]];
        self.lb_title.numberOfLines = 0;
        self.lb_title.textAlignment = NSTextAlignmentCenter;
        self.lb_title.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:self.lb_title];

        self.iv_status = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width / 2 - 25/2, frame.size.height / 2 - 25/2, 25, 25)];
        [self.iv_status setImage:[[UIImage imageNamed:@"checkbox_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        self.iv_status.contentMode = UIViewContentModeScaleAspectFill;
        self.iv_status.tintColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN];
        [self.contentView addSubview:self.iv_status];
                
    }
    return self;
}

- (void)layoutSubviews {
    [self.lb_title setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.iv_status setFrame:CGRectMake(self.frame.size.width / 2 - 25/2, self.frame.size.height / 2 - 25/2, 25, 25)];
}

@end
