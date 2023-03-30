

#import <UIKit/UIKit.h>

@interface UIColor (Addition)

+ (UIColor *)colorWithHex:(NSString *)hexColor;
+ (UIColor *)colorWithHex:(NSString *)hexColor alpha:(float)hexAlpha;
+ (UIColor *)viewBackColor;

@end
