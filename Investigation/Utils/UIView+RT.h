//
//  UIView+RT.h
//  RTCategory
//
//

#import <UIKit/UIKit.h>

/*!
 @header
 UIViewクラスのRTカテゴリです。
 */

/*!
 @category UIView (RT)
 @abstract UIViewクラスのRTカテゴリです。
 */
@interface UIView (RT)

/*!
 @abstract view.center.xアクセス用プロパティ
 @discussion <pre>view.centerX += 10;</pre>のような使い方ができます。
 */
@property CGFloat centerX;

/*!
 @abstract view.center.yアクセス用プロパティ
 @discussion <pre>view.centerY += 10;</pre>のような使い方ができます。
 */
@property CGFloat centerY;

/*!
 @abstract viewの左端の座標へのアクセス用プロパティ
 @discussion <pre>view.left += 10;</pre>のような使い方ができます。
 サイズの変更は行いません。
 */
@property CGFloat left;

/*!
 @abstract viewの右端の座標へのアクセス用プロパティ
 @discussion <pre>view.right += 10;</pre>のような使い方ができます。
 サイズの変更は行いません。
 */
@property CGFloat right;

/*!
 @abstract viewの上端の座標へのアクセス用プロパティ
 @discussion <pre>view.top += 10;</pre>のような使い方ができます。
 サイズの変更は行いません。
 */
@property CGFloat top;

/*!
 @abstract viewの下端の座標へのアクセス用プロパティ
 @discussion <pre>view.bottom += 10;</pre>のような使い方ができます。
 サイズの変更は行いません。
 */
@property CGFloat bottom;

/*!
 @abstract viewの幅へのアクセス用プロパティ
 @discussion <pre>view.width += 10;</pre>のような使い方ができます。
 サイズの変更を行います。
 */
@property CGFloat width;

/*!
 @abstract viewの高さへのアクセス用プロパティ
 @discussion <pre>view.height += 10;</pre>のような使い方ができます。
 サイズの変更を行います。
 */
@property CGFloat height;

@end
