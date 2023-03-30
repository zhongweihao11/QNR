

#import <Foundation/Foundation.h>

@interface NSString (Size)

- (CGSize)contentSize;

- (CGFloat)fittingLabelHeightWithWidth:(CGFloat)width andFontSize:(UIFont *)font;

- (CGFloat)fittingLabelWidthWithHeight:(CGFloat)height andFontSize:(UIFont *)font;

+ (CGSize)sizeOfString:(NSString *)string;

+ (CGSize)sizeOfString:(NSString *)string WithFont:(CGFloat)font;

//UICLabelの高さを計算します。（行間隔がある場合）
+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width;

- (NSMutableAttributedString *)modifyDigitalFont:(UIFont *)font normalFont:(UIFont *)normalFont;
@end
