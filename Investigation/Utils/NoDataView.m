//
//  NoDataView.m
//  LiveCoach
//
//  Created by mutou on 2022/11/17.
//

#import "NoDataView.h"

@implementation NoDataView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
      UIImageView *iv_icon = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2 - 50, frame.size.height/2 - 80, 100, 100)];
      [iv_icon setImage:[UIImage imageNamed:@"no_data"]];
      iv_icon.contentMode = UIViewContentModeScaleAspectFit;
      [self addSubview:iv_icon];
      
      UILabel *lb_title = [[UILabel alloc]initWithFrame:CGRectMake(0, iv_icon.bottom, frame.size.width, 20)];
      [lb_title setTextColor:[UIColor colorWithHexString:COLOR_GRAY_TEXT]];
      [lb_title setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
      [lb_title setText:MESSAGE_NODATA];
      [lb_title setTextAlignment:NSTextAlignmentCenter];
      [self addSubview:lb_title];
    }
    return self;
}

@end
