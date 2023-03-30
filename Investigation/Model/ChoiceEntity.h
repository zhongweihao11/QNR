//
//  ChoiceEntity.h
//  ClipkitBase
//
//  Created by Cyber_MAC２ on 2020/11/25.
//  Copyright © 2020 BackApp LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    rowHorizontal = 0,
    rowVertical,
} RowColFlg;

typedef enum {
    OptionNumberType = 1,
    OptionDateType,
    OptionTextType,
} OptionType;

@interface ChoiceEntity : NSObject

@property (nonatomic,assign)NSString      *optionId;
@property (nonatomic,strong)NSString      *optionValue;
@property (nonatomic,assign)RowColFlg     rowColFlg;
@property (nonatomic,assign)OptionType    optionType;

@property (nonatomic,strong)NSString     *textValue;
@property (nonatomic,strong)NSArray      *indexPath;
@property (nonatomic,assign)BOOL         isSelect;

@end

