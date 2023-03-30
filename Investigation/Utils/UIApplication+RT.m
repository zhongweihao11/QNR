
//
//  Created by 岡田耕治 on 2015/06/29.
//  Copyright (c) 2015年 岡田耕治. All rights reserved.
//

#import "UIApplication+RT.h"

@implementation UIApplication (RT)

- (UIViewController *)topmostViewController
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 5.0f) {
        // iOS6以前だとAlertにWindowを生成するので0番目をメインwindowという前提で取得する
        if (self.windows.count > 0) {
            UIWindow *window = self.windows[0];
            UIViewController *topVC = window.rootViewController;
            return [self topViewControllerWithRootViewController:topVC];
        }
    }
    return nil;
}

- (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        // check up to 2 layers
        for (UIView *view in [rootViewController.view subviews]) {
            id subViewController = [view nextResponder];
            if (subViewController && [subViewController isKindOfClass:[UIViewController class]]) {
                return [self topViewControllerWithRootViewController:subViewController];
            }
            for (UIView *subview in view.subviews) {
                subViewController = [subview nextResponder];
                if (subViewController && [subViewController isKindOfClass:[UIViewController class]]) {
                    return [self topViewControllerWithRootViewController:subViewController];
                }
            }
        }
        return rootViewController;
    }
}

@end
