
#import "BaseViewController.h"
#import "UIColor+Util.h"
#import "AFNetworkReachabilityManager.h"
#import "UIImage+Util.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

//navgation色を変える
- (void)changeNavigationBarBackgroudColor:(UIColor *)backgroudColor TintColor:(UIColor *)tintColor TitleColor:(UIColor *)titleColor TitleFont:(CGFloat)titleFont {
    
    [self.navigationController.navigationBar setBackgroundImage:[UIColor imageWithColor:backgroudColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:tintColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     titleColor, NSForegroundColorAttributeName,
                                                                     [UIFont boldSystemFontOfSize:titleFont], NSFontAttributeName, nil]];
     [self.navigationController.navigationBar setShadowImage:[UIColor imageWithColor:backgroudColor size:CGSizeMake(self.view.frame.size.width, 0.5)]];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)changeNavigationOriginal {
    [self.navigationController.navigationBar setBackgroundImage:[UIColor imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor colorWithHexString:COLOR_BLUE_MAIN], NSForegroundColorAttributeName,
                                                                     [UIFont boldSystemFontOfSize:19.0], NSFontAttributeName, nil]];
    [self.navigationController.navigationBar setShadowImage:[UIColor imageWithColor:[UIColor colorWithHexString:COLOR_LIGHTGRAY_TEXT] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
    self.navigationController.navigationBar.translucent = NO;
    
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *barAppearance = [[UINavigationBarAppearance alloc] init];
        barAppearance.backgroundImage = [UIColor imageWithColor:[UIColor whiteColor]];
        barAppearance.shadowImage = [UIColor imageWithColor:[UIColor colorWithHexString:COLOR_LIGHTGRAY_TEXT] size:CGSizeMake(self.view.frame.size.width, 0.5)];
        self.navigationController.navigationBar.standardAppearance = barAppearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = barAppearance;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.view.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    if (!_isHideLeftBtn){
        [self initLeftBarView];
    }
    
    [self onCreate];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [self changeNavigationOriginal];
    
}


- (void)initLeftBarView
{
    UIBarButtonItem *btn_back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"img_back"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarAction:)];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationItem.leftBarButtonItem = btn_back;
}


- (void)leftBarAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)onCreate
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear: (BOOL)animated
{
    [super viewWillDisappear: animated];
//    [SVProgressHUD dismiss];
}

- (void)dealloc {
    //リアルタイムネットワークを削除
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

@end
