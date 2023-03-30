
#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

#define SUCCESS 0

@interface BaseEntity : NSObject

@property (nonatomic,assign)    NSInteger   _id;//ID
@property (nonatomic,assign)    NSInteger   status;//状態
@property (nonatomic,copy)      NSString    *message;//状態情報

@property (nonatomic,assign)    id          res;//情報を携帯する
@property (nonatomic,assign)    NSInteger   code;

@property (nonatomic,assign)    double      createdAt;
@property (nonatomic,assign)    double      updatedAt;


@property (nonatomic,assign)    BOOL isClose;


+ (NSArray *)parseObjectArrayWithKeyValues:(id)json;//parseObjectArrayWithJSONData

+ (id)parseObjectWithKeyValues:(NSDictionary *)keyValues;

@end
