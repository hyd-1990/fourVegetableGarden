//
//  WordsViewController.m
//  MindSpace
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import "WordsViewController.h"
#import "TableViewCell.h"
#import "CQ_NetTools.h"
#import "WordModel.h"
#import "UIImageView+WebCache.h"
#import "XiangqingViewController.h"
#import "MJRefresh.h"

#define wordurl @"http://static.owspace.com/?c=Api&a=getList&p=1&model=1&page_id=0&create_time=0&client=android&version=1.1.0&time=1456907004&device_id=865982029619197"
#define url1 @"http://static.owspace.com/?c=Api&a=getList&p="
#define url @"&model=1&page__id=291643&create_time=1454544000&client=android&version=1.1.0&time=1456907004&device_id=865982029619197"
#define urll @"&model=1&page__id=291555&create_time=1452124800&client=android&version=1.1.0&time=1456907411&device_id=865982029619197"
#define voiceurl @"http://static.owspace.com/?c=Api&a=getList&p=1&model=3&page_id=0&create_time=0&client=android&version=1.1.0&time=1456911703&device_id=865982029619197"
#define Vurl @"&model=3&page_id=291644&create_time=1454335200&client=android&version=1.1.0&time=1456911796&device_id=865982029619197"
#define filmurl @"http://static.owspace.com/?c=Api&a=getList&p=1&model=2&page_id=0&create_time=0&client=android&version=1.1.0&time=1456912856&device_id=865982029619197"
#define RankWidth [UIScreen mainScreen].bounds.size.width
#define RankHeight [UIScreen mainScreen].bounds.size.height
@interface WordsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *Wordtable;
@property (nonatomic, strong)NSMutableArray *array;

@property (nonatomic, strong)NSArray *data;

@property (nonatomic, assign)NSInteger count;
@end

@implementation WordsViewController
- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 0;
    if (self.path == 1) {
        self.navigationItem.title = @"文字";
        self.data = @[@"http://static.owspace.com/?c=Api&a=getList&p=2&model=1&page__id=291643&create_time=1454544000&client=android&version=1.1.0&time=1456907004&device_id=865982029619197",@"http://static.owspace.com/?c=Api&a=getList&p=4&model=1&page__id=291555&create_time=1452124800&client=android&version=1.1.0&time=1456907411&device_id=865982029619197"];
        
    }else if (self.path == 2){
        self.navigationItem.title = @"声音";
        self.data = @[@"http://static.owspace.com/?c=Api&a=getList&p=2&model=3&page_id=291644&create_time=1454335200&client=android&version=1.1.0&time=1456911796&device_id=865982029619197", @"http://static.owspace.com/?c=Api&a=getList&p=4&model=3&page_id=291482&create_time=1449934200&client=android&version=1.1.0&time=1456911878&device_id=865982029619197"];
    }else{
        self.navigationItem.title = @"影像";
    
      
    }
    self.Wordtable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, RankWidth, RankHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.Wordtable];
    
    self.Wordtable.delegate =self;
    self.Wordtable.dataSource = self;
    
    [self.Wordtable registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fenlei.png"] style:UIBarButtonItemStyleDone target:self action:@selector(presentLeftMenuViewController:)];
    
    [self refresh];
    
    
    [self loadDate];

//    [self downLoadGiftDataFinish:^{
//        [self.Wordtable  reloadData];
//    } withIndex:self.path];
    
   
}
#pragma mark - 刷新
- (void)refresh{
    [self.Wordtable headerBeginRefreshing];
    [self.Wordtable footerBeginRefreshing];
    
    
    [self.Wordtable addHeaderWithTarget:self action:@selector(downRefresh)];
    
    [self.Wordtable addFooterWithTarget:self action:@selector(upRefresh)];
    
    self.Wordtable.headerRefreshingText = @"钱哥正在帮您刷新";
    self.Wordtable.footerRefreshingText = @"钱哥正在帮您加载";
    
}
#pragma mark - 下拉刷新
- (void)downRefresh{
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //刷新表格
        [self.Wordtable reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.Wordtable headerEndRefreshing];
    });
    
}

#pragma mark - 上拉刷新
- (void)upRefresh{

    if (self.path == 3) {
        [self.Wordtable footerEndRefreshing];
//        self.Wordtable.footerRefreshingText = @"没数据了";
        return;
    }
    
    self.count ++;
    if (self.count >2) {
        self.Wordtable.footerPullToRefreshText = @"没有数据了";
        [self.Wordtable footerEndRefreshing];
        return;
    }

//    for (int i = 0 i < 2; i++) {
    
        [CQ_NetTools SessionModelDataWithUrl:self.data[self.count-1] HttpMethod:@"GET" HtpBody:nil revokeBlock:^(NSMutableArray *array) {
            [self.array addObjectsFromArray:array];
            [self.Wordtable reloadData];
            
        }];
//    }
        // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //刷新表格
        [self.Wordtable reloadData];
        [self.Wordtable footerEndRefreshing];
    });
    
}


- (void)loadDate{
    
//     [self getUpArray];
    
//    NSString *url3 = [NSString stringWithFormat:@"%@%ld%@", url1, index + 1, url2];
    if (self.path  == 1) {
        [CQ_NetTools SessionModelDataWithUrl:wordurl HttpMethod:@"get" HtpBody:nil revokeBlock:^(NSMutableArray *array) {
            [self.array addObjectsFromArray:array];
            [self.Wordtable reloadData];
        }];
    }else if (self.path == 2){
        
        [CQ_NetTools SessionModelDataWithUrl:voiceurl HttpMethod:@"get" HtpBody:nil revokeBlock:^(NSMutableArray *array) {
            [self.array addObjectsFromArray:array];
            [self.Wordtable reloadData];
        }];
        
    }else{
        
        [CQ_NetTools SessionModelDataWithUrl:filmurl HttpMethod:@"get" HtpBody:nil revokeBlock:^(NSMutableArray *array) {
            [self.array addObjectsFromArray:array];
            [self.Wordtable reloadData];
        }];
    }
    
    
//    [CQ_NetTools solveDataWithUrl:wordurl HttpMethod:@"GET" HttpBody:nil revokeBlock:^(NSData *data) {
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        for (NSDictionary *dic in dict[@"datas"]) {
//            WordModel *model = [[WordModel alloc]init];
//            [model setValuesForKeysWithDictionary:dic];
//            [self.array addObject:model];
//        }
//        [self.Wordtable reloadData];
//    }];
    
}


- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark --  tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.path == 1) {

        WordModel *model = self.array[indexPath.row];
        
        cell.model = model;
        
    }else if (self.path == 2){
        WordModel *model = self.array[indexPath.row];
        
        cell.model = model;


    }else{
        WordModel *model = self.array[indexPath.row];
        
        cell.model = model;

    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (self.path == 1){
        XiangqingViewController *xqVc = [[XiangqingViewController alloc]init];
        xqVc.model = self.array[indexPath.row];
        [self.navigationController pushViewController:xqVc animated:YES];
//    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 130;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
