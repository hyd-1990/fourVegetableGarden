//
//  PicViewController.m
//  MindSpace
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import "PicViewController.h"

@interface PicViewController ()

@end

@implementation PicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imagev = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imagev.image = self.image;
    [self.view addSubview:imagev];
    
    // Do any additional setup after loading the view from its nib.
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
