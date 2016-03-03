//
//  HomeViewController.m
//  MindSpace
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "JY_NetTools.h"
#import "ListHeaders.h"
#import "HomeModel.h"
#import "MJRefresh.h"
#import "HomeDetailViewController.h"



@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic, strong)UITableView *table;

@property(nonatomic, strong)NSMutableArray *data;

@property(nonatomic, strong)NSMutableArray *refreshData;

@property(nonatomic, assign)NSInteger *page;

@property(nonatomic, strong)NSArray *array;

@property (nonatomic, assign)NSInteger count;
@end

@implementation HomeViewController

//数据懒加载
- (NSMutableArray *)refreshData {
    
    if (!_refreshData) {
        
        self.refreshData = [NSMutableArray array];
        
    }
    
    return _refreshData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 0;
    
    self.array = @[@"http://static.owspace.com/?c=Api&a=getList&p=1&model=0&page_id=0&create_time=0&client=android&version=1.1.0&time=1456974403&device_id=868014027634775"
,@"http://static.owspace.com/?c=Api&a=getList&p=2&model=0&page_id=291752&create_time=1456668000&client=android&version=1.1.0&time=1456974449&device_id=868014027634775"
,@"http://static.owspace.com/?c=Api&a=getList&p=3&model=0&page_id=291732&create_time=1456272000&client=android&version=1.1.0&time=1456974461&device_id=868014027634775"
,@"http://static.owspace.com/?c=Api&a=getList&p=4&model=0&page_id=291717&create_time=1455926400&client=android&version=1.1.0&time=1456974468&device_id=868014027634775"
,@"http://static.owspace.com/?c=Api&a=getList&p=5&model=0&page_id=291703&create_time=1455580800&client=android&version=1.1.0&time=1456974474&device_id=868014027634775"
,@"http://static.owspace.com/?c=Api&a=getList&p=6&model=0&page_id=291678&create_time=1455199200&client=android&version=1.1.0&time=1456974485&device_id=868014027634775"
,@"http://static.owspace.com/?c=Api&a=getList&p=7&model=0&page_id=291670&create_time=1454864541&client=android&version=1.1.0&time=1456974493&device_id=868014027634775"
,@"http://static.owspace.com/?c=Api&a=getList&p=8&model=0&page_id=291661&create_time=1454457600&client=android&version=1.1.0&time=1456974500&device_id=868014027634775"
,@"http://static.owspace.com/?c=Api&a=getList&p=9&model=0&page_id=291630&create_time=1454076000&client=android&version=1.1.0&time=1456974506&device_id=868014027634775"
,@"http://static.owspace.com/?c=Api&a=getList&p=10&model=0&page_id=291622&create_time=1453731193&client=android&version=1.1.0&time=1456974511&device_id=868014027634775"
,@"http://static.owspace.com/?c=Api&a=getList&p=11&model=0&page_id=291616&create_time=1453350000&client=android&version=1.1.0&time=1456974517&device_id=868014027634775"
,@"http://static.owspace.com/?c=Api&a=getList&p=12&model=0&page_id=291584&create_time=1453039200&client=android&version=1.1.0&time=1456974523&device_id=868014027634775"
,@"http://static.owspace.com/?c=Api&a=getList&p=13&model=0&page_id=291573&create_time=1452657600&client=android&version=1.1.0&time=1456974530&device_id=868014027634775"
,@"http://static.owspace.com/?c=Api&a=getList&p=14&model=0&page_id=291560&create_time=1452319200&client=android&version=1.1.0&time=1456974535&device_id=868014027634775"
,@"http://static.owspace.com/?c=Api&a=getList&p=15&model=0&page_id=291544&create_time=1451905260&client=android&version=1.1.0&time=1456974546&device_id=868014027634775"
,@"http://static.owspace.com/?c=Api&a=getList&p=16&model=0&page_id=291504&create_time=1449989700&client=android&version=1.1.0&time=1456974553&device_id=868014027634775"
,@"http://static.owspace.com/?c=Api&a=getList&p=17&model=0&page_id=291494&create_time=1449741240&client=android&version=1.1.0&time=1456974559&device_id=868014027634775"
,@"http://static.owspace.com/?c=Api&a=getList&p=18&model=0&page_id=291465&create_time=1449395100&client=android&version=1.1.0&time=1456974564&device_id=868014027634775"
 ,@"http://static.owspace.com/?c=Api&a=getList&p=19&model=0&page_id=291524&create_time=1438398300&client=android&version=1.1.0&time=1456974569&device_id=868014027634775"];
    
    
    
    self.navigationItem.title = @"心灵空间";
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fenlei.png"] style:UIBarButtonItemStyleDone target:self action:@selector(presentLeftMenuViewController:)];
    
    
    
    
    
    self.data = [NSMutableArray array];
    
    self.table = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    [self.view addSubview:self.table];
    
    
    self.table.dataSource = self;
    self.table.delegate = self;
    
    [self.table registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell_id"];
    
    [self makeData];
    [self setupRefresh];
    // Do any additional setup after loading the view.
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)setupRefresh {
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.table addHeaderWithTarget:self action:@selector(headerRereshing)];
    //自动刷新（一进入程序就下拉刷新）
    [self.table headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.table addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.table.headerPullToRefreshText = @"下拉可以刷新了";
    self.table.headerReleaseToRefreshText = @"松开马上刷新了";
    self.table.headerRefreshingText = @"正在帮您刷新中";
    
    self.table.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.table.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.table.footerRefreshingText = @"正在帮您加载中";

    
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1刷新获取新数据
//    [self makeData];
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.table reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.table footerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.加载新数据
    
    self.count ++;
    if (self.count  > 18) {
        
        [self.table headerEndRefreshing];
        NSLog(@"没有数据啦");
        return;
    }
    
  
     
        [JY_NetTools solveDataWithUrl:self.array[self.count] HttpMethod:@"GET" HttpBody:nil revokeBlock:^(NSData *data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            for (NSDictionary *dict in dic[@"datas"]) {
                HomeModel *model = [[HomeModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.data addObject:model];
                
            } 
        }];

    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.table reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.table footerEndRefreshing];
    });
}

- (void)makeData {
    [JY_NetTools solveDataWithUrl:YHomeUrl HttpMethod:@"GET" HttpBody:nil revokeBlock:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dict in dic[@"datas"]) {
            HomeModel *model = [[HomeModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.data addObject:model];
       
        }
        [self.table reloadData];
        
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id" forIndexPath:indexPath];
    HomeModel *model = self.data[indexPath.row];
    cell.model = model;
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeDetailViewController *hdc = [[HomeDetailViewController alloc] init];
    HomeModel *model = self.data[indexPath.row];
    
    
    hdc.text = model.share;
    [self.navigationController pushViewController:hdc animated:YES];
    
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
