
#ifndef InvestigationDefines_h
#define InvestigationDefines_h

#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define APP_WIDTH  [UIScreen mainScreen].applicationFrame.size.width
#define APP_HEIGHT [UIScreen mainScreen].applicationFrame.size.height

#define STATUSBAR_VER_HEIGHT     (SCREEN_HEIGHT >= 812.0 ? 44 : 20)
#define NAVIGATIONBAR_VER_HEIGHT (SCREEN_HEIGHT >= 812.0 ? 88 : 64)

//iPhone X底部は34を空ける必要があります。
#define SAFE_AREA_BOTTOM_HEIGHT (SCREEN_HEIGHT >= 812.0 ? 34 : 0)

//iphoneかiPadか判断します。
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)

//-----------------------UI FONT --------------------------------
#define FONT_SIZE_TITLE         17
#define FONT_SIZE_DESC          15
#define FONT_SIZE_MEMO          13
#define FONT_SIZE_SMALL         12

//---------------------------UI Color ----------------------
#define COLOR_BLUE_MAIN             @"#082F7D"
#define COLOR_GRADIENT_END          @"#758FD4"
#define COLOR_GRAY_BG               @"#ffffff"
#define COLOR_LINE_LIGHTGRAY        @"#e0e0e0"
#define COLOR_RED_BADGE             @"#FF3B30"
#define COLOR_GREEN_BACK            @"4CAF50"

#define COLOR_LIGHTGRAY_TEXT        @"#999999"
#define COLOR_GRAY_TEXT             @"#666666"
#define COLOR_DARKGRAY_TEXT         @"#333333"

#define SPACING_CONTROLS            12
#define ERROR_NETWORK_CODE          999

/*
 メッセージ
 */

#define MESSAGE_TITLE              @"アンケート一覧"
#define MESSAGE_NODATA             @"データがありません"
#define BUTTON_ANSWER_TEXT         @"回答する"
#define BUTTON_NEXT_TEXT           @"次へ"
#define BUTTON_SELECTFILE_TEXT     @"ファイルを選択する"
#define INPUT_NAME_PLACEHOLDER     @"名前を入力してください。"
#define INPUT_PLACEHOLDER          @"自由にご記入ください。"
#define SELECT_PLACEHOLDER         @"選択してください"
#define FILE_MAXNUMBER_WARNING     @"最大ファイル数に到達しました。"
#define FILE_MAXSIZE_WARNING       @"最大容量が超過しました。"
#define REQUIRED_ANSWER_WARNING    @"未回答の必須質問があります、回答してください。"
#define SHEET_IMAGE_TEXT           @"画像"
#define SHEET_VIDEO_TEXT           @"ビデオ"
#define SHEET_FILE_TEXT            @"ファイル"
#define ERROR_NETWORK              @"エラーが発生しました。一定時間後、再度お試しください。"

#endif
