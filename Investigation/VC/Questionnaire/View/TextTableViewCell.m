//
//  TextTableViewCell.m
//  アンケート
//
//  Created by mutou on 2023/02/16.
//

#import "TextTableViewCell.h"

@implementation TextTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
      
    self.textview = [[UITextView alloc]init];
    self.textview.layer.borderWidth = 0.5;
    self.textview.layer.borderColor = [[UIColor grayColor] CGColor];
    self.textview.layer.cornerRadius = 8;
    self.textview.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
    [self.contentView addSubview:self.textview];
    
    [self.textview mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.mas_equalTo(15);
      make.width.mas_equalTo(SCREEN_WIDTH - 60);
      make.height.mas_equalTo(120);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.textview.mas_bottom).offset(5);
    }];
    
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
