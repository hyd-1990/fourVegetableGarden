//
//  registerViewController.m
//  MindSpace
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import "registerViewController.h"
#import "XU_DataBaseTool.h"


@interface registerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (IBAction)registerAction:(UIButton *)sender {
    [[XU_DataBaseTool sharedInstance]openDB];
    [[XU_DataBaseTool sharedInstance]createTable];
    Person *p = [[Person alloc]init];
    p = [[XU_DataBaseTool sharedInstance]selectByUsername:self.name.text];
    if ([p.username isEqualToString:self.name.text]) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"ture" style:UIAlertActionStyleCancel handler:nil];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"error" message:@"已有用户名" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if ([self.name.text isEqualToString:@""]||[self.passWord.text isEqualToString:@""]) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"ture" style:UIAlertActionStyleCancel handler:nil];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"error" message:@"用户名密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if ([self.passWord.text isEqualToString: self.passWord.text]) {
        
        Person *p = [[Person alloc]init];
        p.username = self.name.text;
        p.password = self.passWord.text;
    
        [[XU_DataBaseTool sharedInstance]addPerson:p];
    }
    else{
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"ture" style:UIAlertActionStyleCancel handler:nil];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"error" message:@"两次密码输入不同" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
    
    
    [[XU_DataBaseTool sharedInstance]closeDB];
    [self.navigationController popViewControllerAnimated:YES];
    
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
