//
//  DocumentCollectionViewCell.m
//  Investigation
//
//  Created by mutou on 2023/03/14.
//

#import "DocumentCollectionViewCell.h"

@implementation DocumentCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.iv_image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, frame.size.width - 10, frame.size.height - 10)];
        [self.iv_image setContentMode:UIViewContentModeScaleAspectFill];
        self.iv_image.clipsToBounds = YES;
        self.iv_image.layer.cornerRadius = 8;
        self.iv_image.layer.masksToBounds = YES;
        [self.contentView addSubview:self.iv_image];
        
        self.btn_delete = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width - 20, 0, 20, 20)];
        [self.btn_delete setImage:[UIImage imageNamed:@"delete_icon"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.btn_delete];
        
        self.iv_play = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, 40, 40)];
        [self.iv_play setImage:[UIImage imageNamed:@"play_icon"]];
        [self.iv_play setAlpha:0.8];
        [self.contentView addSubview:self.iv_play];
        
    }
    return self;
}

@end
