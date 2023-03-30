//
//  VersionEntity.m
//  Investigation
//
//  Created by mutou on 2023/03/15.
//

#import "VersionEntity.h"

@implementation VersionEntity

+ (VersionEntity *)parseVersionEntityWithJson:(id)json {
    return [self parseObjectWithKeyValues:json];
}
@end
