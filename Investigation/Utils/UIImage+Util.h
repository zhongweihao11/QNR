

#import <UIKit/UIKit.h>

@interface UIImage (Util)

+(UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

+ (UIImage *)convertViewToImage;

+ (UIImage *)stretchImageWithImage:(UIImage *)image atPos:(CGPoint)pos;

+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

+(CGSize)getImageSizeWithURL:(id)imageURL;

+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request;

+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request;

+(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request;

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

- (UIImage*)imageChangeColor:(UIColor*)color;

@end
