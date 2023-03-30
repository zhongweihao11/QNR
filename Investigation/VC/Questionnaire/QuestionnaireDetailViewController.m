

#import "QuestionnaireDetailViewController.h"
#import "QuestionnaireDetailHeaderView.h"
#import "QuestionnaireDetailTableViewCell.h"
#import "QuestionnaireDetailFooterView.h"
#import "ChoiceEntity.h"
#import "TextTableViewCell.h"
#import "PushHandler.h"
#import "ProgressTableViewCell.h"
#import "LevelTableViewCell.h"
#import "OutsideTableViewCell.h"
#import "DropdownTableViewCell.h"
#import "DocumentTableViewCell.h"
#import "PickerView.h"
#import "ShortTextTableViewCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "FileEntity.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <UniformTypeIdentifiers/UTCoreTypes.h>
#import "DatePickerView.h"

@interface QuestionnaireDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentPickerDelegate>

@property (nonatomic,strong)UITableView                      *tb_list;
@property (nonatomic,strong)QuestionnaireDetailHeaderView    *v_header;
@property (nonatomic,strong)QuestionnaireDetailFooterView    *v_footer;
@property (nonatomic,strong)UIButton                         *btn_submit;
@property (nonatomic,strong)PickerView                       *pickerView;
@property (nonatomic,assign)BOOL                             isFailed;
@property (nonatomic,strong)DatePickerView                   *datePicker;

@end

