

#import <UIKit/UIKit.h>


typedef void(^Completed)(BOOL error);

@interface UIImageView (SetWebImage)


- (void)setWebImageWithFullURLString:(NSString *)urlString placeHolder:(NSString *)placeHolder;
- (void)setWebImageRefreshCachedWithFullURLString:(NSString *)urlString placeHolder:(NSString *)placeHolder;

@end
