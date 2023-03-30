

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property(nonatomic,assign)BOOL isHideLeftBtn;
@property(nonatomic,assign)BOOL isShowRightBtn;
@property(nonatomic,assign)BOOL isHideNetworkErr;

@property (nonatomic, strong) NSString *userId;

- (void)initLeftBarView;
- (void)onCreate;
- (void)leftBarAction:(id)sender;
- (void)rightBarAction:(id)sender;
- (void)networkErrorHandler;


- (void)changeNavigationBarBackgroudColor:(UIColor *)backgroudColor TintColor:(UIColor *)tintColor TitleColor:(UIColor *)titleColor TitleFont:(CGFloat)titleFont;

- (void)changeNavigationOriginal;

@end
