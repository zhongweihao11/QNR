

#import <UIKit/UIKit.h>

@interface UIColor (Util)

//この色の画像を取得します。
+ (UIImage *)imageWithColor:(UIColor *)color;
//色コードから色オブジェクトを取得します。
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (CAGradientLayer *)createGradientColor:(CGFloat)width height:(CGFloat)height colorFrom:(UIColor *)colorFrom colorTo:(UIColor *)colorTo;

@end