@implementation QuestionnaireDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isBaseQuestion == YES) {
        self.arr_questions = [NSMutableArray arrayWithArray:self.obj_questionnaire.baseQuestion];
    } else {
        self.arr_questions = [NSMutableArray arrayWithArray:self.obj_questionnaire.question];
    }
    
    self.tb_list = [[UITableView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, SCREEN_HEIGHT - NAVIGATIONBAR_VER_HEIGHT - 10) style:UITableViewStyleGrouped];
    self.tb_list.delegate = self;
    self.tb_list.dataSource = self;
    self.tb_list.separatorColor = [UIColor clearColor];
    self.tb_list.backgroundColor = [UIColor whiteColor];
    self.tb_list.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tb_list];
    
    self.v_footer = [[QuestionnaireDetailFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30, 120)];
    [self.v_footer.btn_submit addTarget:self action:@selector(answerSubmit) forControlEvents:UIControlEventTouchUpInside];
    [self.v_footer.btn_back addTarget:self action:@selector(leftBarAction:) forControlEvents:UIControlEventTouchUpInside];
    if (self.isBaseQuestion == YES) {
        [self.v_footer.btn_submit setTitle:BUTTON_NEXT_TEXT forState:UIControlStateNormal];
    }
    self.tb_list.tableFooterView = self.v_footer;
    
    self.pickerView = [[PickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.pickerView setHidden:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:self.pickerView];
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    QuestionnaireDetailHeaderView *v_header = [[QuestionnaireDetailHeaderView alloc]initWithFrame:CGRectZero];
    QuestionnaireEntity *entity = [self.arr_questions objectAtIndex:section];
    [v_header setQuestionnaireTitleViewWithQuestionnaireObject:entity withIndex:section];
    return v_header.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.v_header = [[QuestionnaireDetailHeaderView alloc]initWithFrame:CGRectZero];
    QuestionnaireEntity *entity = [self.arr_questions objectAtIndex:section];
    [self.v_header setQuestionnaireTitleViewWithQuestionnaireObject:entity withIndex:section];
    return  _v_header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arr_questions.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    QuestionnaireEntity *entity = [self.arr_questions objectAtIndex:section];
    if (entity.questionType == radioType || entity.questionType == checkboxType || entity.questionType == ShortTextType) {
        return entity.option.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionnaireEntity *entity = [self.arr_questions objectAtIndex:indexPath.section];
    
    if (entity.questionType == ShortTextType) {
        ChoiceEntity *obj = [[ChoiceEntity alloc]init];
        obj = [entity.option objectAtIndex:indexPath.row];
        static NSString *identifier = @"ShortTextTableViewCell";
        ShortTextTableViewCell *cell = [[ShortTextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.lb_title.text = obj.optionValue;
        cell.tf_input.tag = indexPath.section * 1000 + indexPath.row;
        cell.tf_input.text = obj.textValue;
        cell.tf_input.delegate = self;
        if (obj.optionType == OptionDateType) {
            cell.editing = NO;
            cell.tf_input.userInteractionEnabled = YES;
            UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDate:)];
            tapGesture.view.tag = indexPath.section * 1000 + indexPath.row;
            [cell.tf_input addGestureRecognizer:tapGesture];
            [tapGesture setNumberOfTapsRequired:1];
        } else if (obj.optionType == OptionNumberType) {
            cell.editing = YES;
            cell.tf_input.keyboardType = UIKeyboardTypeDecimalPad;
        } else {
            cell.editing = YES;
            cell.tf_input.keyboardType = UIKeyboardTypeDefault;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (entity.questionType == TextType) {
        static NSString *identifier = @"TextTableViewCell";
        TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[TextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textview.tag = indexPath.section;
        if (entity.textValue.length == 0) {
            cell.textview.text = INPUT_PLACEHOLDER;
            cell.textview.textColor = [UIColor colorWithHexString:COLOR_LIGHTGRAY_TEXT];
        } else {
            cell.textview.text = entity.textValue;
            cell.textview.textColor = [UIColor blackColor];
        }
        cell.textview.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (entity.questionType == ProgressType) {
        static NSString *identifier = @"ProgressTableViewCell";
        ProgressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ProgressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (entity.textValue.length == 0) {
            entity.textValue = @"50";
        } else {
            cell.slider.value = [entity.textValue intValue];
        }
        cell.slider.tag = indexPath.section;
        [cell contentCellWithQuestionnaireEntity:entity];
        [cell.slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (entity.questionType == LevelType) {
        static NSString *identifier = @"LevelTableViewCell";
        LevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[LevelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell contentCellWithQuestionnaireEntity:entity];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (entity.questionType == OutsideType) {
        static NSString *identifier = @"OutsideTableViewCell";
        OutsideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[OutsideTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell contentCellWithQuestionnaireEntity:entity];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (entity.questionType == DropdownBoxType) {
        static NSString *identifier = @"DropdownTableViewCell";
        DropdownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[DropdownTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell contentCellWithQuestionnaireEntity:entity];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (entity.questionType == DocumentType) {
        static NSString *identifier = @"DocumentTableViewCell";
        DocumentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[DocumentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.btn_select.tag = indexPath.section;
        [cell.btn_select addTarget:self action:@selector(selectDocumentAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.tb_list = tableView;
        [cell contentCellWithQuestionnaireEntity:entity];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        ChoiceEntity *obj = [[ChoiceEntity alloc]init];
        obj = [entity.option objectAtIndex:indexPath.row];
        static NSString *identifier = @"QuestionnaireDetailTableViewCell";
        QuestionnaireDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[QuestionnaireDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell setTitleText:obj.optionValue];
        BOOL isLast = NO;
        if (indexPath.row == entity.option.count - 1) {
            isLast = YES;
        }
        cell.textview.tag = indexPath.section;
        cell.textview.delegate = self;
        [cell setQuestionnaireAnswerWithQuestionnaireObject:entity ChoiceObject:obj isLast:isLast];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (void)selectDate:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
    self.datePicker = [[DatePickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    QuestionnaireEntity *entity = [self.arr_questions objectAtIndex:tap.view.tag / 1000];
    ChoiceEntity *choiceEntity = [entity.option objectAtIndex:tap.view.tag % 1000];
    self.datePicker.str_date = choiceEntity.textValue;
    self.datePicker.submitBlock = ^{
        choiceEntity.textValue = self.datePicker.str_date;
        [self.tb_list reloadSections:[NSIndexSet indexSetWithIndex:tap.view.tag / 1000] withRowAnimation:UITableViewRowAnimationNone];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:self.datePicker];
    [self.datePicker show];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length < 1){
        textView.text = INPUT_PLACEHOLDER;
        textView.textColor = [UIColor colorWithHexString:COLOR_LIGHTGRAY_TEXT];
    } else {
        QuestionnaireEntity *entity = [self.arr_questions objectAtIndex:textView.tag];
        entity.textValue = textView.text;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:INPUT_PLACEHOLDER]) {
        textView.text= @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    QuestionnaireEntity *entity = [self.arr_questions objectAtIndex:textField.tag / 1000];
    ChoiceEntity *choiceEntity = [entity.option objectAtIndex:textField.tag % 1000];
    choiceEntity.textValue = textField.text;
}

- (void)sliderChange:(UISlider *)slider {
    QuestionnaireEntity *entity = [self.arr_questions objectAtIndex:slider.tag];
    entity.textValue = [NSString stringWithFormat:@"%d",(int)slider.value];
}

- (void)selectDocumentAction:(UIButton *)btn_sender {
    QuestionnaireEntity *entity = [self.arr_questions objectAtIndex:btn_sender.tag];
    if (entity.documentData.count >= entity.fileMaxNum) {
        [SVProgressHUD showInfoWithStatus:FILE_MAXNUMBER_WARNING];
    } else {
        if (entity.fileType == ImageType || entity.fileType == VideoType) {
            [self showImagePickerWithType:entity.fileType withTag:btn_sender.tag];
        } else {
            UIAlertControllerStyle style = UIAlertControllerStyleActionSheet;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                style = UIAlertControllerStyleAlert;
            }
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:style];
            
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"キャンセル" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *image_action = [UIAlertAction actionWithTitle:SHEET_IMAGE_TEXT style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self showImagePickerWithType:ImageType withTag:btn_sender.tag];
            }];
            UIAlertAction *video_action = [UIAlertAction actionWithTitle:SHEET_VIDEO_TEXT style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self showImagePickerWithType:VideoType withTag:btn_sender.tag];
            }];
            UIAlertAction *file_action = [UIAlertAction actionWithTitle:SHEET_FILE_TEXT style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self showDocumentPickerWithTag:btn_sender.tag];
            }];
            [alertVC addAction:cancleAction];
            [alertVC addAction:image_action];
            [alertVC addAction:video_action];
            [alertVC addAction:file_action];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }
}

- (void)showImagePickerWithType:(FileType)fileType withTag:(NSInteger)tag{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.view.tag = tag;
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    if (fileType == ImageType) {
        imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    } else {
        imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
    }
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    NSString *str_type = [info objectForKey:UIImagePickerControllerMediaType];
    QuestionnaireEntity *questionnaireEntity = [self.arr_questions objectAtIndex:picker.view.tag];
    if ([str_type isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *original = [info objectForKey:UIImagePickerControllerOriginalImage];
        FileEntity *entity = [[FileEntity alloc]init];
        entity.fileType = ImageType;
        entity.image = original;
        entity.filedData = UIImageJPEGRepresentation(original, 0.7);
        entity.fileSize = entity.filedData.length / (1024.0 * 1024.0);
        if (questionnaireEntity.documentData) {
            [questionnaireEntity.documentData addObject:entity];
        } else {
            questionnaireEntity.documentData = [NSMutableArray array];
            [questionnaireEntity.documentData addObject:entity];
        }
    }  else if ([str_type isEqualToString:(NSString *)kUTTypeMovie]) {
        NSURL* url = [info objectForKey:UIImagePickerControllerMediaURL];
        FileEntity *entity = [[FileEntity alloc]init];
        entity.fileType = VideoType;
        entity.fileUrl = url;
        entity.filedData = [NSData dataWithContentsOfURL:url];
        entity.fileSize = entity.filedData.length / (1024.0 * 1024.0);
        entity.image = [self getVideoFirstViewImage:url];
        if (questionnaireEntity.documentData) {
            [questionnaireEntity.documentData addObject:entity];
        } else {
            questionnaireEntity.documentData = [NSMutableArray array];
            [questionnaireEntity.documentData addObject:entity];
        }
    }
    CGFloat allSize = 0.0;
    for (FileEntity *demoEntity in questionnaireEntity.documentData) {
        allSize = allSize + demoEntity.fileSize;
    }
    if (allSize > questionnaireEntity.fileMaxSize) {
        [SVProgressHUD showInfoWithStatus:FILE_MAXSIZE_WARNING];
        [questionnaireEntity.documentData removeLastObject];
    }
    [self.tb_list reloadSections:[NSIndexSet indexSetWithIndex:picker.view.tag] withRowAnimation:UITableViewRowAnimationNone];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showDocumentPickerWithTag:(NSInteger)tag {
     
     NSArray *types = @[
         (NSString *)kUTTypeAudiovisualContent,
         (NSString *)kUTTypeImage,
         (NSString *)kUTTypePDF,
         (NSString *)kUTTypeGNUZipArchive,
         @"com.microsoft.word.doc",
         @"org.openxmlformats.wordprocessingml.document",
         @"com.microsoft.excel.xls",
         @"com.microsoft.powerpoint.​ppt"
    ];
    
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:types inMode:UIDocumentPickerModeOpen];
    documentPicker.delegate = self;
    documentPicker.view.tag = tag;
    documentPicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:documentPicker animated:YES completion:nil];

}

- (void)documentPicker:(UIDocumentPickerViewController*)controller didPickDocumentsAtURLs:(NSArray *)urls {
    
    BOOL fileUrlAuthozied = [urls.firstObject startAccessingSecurityScopedResource];
    if (fileUrlAuthozied) {
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error;
        [fileCoordinator coordinateReadingItemAtURL:urls.firstObject options:0 error:&error byAccessor:^(NSURL *newURL) {
            NSError *error = nil;
            QuestionnaireEntity *questionnaireEntity = [self.arr_questions objectAtIndex:controller.view.tag];
            FileEntity *entity = [[FileEntity alloc] init];
            entity.fileType = AllType;
            entity.fileUrl = newURL;
            entity.filedData = [NSData dataWithContentsOfURL:newURL options:NSDataReadingMappedIfSafe error:&error];
            entity.fileSize = entity.filedData.length / (1024.0 * 1024.0);
            [self dismissViewControllerAnimated:YES completion:nil];
            if (questionnaireEntity.documentData) {
                [questionnaireEntity.documentData addObject:entity];
            } else {
                questionnaireEntity.documentData = [NSMutableArray array];
                [questionnaireEntity.documentData addObject:entity];
            }
            CGFloat allSize = 0.0;
            for (FileEntity *demoEntity in questionnaireEntity.documentData) {
                allSize = allSize + demoEntity.fileSize;
            }
            if (allSize > questionnaireEntity.fileMaxSize) {
                [SVProgressHUD showInfoWithStatus:FILE_MAXSIZE_WARNING];
                [questionnaireEntity.documentData removeLastObject];
            }
            [self.tb_list reloadSections:[NSIndexSet indexSetWithIndex:controller.view.tag] withRowAnimation:UITableViewRowAnimationNone];
        }];
        [urls.firstObject stopAccessingSecurityScopedResource];
    } else {
        NSLog(@"privilege grant failed");
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QuestionnaireEntity *obj_questionnaire = [self.arr_questions objectAtIndex:indexPath.section];
    if (obj_questionnaire.questionType == checkboxType || obj_questionnaire.questionType == radioType) {
        ChoiceEntity *selectedObj = [[ChoiceEntity alloc] init];
        selectedObj = [obj_questionnaire.option objectAtIndex:indexPath.row];
        
        NSMutableArray *arr_answers = [NSMutableArray array];
        for (ChoiceEntity *obj in obj_questionnaire.option) {
            if (obj.isSelect == YES) {
                [arr_answers addObject:obj];
            }
        }
        
        if (self.obj_questionnaire.answerStatus == unansweredType) {
            if (obj_questionnaire.questionType == checkboxType) {
                selectedObj.isSelect = !selectedObj.isSelect;
            }
            if (obj_questionnaire.questionType == radioType) {
                for (ChoiceEntity *obj in obj_questionnaire.option) {
                    if (obj != selectedObj) {
                        obj.isSelect = NO;
                    } else {
                        obj.isSelect = YES;
                    }
                }
            }
        }
        [self.tb_list reloadData];
    }
    
}

//ドラッグ時にキーボードを閉じる
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

//回答処理
- (void)answerSubmit{
    
    [self.view endEditing:YES];
    
    NSMutableArray *arr_questionList = [NSMutableArray array];
    NSMutableArray *arr_fileQuestionList = [NSMutableArray array];
    for (QuestionnaireEntity *questionnaireEntity in self.arr_questions) {
        NSMutableArray *arr_choice = [NSMutableArray array];
        
        if (questionnaireEntity.questionType == ShortTextType) {
            for (ChoiceEntity *choiceEntity in questionnaireEntity.option) {
                if (choiceEntity.textValue.length > 0) {
                    [arr_choice addObject:@{@"answerText":choiceEntity.textValue,@"answerId":choiceEntity.optionId}];
                }
            }
        }
        
        if ((questionnaireEntity.questionType == TextType ||  questionnaireEntity.questionType == ProgressType) && questionnaireEntity.textValue.length > 0) {
            [arr_choice addObject:@{@"answerText":questionnaireEntity.textValue}];
        }
        
        if (questionnaireEntity.questionType == radioType || questionnaireEntity.questionType == checkboxType || questionnaireEntity.questionType == LevelType || questionnaireEntity.questionType == DropdownBoxType) {
            for (ChoiceEntity *choiceEntity in questionnaireEntity.option) {
                if (choiceEntity.isSelect == YES) {
                    if (questionnaireEntity.otherType == WithCustomization && [questionnaireEntity.option lastObject] == choiceEntity && questionnaireEntity.textValue.length > 0) {
                        [arr_choice addObject:@{@"answerText":questionnaireEntity.textValue,@"answerId":choiceEntity.optionId}];
                    } else {
                        [arr_choice addObject:@{@"answerId":choiceEntity.optionId}];
                    }
                }
            }
        }
        
        if (questionnaireEntity.questionType == OutsideType) {
            for (ChoiceEntity *choiceEntity in questionnaireEntity.outsideData) {
                if (choiceEntity.indexPath.count > 0 && choiceEntity.isSelect == YES) {
                    [arr_choice addObject:@{@"answerText":[NSString stringWithFormat:@"%@,%@",[choiceEntity.indexPath firstObject],[choiceEntity.indexPath lastObject]]}];
                }
            }
        }
        
        if (questionnaireEntity.documentData.count > 0  && questionnaireEntity.questionType == DocumentType) {
            [arr_fileQuestionList addObject:questionnaireEntity];
        }
        
        NSDictionary *dic_question = @{@"questionId":questionnaireEntity.questionId,@"questionType":[NSNumber numberWithInt:questionnaireEntity.questionType],@"answer":arr_choice,@"problemType":[NSNumber numberWithInt:questionnaireEntity.problemType]};
        
        //答えていない必答問題があるかどうかを判断する
        if ((arr_choice.count == 0 && questionnaireEntity.required == 1) || (questionnaireEntity.documentData.count == 0 && questionnaireEntity.required == 1 && questionnaireEntity.questionType == DocumentType) || (questionnaireEntity.questionType == ShortTextType && arr_choice.count < questionnaireEntity.option.count && questionnaireEntity.required == 1)) {
            NSInteger index = [self.arr_questions indexOfObject:questionnaireEntity];
            [self.tb_list scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionNone animated:YES];
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showInfoWithStatus:REQUIRED_ANSWER_WARNING];
            return;
        }
        
        if (arr_choice.count > 0) {
            [arr_questionList addObject:dic_question];
        }
        
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"questionnaireId":self.obj_questionnaire.questionnaireId,@"pushId":self.obj_questionnaire.pushId,@"questionList":arr_questionList}];
    
    if (arr_fileQuestionList.count > 0) {
        [SVProgressHUD show];
        self.isFailed = NO;
        dispatch_queue_t queueT = dispatch_queue_create("group.queue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_group_t groudT = dispatch_group_create();
        for (QuestionnaireEntity *questionnaireEntity in arr_fileQuestionList) {
            for (FileEntity *fileEntity in questionnaireEntity.documentData) {
                dispatch_group_async(groudT, queueT, ^{
                    dispatch_group_enter(groudT);
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        NSString *fileType = @"";
                        if (fileEntity.fileType == ImageType) {
                            fileType = @"png";
                        } else if (fileEntity.fileType == VideoType) {
                            fileType = @"mp4";
                        } else {
                            fileType = [fileEntity.fileUrl pathExtension];
                        }
                        NSData *fileData = fileEntity.filedData;
                        [PushHandler uploadFileWithPushId:self.obj_questionnaire.pushId questionnaireId:self.obj_questionnaire.questionnaireId questionId:questionnaireEntity.questionId fileData:fileData fileType:fileType questionType:[NSNumber numberWithInt:questionnaireEntity.questionType] Prepare:^{
                        } success:^(NSDictionary *obj) {
                            NSString *uploadUrl = [obj objectForKey:@"data"];
                            if (questionnaireEntity.documentAnswerUrls) {
                                [questionnaireEntity.documentAnswerUrls addObject:@{@"answerText":uploadUrl}];
                            } else {
                                questionnaireEntity.documentAnswerUrls = [NSMutableArray array];
                                [questionnaireEntity.documentAnswerUrls addObject:@{@"answerText":uploadUrl}];
                            }
                            dispatch_group_leave(groudT);
                        } failed:^(NSInteger statusCode, id json) {
                            dispatch_group_leave(groudT);
                            self.isFailed = YES;
                        }];
                    });
                });
            }
        }
        dispatch_group_notify(groudT, queueT, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.isFailed == YES) {
                    [SVProgressHUD showErrorWithStatus:ERROR_NETWORK];
                } else {
                    for (QuestionnaireEntity *questionnaireEntity in arr_fileQuestionList) {
                        NSDictionary *dic_question = @{@"questionId":questionnaireEntity.questionId,@"questionType":[NSNumber numberWithInt:questionnaireEntity.questionType],@"answer":questionnaireEntity.documentAnswerUrls,@"problemType":[NSNumber numberWithInt:questionnaireEntity.problemType]};
                        [arr_questionList addObject:dic_question];
                    }
                    [dic setObject:arr_questionList forKey:@"questionList"];
                    [self submitWithDic:dic];
                }
            });
        });
    } else {
        [self submitWithDic:dic];
    }
        
}

- (void)submitWithDic:(NSDictionary *)dic {
    [PushHandler submitAnswerWithDic:dic prepare:^{
        [SVProgressHUD show];
    } success:^(id obj) {
        [SVProgressHUD dismiss];
        self.answerSuccess();
        if (self.isBaseQuestion == YES) {
            QuestionnaireDetailViewController *vc = [[QuestionnaireDetailViewController alloc]init];
            vc.title = self.title;
            vc.obj_questionnaire = self.obj_questionnaire;
            vc.isBaseQuestion = NO;
            vc.answerSuccess = ^{
                self.answerSuccess();
            };
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failed:^(NSInteger statusCode, id json) {
        [SVProgressHUD showErrorWithStatus:(NSString *)json];
    }];
}

- (void)leftBarAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSString *)arrayToJSONString:(NSArray *)array
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (UIImage *)getVideoFirstViewImage:(NSURL *)path {

    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];

    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
    
}

- (void)viewDidAppear:(BOOL)animated{
  if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
  }
}
 
- (void)viewWillDisappear:(BOOL)animated{
  self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

@end
