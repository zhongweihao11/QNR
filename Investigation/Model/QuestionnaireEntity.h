//
//  QuestionnaireEntity.h
//  ClipkitBase
//
//  Created by Cyber_MAC２ on 2020/11/25.
//  Copyright © 2020 BackApp LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChoiceEntity.h"

typedef enum {
    ShortTextType = 1,
    TextType,
    radioType,
    checkboxType,
    DropdownBoxType,
    LevelType,
    OutsideType,
    DocumentType,
    ProgressType,
} QuestionType;

typedef enum {
    noCustomization = 0,
    WithCustomization,
} OtherType;

typedef enum {
    AllType = 0,
    ImageType,
    VideoType,
} FileType;

typedef enum {
    NormalQuestion = 0,
    BaseQuestion,
} ProblemType;

@interface QuestionnaireEntity : NSObject

@property (nonatomic,strong)NSString            *questionValue;
@property (nonatomic,assign)NSString            *questionId;
@property (nonatomic,assign)QuestionType         questionType;
@property (nonatomic,strong)NSMutableArray      *option;
@property (nonatomic,strong)NSString            *startValue;
@property (nonatomic,strong)NSString            *endValue;
@property (nonatomic,assign)OtherType            otherType;
@property (nonatomic,strong)NSString            *textValue;
@property (nonatomic,assign)NSInteger            required;
@property (nonatomic,strong)NSString            *requiredValue;
@property (nonatomic,assign)NSInteger            fileMaxNum;
@property (nonatomic,assign)NSInteger            fileMaxSize;
@property (nonatomic,assign)FileType             fileType;
@property (nonatomic,assign)ProblemType          problemType;

@property (nonatomic,strong)NSMutableArray      *outsideData;
@property (nonatomic,strong)NSMutableArray      *documentData;
@property (nonatomic,strong)NSMutableArray      *documentAnswerUrls;
@property (nonatomic,assign)NSInteger           rowHorizontalNum;

@end

