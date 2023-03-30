
#import "QuestionnaireListViewController.h"
#import "QuestionnaireListTableViewCell.h"
#import "QuestionnaireDetailViewController.h"
#import "UIImage+Util.h"
#import "UILabel+LineSpace.h"
#import "PushListEntity.h"
#import "ChoiceEntity.h"
#import "PushHandler.h"

@interface QuestionnaireListViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,strong)UITableView       *tb_list;
@property (nonatomic,strong)NSMutableArray    *arr_data;
@property (nonatomic,assign)NSInteger         pageNo;

@end

@implementation QuestionnaireListViewController

- (void)viewDidLoad {
    
    self.isHideLeftBtn = YES;
    [super viewDidLoad];
    
    self.title = MESSAGE_TITLE;
    
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(addAction)];
    self.navigationItem.rightBarButtonItem = btn_right;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataAction) name:@"ReceiveMessage" object:nil];
    
    self.tb_list = [[UITableView alloc]initWithFrame:CGRectMake(15,0, SCREEN_WIDTH - 30, SCREEN_HEIGHT - NAVIGATIONBAR_VER_HEIGHT - 10) style:UITableViewStyleGrouped];
    self.tb_list.delegate = self;
    self.tb_list.dataSource = self;
    self.tb_list.separatorColor = [UIColor clearColor];
    self.tb_list.backgroundColor = [UIColor whiteColor];
    self.tb_list.showsVerticalScrollIndicator = NO;
    
    self.tb_list.mj_header = [CommonRefreshGifHeader headerWithRefreshingBlock:^{
        self.pageNo = 0;
        [self reloadQuestionnaireData];
    }];
    
    self.tb_list.mj_footer = [CommonRefreshFooter footerWithRefreshingBlock:^{
        self.pageNo ++;
        [self reloadQuestionnaireData];
    }];
    
    [self.view addSubview:self.tb_list];
    [self.tb_list.mj_header beginRefreshing];
    [self.tb_list reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v_footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
    return v_footer;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr_data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"QuestionnaireListTableViewCell";
    QuestionnaireListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[QuestionnaireListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PushListEntity *obj = [[PushListEntity alloc]init];
    obj = self.arr_data[indexPath.row];
    [cell setFrameWithQuestionnaireObject:obj];
    cell.btn_answer.tag = indexPath.row;
    [cell.btn_answer addTarget:self action:@selector(answer:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)answer:(UIButton *)btn_sender {
    PushListEntity *entity = self.arr_data[btn_sender.tag];
    if (entity.answerStatus == unansweredType) {
        QuestionnaireDetailViewController *vc = [[QuestionnaireDetailViewController alloc]init];
        vc.title = self.title;
        if (entity.baseQuestion.count > 0) {
            vc.isBaseQuestion = YES;
        }
        vc.obj_questionnaire = entity;
        vc.answerSuccess = ^{
            [self.tb_list.mj_header beginRefreshing];
        };
        vc.title = entity.pushTitle;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PushListEntity *entity = self.arr_data[indexPath.row];
    entity.isOpen = !entity.isOpen;
    [tableView reloadData];
}

- (void)reloadQuestionnaireData {
    
    [PushHandler getPushListWithPageNo:self.pageNo prepare:^{
    } success:^(NSArray *obj) {
        [SVProgressHUD dismiss];
        if (self.pageNo == 0) {
            self.arr_data = [NSMutableArray arrayWithArray:obj];
            [self.tb_list.mj_header endRefreshing];
        } else {
            [self.arr_data addObjectsFromArray:obj];
            [self.tb_list.mj_footer endRefreshing];
        }
        if (self.arr_data.count > 0) {
            self.tb_list.tableFooterView = [[UIView alloc] init];
        } else {
            self.tb_list.tableFooterView = [[NoDataView alloc]initWithFrame:CGRectMake(0, 0, self.tb_list.frame.size.width, self.tb_list.frame.size.height)];
        }
        [self.tb_list reloadData];
    } failed:^(NSInteger statusCode, id json) {
        if (self.pageNo == 0) {
            [self.tb_list.mj_header endRefreshing];
        } else {
            [self.tb_list.mj_footer endRefreshing];
        }
        [SVProgressHUD showErrorWithStatus:(NSString *)json];
    }];
    
}

- (void)addAction {
    [PushHandler sendPushWithPrepare:^{
        [SVProgressHUD show];
    } success:^(id obj) {
        [SVProgressHUD dismiss];
        [self.tb_list.mj_header beginRefreshing];
    } failed:^(NSInteger statusCode, id json) {
        [SVProgressHUD showErrorWithStatus:(NSString *)json];
    }];
}

- (void)reloadDataAction {
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.1f];
}

- (void)delayMethod {
    [self.tb_list.mj_header beginRefreshing];
}

@end
