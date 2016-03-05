//
//  LoginViewController.m
//  MindSpace
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import "LoginViewController.h"
#import "XU_DataBaseTool.h"
#import "UserData.h"
#import "HomeViewController.h"
#import "RigrhtViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passWordLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登陆";
    
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)LoginAction:(UIButton *)sender {
    Person *p = [[Person alloc]init];
    if ([self.nameLabel.text isEqualToString:@""]||[self.passWordLabel.text isEqualToString:@""]) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"ture" style:UIAlertActionStyleCancel handler:nil];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"error" message:@"请输入账户密码" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    [[XU_DataBaseTool sharedInstance]openDB];
    p = [[XU_DataBaseTool sharedInstance]selectByUsername:self.nameLabel.text];
    if ([p.username isEqualToString: self.nameLabel.text] ) {
        if ([p.password isEqualToString:self.passWordLabel.text]) {
            
        }else{
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"ture" style:UIAlertActionStyleCancel handler:nil];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"error" message:@"密码错误" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
            [[XU_DataBaseTool sharedInstance]closeDB];
            return;
        }
        
    }else{
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"ture" style:UIAlertActionStyleCancel handler:nil];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"error" message:@"无此用户" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        [[XU_DataBaseTool sharedInstance]closeDB];
        return;
    }
    
    [[UserData sharedInstance]addPerson:p];
    [[XU_DataBaseTool sharedInstance]closeDB];
    
    
    
    
    HomeViewController *hvc = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:hvc animated:YES];
    
    
    
    
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
