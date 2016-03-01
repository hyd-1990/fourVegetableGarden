//
//  LeftViewController.m
//  MindSpace
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import "LeftViewController.h"
#import "WordsViewController.h"
#import "VoicesViewController.h"
#import "SearchViewController.h"
#import "RESideMenu.h"

@interface LeftViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *lefs;
@property (nonatomic, assign) NSInteger previousRow;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    _lefs = @[@"首页",@"文字",@"声音",@"影像",@"日历",@"搜索"];
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width - 64);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"left_cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    //    self.tableView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.tableView];

    // Do any additional setup after loading the view.
}
//设置状态栏
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lefs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"left_cell" forIndexPath:indexPath];
        //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.lefs[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20.0];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.highlightedTextColor = [UIColor grayColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIViewController *center;
    if (indexPath.row == 0) {
        center = self.sideMenuViewController.mainController;
    }else if(0< indexPath.row && indexPath.row <=3){
        WordsViewController *words = [[WordsViewController alloc ] init];
        words.path = indexPath.row;
        center = [[UINavigationController alloc] initWithRootViewController:words];
    }else if(indexPath.row == 4){
        VoicesViewController *rili = [[VoicesViewController alloc ] init];
        center = [[UINavigationController alloc] initWithRootViewController:rili];
        
    }else if(indexPath.row == 5){
        SearchViewController *search = [[SearchViewController alloc ] init];
                center = [[UINavigationController alloc] initWithRootViewController:search];
    }
//    else{
//        SearchViewController *search = [[SearchViewController alloc ] init];
//        center = [[UINavigationController alloc] initWithRootViewController:search];
//    }
    [self.sideMenuViewController setContentViewController:center
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
    self.previousRow = indexPath.row;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
