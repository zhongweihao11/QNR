

#import "UIColor+Util.h"

#define DEFAULT_VOID_COLOR [UIColor whiteColor]

@implementation UIColor (Util)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size); //この範囲でコンテキストを開く
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);//このコンテキストでカラーUICColorを取得します。
    CGContextFillRect(context, rect);//この色でこのコンテキストを塗りつぶします。
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    return [UIColor colorWithHexString:stringToConvert alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <=0 || size.height <=0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// グラデーションを作成する
+ (CAGradientLayer *)createGradientColor:(CGFloat)width height:(CGFloat)height colorFrom:(UIColor *)colorFrom colorTo:(UIColor *)colorTo {
    CAGradientLayer *graLayer = [CAGradientLayer layer];
    graLayer.frame = CGRectMake(0, 0, width, height);
    graLayer.startPoint = CGPointMake(0, 0);
    graLayer.endPoint = CGPointMake(0, 1);
    graLayer.locations = @[@(0.0),@(1.0)];
    [graLayer setColors:@[(id)[colorFrom CGColor],(id)[colorTo CGColor]]];
    return graLayer;
}

@end
