//
//  ShortTextTableViewCell.m
//  Investigation
//
//  Created by mutou on 2023/03/13.
//

#import "ShortTextTableViewCell.h"

@implementation ShortTextTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.lb_title = [[UILabel alloc]init];
        self.lb_title.textColor = [UIColor blackColor];
        [self.lb_title setNumberOfLines:0];
        self.lb_title.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:self.lb_title];
        
        self.tf_input = [[UITextField alloc]init];
        [self.tf_input setPlaceholder:INPUT_PLACEHOLDER];
        self.tf_input.layer.borderWidth = 0.5;
        self.tf_input.layer.borderColor = [[UIColor grayColor] CGColor];
        self.tf_input.layer.cornerRadius = 8;
        self.tf_input.leftViewMode = UITextFieldViewModeAlways;
        self.tf_input.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 30)];
        self.tf_input.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
        [self.contentView addSubview:self.tf_input];
        
        [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(15);
            make.width.mas_equalTo(70);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        }];
        
        [self.tf_input mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.lb_title.mas_right).offset(10);
            make.centerY.equalTo(self.lb_title);
            make.height.mas_equalTo(30);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
