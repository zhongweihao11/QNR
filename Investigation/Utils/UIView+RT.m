//
//  UIView+RT.m
//  RTCategory
//
//

#import "UIView+RT.h"
#import <objc/runtime.h>

@implementation UIView (RT)

+ (void)load
{
    Method m1, m2;
    
    m1 = class_getInstanceMethod(self, @selector(isExclusiveTouch));
    m2 = class_getInstanceMethod(self, @selector(my_isExclusiveTouch));
    method_exchangeImplementations(m1, m2);
    
    m1 = class_getInstanceMethod(self, @selector(setExclusiveTouch:));
    m2 = class_getInstanceMethod(self, @selector(my_setExclusiveTouch:));
    method_exchangeImplementations(m1, m2);
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    CGRect rect = self.frame;
    rect.origin.x = left;
    self.frame = rect;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect rect = self.frame;
    rect.origin.x = right - rect.size.width;
    self.frame = rect;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top
{
    CGRect rect = self.frame;
    rect.origin.y = top;
    self.frame = rect;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect rect = self.frame;
    rect.origin.y = bottom - rect.size.height;
    self.frame = rect;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}


#pragma mark - Exclusive Touch

- (void)my_setExclusiveTouch:(BOOL)exclusiveTouch
{
    // ユーザー設定値を扱う状態（YES）にセット
    objc_setAssociatedObject(self, @selector(my_setExclusiveTouch:), @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self my_setExclusiveTouch:exclusiveTouch];
}

- (BOOL)my_isExclusiveTouch
{
    NSNumber *useUserSetting = objc_getAssociatedObject(self, @selector(my_setExclusiveTouch:));
    if ([useUserSetting boolValue]) {
        return [self my_isExclusiveTouch];
    }
    
    // デフォルトはYESに変更
    return YES;
}

@end
