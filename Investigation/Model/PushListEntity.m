//
//  QuestionnaireListEntity.m
//  アンケート
//
//  Created by mutou on 2023/02/16.
//

#import "PushListEntity.h"
#import "QuestionnaireEntity.h"
@implementation PushListEntity

+ (NSDictionary *)objectClassInArray {
    return @{@"question":[QuestionnaireEntity class],
             @"baseQuestion":[QuestionnaireEntity class]
    };
}

+ (NSArray *)pushListInfoWithJson:(id)json {
  return [self parseObjectArrayWithKeyValues:json];
}

@end
