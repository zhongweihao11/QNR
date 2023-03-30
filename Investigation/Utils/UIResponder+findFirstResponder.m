
#import "UIResponder+findFirstResponder.h"

@implementation UIResponder (findFirstResponder)

static __weak id currentFirstResponder;

+(id)currentFirstResponder {
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}

-(void)findFirstResponder:(id)sender {
    currentFirstResponder = self;
}

@end
