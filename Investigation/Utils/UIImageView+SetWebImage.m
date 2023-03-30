

#import "UIImageView+SetWebImage.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (SetWebImage)

- (void)setWebImageWithFullURLString:(NSString *)urlString placeHolder:(NSString *)placeHolder{
    NSURL *url = [NSURL URLWithString:urlString];
    if (url) {
        [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:placeHolder]];
    }else{
        self.image = [UIImage imageNamed:placeHolder];
    }
}

- (void)setWebImageRefreshCachedWithFullURLString:(NSString *)urlString placeHolder:(NSString *)placeHolder {
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (url) {
        [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:placeHolder] options:SDWebImageRefreshCached];
    }else{
        self.image = [UIImage imageNamed:placeHolder];
    }
}

@end
