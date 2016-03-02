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
#import "HomeDetailController.h"


@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic, strong)UITableView *table;

@property(nonatomic, strong)NSMutableArray *data;

@property(nonatomic, strong)NSMutableArray *refreshData;


@end

@implementation HomeViewController

//数据懒加载
- (NSMutableArray *)refreshData {
    
    if (!_refreshData) {
        self.refreshData = [NSMutableArray array];
        //下拉加载数据
        
        
        
    }
    
    return _refreshData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"心灵空间";
    
    
    
    self.data = [NSMutableArray array];
    
    self.table = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    [self.view addSubview:self.table];
    
    
    self.table.dataSource = self;
    self.table.delegate = self;
    
    [self.table registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell_id"];
    
//    [self makeData];
    [self setupRefresh];
    // Do any additional setup after loading the view.
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
    [self makeData];
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.table reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.table headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.加载新数据
    [JY_NetTools solveDataWithUrl:YHome1Url HttpMethod:@"GET" HttpBody:nil revokeBlock:^(NSData *data) {
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
    HomeDetailController *hdc = [[HomeDetailController alloc] init];
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
