

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSString (URLEncoding)

- (NSString *)stringByURLEncoding;

- (NSString *)stringByMenuURLEncoding;
- (NSString *)MenuURLDecodedString;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (NSArray*)subStr:(NSString *)string;

+ (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str;

+ (NSData *)doBlowfish:(NSData *)dataIn
               context:(CCOperation)kCCEncrypt_or_kCCDecrypt
                   key:(NSData *)key
               options:(CCOptions)options
                    iv:(NSData *)iv
                 error:(NSError **)error;
- (NSString *)blowFishEncodingWithKey:(NSString *)pkey;
- (NSString *)blowFishDecodingWithKey:(NSString *)pkey;

+ (NSString *)getNowTimeTimestamp;
- (NSString*)dateWithString:(NSString*)str;

@end
