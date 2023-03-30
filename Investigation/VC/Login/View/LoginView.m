//
//  LoginView.m
//  アンケート
//
//  Created by mutou on 2023/02/16.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN alpha:0.1];
        
        UIView *v_back = [[UIView alloc]initWithFrame:CGRectMake(40, SCREEN_HEIGHT/2 - 300/2 - 30, SCREEN_WIDTH - 80, 300)];
        v_back.layer.cornerRadius = 12;
        v_back.backgroundColor = [UIColor whiteColor];
        v_back.layer.masksToBounds = YES;
        [self addSubview:v_back];
        
        UIImageView *iv_icon = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 80)/2 - 40, 30, 80, 80)];
        [iv_icon setImage:[[UIImage imageNamed:@"user_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        iv_icon.tintColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN];
        iv_icon.clipsToBounds = YES;
        [v_back addSubview:iv_icon];
        
        self.tf_name = [[UITextField alloc]initWithFrame:CGRectMake(20, 140, SCREEN_WIDTH - 120, 40)];
        self.tf_name.borderStyle = UITextBorderStyleNone;
        self.tf_name.backgroundColor = [UIColor colorWithHexString:COLOR_LINE_LIGHTGRAY];
        self.tf_name.layer.cornerRadius = 8;
        self.tf_name.placeholder = INPUT_NAME_PLACEHOLDER;
        self.tf_name.leftViewMode = UITextFieldViewModeAlways;
        self.tf_name.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
        [v_back addSubview:self.tf_name];
        
        self.btn_login = [[UIButton alloc]initWithFrame:CGRectMake(20, 220,  SCREEN_WIDTH - 120, 40)];
        [self.btn_login setBackgroundColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
        self.btn_login.layer.cornerRadius = 8;
        self.btn_login.layer.masksToBounds = YES;
        [self.btn_login setTitle:@"調査に参加する" forState:UIControlStateNormal];
        [v_back addSubview:self.btn_login];
        
    }
    return self;
}
@end
