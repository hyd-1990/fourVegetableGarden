//
//  Sear3DViewController.m
//  MindSpace
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import "Sear3DViewController.h"
#import "PictureView.h"
#import "PicViewController.h"

@interface Sear3DViewController ()

@end

@implementation Sear3DViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.index == 2) {
        
        PictureView *view = [[PictureView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 520)];
        
        
        UIImage *image1=[UIImage imageNamed:@"1.jpg"];
        UIImage *image2=[UIImage imageNamed:@"2.jpg"];
        UIImage *image3=[UIImage imageNamed:@"3.jpg"];
        UIImage *image4=[UIImage imageNamed:@"4.jpg"];
        UIImage *image5=[UIImage imageNamed:@"5.jpg"];
        UIImage *image6=[UIImage imageNamed:@"111.jpg"];
//        UIImage *image7=[UIImage imageNamed:@"3.jpg"];
        
        //        view.imageNames=[NSArray arrayWithObjects:@"a",@"b",@"c",@"d", nil];  view.imageNames 和view.images 二选一
        view.images=[NSArray arrayWithObjects:image1,image2,image3,image4,image5,image6, nil];
        
        NSLog(@"%@", view.images[2]);
        view.backgroundColor=[UIColor clearColor];
        view.click=^(int i)
        {
            NSLog(@"单击了%d",i);
            PicViewController *pic = [[PicViewController alloc]init];
            
            if (i == 1) {
                pic.image = image1;
            }else if (i == 2){
                pic.image = image2;
            }else if (i == 3){
                pic.image = image3;
            }else if (i == 4){
                pic.image = image4;
            }else if (i == 5){
                pic.image = image5;
            }else if (i == 6){
                pic.image = image6;
            }
            [self.navigationController pushViewController:pic animated:YES];
        };
        [self.view addSubview:view];

    }
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated{
    
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
