

#import "UIView+EasyExtend.h"
#import "UIResponder+findFirstResponder.h"

typedef void(^TappedBlock)(void);

@implementation UIView (EasyExtend)

-(CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}
-(CGFloat)top{
    return self.frame.origin.y;
}
-(CGFloat)left{
    return self.frame.origin.x;
}
-(CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}
-(CGFloat)width{
    return self.frame.size.width;
}
-(CGFloat)height{
    return self.frame.size.height;
}
- (UIImage *)saveImageWithScale:(float)scale
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)addTappedWithTarget:(id)target action:(SEL)selector{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tap];
}

- (void)resignFirstResponderWhenTapped{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboardAction)];
    [self addGestureRecognizer:tap];

}
- (void)resignKeyboardAction{
    UITextField *responder = [UIResponder currentFirstResponder];
    [responder resignFirstResponder];
}
@end
