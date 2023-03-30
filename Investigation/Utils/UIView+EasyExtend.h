

#import <UIKit/UIKit.h>

@interface UIView (EasyExtend)
-(CGFloat)bottom;
-(CGFloat)top;
-(CGFloat)left;
-(CGFloat)right;
-(CGFloat)width;
-(CGFloat)height;
- (UIImage *)saveImageWithScale:(float)scale;
- (void)resignFirstResponderWhenTapped;

- (void)addTappedWithTarget:(id)target action:(SEL)selector;

@end
