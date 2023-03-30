
//
//  Created by 岡田耕治 on 2015/06/29.
//  Copyright (c) 2015年 岡田耕治. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (RT)

/*!
 最もTOP（表面）に表示されているViewControllerを取得します。
 
 ViewControllerがモーダルやタブ、ナビゲーションの場合も機能します。
 ただし、Child View Controllerの場合には判別できないので、その親のコンテナのView Controllerまでの検出となります。
 
 @return 最もTOPにあるViewController
 */
- (UIViewController *)topmostViewController;

@end
