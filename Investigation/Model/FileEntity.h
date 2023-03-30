//
//  FileEntity.h
//  Investigation
//
//  Created by mutou on 2023/03/15.
//

#import "BaseEntity.h"
#import "QuestionnaireEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface FileEntity : BaseEntity

@property (nonatomic,assign)FileType   fileType;
@property (nonatomic,strong)UIImage    *image;
@property (nonatomic,strong)NSURL      *fileUrl;
@property (nonatomic,strong)NSData     *filedData;
@property (nonatomic,assign)CGFloat    fileSize;  //M

@end

NS_ASSUME_NONNULL_END
