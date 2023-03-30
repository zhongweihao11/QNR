

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

- (NSString *)stringByURLEncoding {
    return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                        (CFStringRef)self,
                                                                        NULL,
                                                                        (CFStringRef)@"+",
                                                                        CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
}

- (NSString *)stringByMenuURLEncoding {
    NSString *unencodedString = self;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

- (NSString *)MenuURLDecodedString {
    NSString *encodedString = self;
    NSString *decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                    (__bridge CFStringRef)encodedString,
                                                                                                                    CFSTR(""),
                                                                                                                    CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json failed：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}


+ (NSArray*)subStr:(NSString *)string
{
    NSError *error;
    //urlを識別できる正規表現
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString* substringForMatch;
        substringForMatch = [string substringWithRange:match.range];
        [arr addObject:substringForMatch];
        
    }
    
    return arr;
    
}
//検索文字列のメス列のNSRangeを取得します。
+ (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str {
    
    NSMutableArray *results = [NSMutableArray array];
    
    NSRange searchRange = NSMakeRange(0, [str length]);
    
    NSRange range;
    
    while ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        
        [results addObject:[NSValue valueWithRange:range]];
        
        searchRange = NSMakeRange(NSMaxRange(range), [str length] - NSMaxRange(range));
        
    }
    
    return results;
}

+ (NSData *)doBlowfish:(NSData *)dataIn
               context:(CCOperation)kCCEncrypt_or_kCCDecrypt
                   key:(NSData *)key
               options:(CCOptions)options
                    iv:(NSData *)iv
                 error:(NSError **)error
{
    CCCryptorStatus ccStatus   = kCCSuccess;
    size_t          cryptBytes = 0;
    NSMutableData  *dataOut    = [NSMutableData dataWithLength:dataIn.length + kCCBlockSizeBlowfish];
    
    ccStatus = CCCrypt( kCCEncrypt_or_kCCDecrypt,
                       kCCAlgorithmBlowfish,
                       options,
                       key.bytes,
                       key.length,
                       (iv)?nil:iv.bytes,
                       dataIn.bytes,
                       dataIn.length,
                       dataOut.mutableBytes,
                       dataOut.length,
                       &cryptBytes);
    
    if (ccStatus == kCCSuccess) {
        dataOut.length = cryptBytes;
    }
    else {
        if (error) {
            *error = [NSError errorWithDomain:@"kEncryptionError"
                                         code:ccStatus
                                     userInfo:nil];
        }
        dataOut = nil;
    }
    
    return dataOut;
}

- (NSString *)blowFishEncodingWithKey:(NSString *)pkey{
    if (pkey.length<8 || pkey.length>56) {
        return nil;
    }
    NSError *error;
    NSData *key = [pkey dataUsingEncoding:NSUTF8StringEncoding];
    NSString *stringOriginal = self;
    NSData *dataOriginal = [stringOriginal dataUsingEncoding:NSUTF8StringEncoding];;
    
    NSData *dataEncrypted = [NSString doBlowfish:dataOriginal
                                         context:kCCEncrypt
                                             key:key
                                         options:kCCOptionPKCS7Padding | kCCOptionECBMode
                                              iv:nil
                                           error:&error];
    NSString *encryptedBase64String = [dataEncrypted base64EncodedStringWithOptions:0];
    return encryptedBase64String;
}

- (NSString *)blowFishDecodingWithKey:(NSString *)pkey{
    if (pkey.length<8 || pkey.length>56) {
        return nil;
    }
    NSError *error;
    NSData *key = [pkey dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *dataToDecrypt = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    NSData *dataDecrypted = [NSString doBlowfish:dataToDecrypt
                                         context:kCCDecrypt
                                             key:key
                                         options:kCCOptionPKCS7Padding | kCCOptionECBMode
                                              iv:nil
                                           error:&error];
    
    NSString *stringDecrypted = [[NSString alloc] initWithData:dataDecrypted encoding:NSUTF8StringEncoding];
    return stringDecrypted;
}

+ (NSString *)getNowTimeTimestamp {
    NSDate *date = [NSDate date];
    NSTimeZone* localTimeZone = [NSTimeZone localTimeZone];
    NSInteger offset = [localTimeZone secondsFromGMTForDate:date];
    NSTimeZone *timerZoneJP = [NSTimeZone timeZoneWithName:@"GMT+0900"];
    NSInteger jpOffset = [timerZoneJP secondsFromGMTForDate:date];
    NSDate *dateJP = [date dateByAddingTimeInterval:jpOffset - offset];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    [format setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateStr = [format stringFromDate:dateJP];
    return dateStr;
}

@end
