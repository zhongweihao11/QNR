//
//  AppDelegate.m
//  Investigation
//
//  Created by mutou on 2023/02/22.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import <Firebase/Firebase.h>
#import "QuestionnaireListViewController.h"
#import "LoginHandler.h"
#import "VersionEntity.h"

@interface AppDelegate ()<FIRMessagingDelegate,UNUserNotificationCenterDelegate>

@property (nonatomic,assign) BOOL    needCheckAppVersion;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    if ([[UserStorage userId] length] > 0) {
        QuestionnaireListViewController *vc = [[QuestionnaireListViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = nav;
    } else {
        LoginViewController *vc = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = nav;
    }
    
    //firebase設定
    [FIRApp configure];
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
    UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
    [[UNUserNotificationCenter currentNotificationCenter]
     requestAuthorizationWithOptions:authOptions
     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (error) {
            return;
        }
        if (granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            });
            return;
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
            });
        }
    }];
    
    [FIRMessaging messaging].delegate = self;
    self.needCheckAppVersion = YES;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [application registerForRemoteNotifications];
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    if (self.needCheckAppVersion == YES) {
        [self checkVersion];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [FIRMessaging messaging].APNSToken = deviceToken;
    [[FIRMessaging messaging] subscribeToTopic:@"all"];
}

- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    NSLog(@"fcmToken ==== %@",fcmToken);
    //fcmTokenをアップロード
    [UserStorage saveToken:fcmToken];
    if ([[UserStorage userId] length] > 0) {
        [LoginHandler uploadFcmToken:fcmToken prepare:^{
        } success:^(id obj) {
            NSLog(@"fcmToken upload success");
        } failed:^(NSInteger statusCode, id json) {
            NSLog(@"fcmToken upload failed");
        }];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result)) completionHandler {
    if ([application applicationState] == UIApplicationStateActive) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"お知らせ" message:@"アンケートをご回答ください。" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReceiveMessage" object:nil];
        }]];
        if ([self currentViewController]) {
            [[self currentViewController] presentViewController:alertController animated:YES completion:nil];
        }
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReceiveMessage" object:nil];
    }
    [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)checkVersion {
    
    self.needCheckAppVersion = NO;
    
    [LoginHandler checkVersionPrepare:^{
        
    } success:^(NSDictionary *obj) {
        
        VersionEntity *entity = [VersionEntity parseVersionEntityWithJson:[obj objectForKey:@"data"]];
        NSString *loaclVersion = [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        NSString *storeVersion = entity.version;
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:entity.content message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        if (entity.forceUpdateFlg == 0 && [self isLastestVersion:loaclVersion compare:storeVersion] == NO) {
            [alertController addAction:[UIAlertAction actionWithTitle:@"Storeへ" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.needCheckAppVersion = YES;
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:entity.storeUrl] options:@{} completionHandler:nil];
            }]];
            [[self currentViewController] presentViewController:alertController animated:YES completion:nil];
        } else if ([self isLastestVersion:loaclVersion compare:storeVersion] == NO) {
            [alertController addAction:[UIAlertAction actionWithTitle:@"キャンセル" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Storeへ" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:entity.storeUrl] options:@{} completionHandler:nil];
            }]];
            [[self currentViewController] presentViewController:alertController animated:YES completion:nil];
        }
        
    } failed:^(NSInteger statusCode, id json) {
    }];
    
}

//バージョン番号判定
- (BOOL)isLastestVersion:(NSString *)currentVersion compare:(NSString *)lastestVersion {
    if (currentVersion && lastestVersion) {
        NSMutableArray *currentItems = [[currentVersion componentsSeparatedByString:@"."] mutableCopy];
        NSMutableArray *lastestItems = [[lastestVersion componentsSeparatedByString:@"."] mutableCopy];
        NSInteger currentCount = currentItems.count;
        NSInteger lastestCount = lastestItems.count;
        if (currentCount != lastestCount) {
            NSInteger count = labs(currentCount - lastestCount);
            for (int i = 0; i < count; ++i) {
                if (currentCount > lastestCount) {
                    [lastestItems addObject:@"0"];
                } else {
                    [currentItems addObject:@"0"];
                }
            }
        }
        BOOL isLastest = YES;
        for (int i = 0; i < currentItems.count; ++i) {
            NSString *currentItem = currentItems[i]; NSString *lastestItem = lastestItems[i];
            if (currentItem.integerValue != lastestItem.integerValue) {
                isLastest = currentItem.integerValue > lastestItem.integerValue;
                break;
            }
        }
        return isLastest;
    }
    return NO;
}

// 現在のページを取得
- (UIViewController *)currentViewController
{
     UIViewController * currVC = nil;
     UIViewController * Rootvc = self.window.rootViewController;
     do {
         if ([Rootvc isKindOfClass:[UINavigationController class]]) {
             UINavigationController * nav = (UINavigationController *)Rootvc;
             UIViewController * v = [nav.viewControllers lastObject];
             currVC = v;
             Rootvc = v.presentedViewController;
             continue;
         }else if ([Rootvc isKindOfClass:[UITabBarController class]]) {
             UITabBarController * tabVC = (UITabBarController *)Rootvc;
             currVC = tabVC;
             Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
             continue;
         }
     } while (Rootvc != nil);
     
     return currVC;
}

@end
