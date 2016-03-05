//
//  RigrhtViewController.m
//  MindSpace
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import "RigrhtViewController.h"
#import "LoginViewController.h"

#import "UserData.h"

@interface RigrhtViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)NSArray *rights;

@end

@implementation RigrhtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rights = @[@"消息",@"收藏",@"评论",@"离线"];
    

    
    
    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Right_cell"];
    

    [self.WordBut addTarget:self action:@selector(butAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}
- (void)butAction{
    LoginViewController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"login"];
    [self.navigationController pushViewController:login animated:YES];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([[UserData sharedInstance]IsLogin] == YES) {

        [self.WordBut setTitle:@"注销" forState:UIControlStateNormal];
        [self.WordBut addTarget:self action:@selector(rightDownAction) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        
        [self.WordBut setTitle:@"登录" forState:UIControlStateNormal];
        [self.WordBut addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    
    }
}

-(void)rightDownAction{
    [[UserData sharedInstance]isLogin:NO];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注销完成" message:@"已完成注销" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    [self viewWillAppear:YES];
}

-(void)rightAction{
    
    
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rights.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Right_cell" forIndexPath:indexPath];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Right_cell"];
    cell.textLabel.text = self.rights[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20.0];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
    
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
