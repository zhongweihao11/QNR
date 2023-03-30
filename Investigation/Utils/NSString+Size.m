

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)contentSize
{
    if (self && ![self isEqualToString:@""]) {
        return [self boundingRectWithSize:CGSizeMake(270, 90) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:FONT_SIZE_DESC]} context:nil].size;
    }else{
        return CGSizeZero;
    }
}

- (CGFloat)fittingLabelHeightWithWidth:(CGFloat)width andFontSize:(UIFont *)font
{
    if (self && ![self isEqualToString:@""]) {
        return [self boundingRectWithSize:CGSizeMake(width, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.height + 2;
    }else{
        return 0;
    }
}

- (CGFloat)fittingLabelWidthWithHeight:(CGFloat)height andFontSize:(UIFont *)font
{
    if (self && ![self isEqualToString:@""]) {
        return [self boundingRectWithSize:CGSizeMake(0, height) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.width + 2;
    }else{
        return 0;
    }

}

//UICLabelの高さを計算します。（行間隔がある場合）
+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 5;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

//フォントに応じてサイズをとる
+ (CGSize)sizeOfString:(NSString *)string{
    return [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
}

+ (CGSize)sizeOfString:(NSString *)string WithFont:(CGFloat)font{
    return [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
}

- (NSMutableAttributedString *)modifyDigitalFont:(UIFont *)font normalFont:(UIFont *)normalFont
{
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"([0-9]\\d*\\:?\\d*)" options:0 error:NULL];
    
    NSArray<NSTextCheckingResult *> *ranges = [regular matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName : normalFont}];
    
    for (int i = 0; i < ranges.count; i++) {
        [attStr setAttributes:@{NSFontAttributeName : font} range:ranges[i].range];
    }
    return attStr;
}

@end
