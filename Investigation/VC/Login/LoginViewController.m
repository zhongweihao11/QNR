//
//  LoginViewController.m
//  アンケート
//
//  Created by mutou on 2023/02/16.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "QuestionnaireListViewController.h"
#import "LoginHandler.h"
#import "SAMKeychain.h"

@interface LoginViewController ()

@property (nonatomic,strong)LoginView *v_main;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    self.isHideLeftBtn = YES;
    [super viewDidLoad];
    
    self.v_main = [[LoginView alloc]initWithFrame:self.view.bounds];
    [self.v_main.btn_login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.v_main];
    
}

//デバイス固有の値の取得
- (NSString *)getUUID {
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return uuid;
}

//ログイン処理
- (void)login {
    if (self.v_main.tf_name.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:INPUT_NAME_PLACEHOLDER];
    } else {
        NSString *str_uuid = [self getUUID];
        [LoginHandler loginWithUuid:str_uuid name:self.v_main.tf_name.text prepare:^{
            [SVProgressHUD show];
        } success:^(id obj) {
            [SVProgressHUD dismiss];
            [UserStorage saveUuid:str_uuid];
            [UserStorage saveName:self.v_main.tf_name.text];
            QuestionnaireListViewController *vc = [[QuestionnaireListViewController alloc]init];
            vc.modalPresentationStyle = UIModalPresentationFullScreen;
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            if ([[UserStorage userId] length] > 0) {
                [LoginHandler uploadFcmToken:[UserStorage token] prepare:^{
                } success:^(id obj) {
                    NSLog(@"fcmToken upload success");
                } failed:^(NSInteger statusCode, id json) {
                    NSLog(@"fcmToken upload failed");
                }];
            }
            [[UIApplication sharedApplication] keyWindow].rootViewController = nav;
        } failed:^(NSInteger statusCode, id json) {
            [SVProgressHUD showErrorWithStatus:(NSString *)json];
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

@end
