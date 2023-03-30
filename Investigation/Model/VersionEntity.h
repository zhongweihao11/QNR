//
//  VersionEntity.h
//  Investigation
//
//  Created by mutou on 2023/03/15.
//

#import "BaseEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface VersionEntity : BaseEntity

@property (nonatomic,strong)NSString   *version;
@property (nonatomic,strong)NSString   *content;
@property (nonatomic,assign)NSInteger  forceUpdateFlg;
@property (nonatomic,strong)NSString   *storeUrl;

+ (VersionEntity *)parseVersionEntityWithJson:(id)json;

@end

NS_ASSUME_NONNULL_END
