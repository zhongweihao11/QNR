//
//  QuestionnaireEntity.m
//  ClipkitBase
//
//  Created by Cyber_MAC２ on 2020/11/25.
//  Copyright © 2020 BackApp LLC. All rights reserved.
//

#import "QuestionnaireEntity.h"
#import "ChoiceEntity.h"

@implementation QuestionnaireEntity

+ (NSDictionary *)objectClassInArray {
    return @{@"option":[ChoiceEntity class]};
}

@end
