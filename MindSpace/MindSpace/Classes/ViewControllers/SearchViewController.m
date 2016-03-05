//
//  SearchViewController.m
//  MindSpace
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import "SearchViewController.h"
#import "Sear3DViewController.h"

#define k_FontSize         (arc4random() % 18) + 16
@interface SearchViewController ()

@end

@implementation SearchViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"搜索";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fenlei.png"] style:UIBarButtonItemStyleDone target:self action:@selector(presentLeftMenuViewController:)];
    
    self.navigationController.navigationBar.translucent = NO;
    [self labelCloud];
    // Do any additional setup after loading the view from its nib.
}
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)labelCloud{
    NSArray *colorArray = @[[UIColor greenColor],[UIColor blueColor],[UIColor purpleColor],[UIColor redColor],[UIColor grayColor],[UIColor magentaColor],[UIColor brownColor]];
    NSMutableArray *titlesArray = [[NSMutableArray alloc] initWithObjects:@"全部",@"日本",@"欧美",@"华语",@"韩国",@"音乐人",@"翻唱",@"电影0+-",@"其他", nil];
    NSMutableArray *frameArray = [[NSMutableArray alloc] initWithObjects:@"{{80, 22}, {240, 30}}",@"{{46, 158}, {240, 30}}",@"{{152, 54}, {240, 30}}",@"{{84, 76}, {240, 30}}",@"{{200, 105}, {240, 30}}",@"{{80, 120}, {250, 30}}",@"{{152, 168}, {250, 30}}",@"{{190, 199}, {250, 30}}",@"{{67, 220}, {250, 30}}", nil];
     
    for (UILabel *label in [self.view subviews]) {
        label.text = [titlesArray objectAtIndex:0];
        [titlesArray removeObjectAtIndex:0];
        label.textColor = colorArray[arc4random()%[colorArray count]];
        label.font = [UIFont systemFontOfSize:k_FontSize];
        label.frame = CGRectZero;
        label.center = self.view.center;
        label.userInteractionEnabled = YES;
        
        [UIView animateWithDuration:2 animations:^{
            label.frame = CGRectFromString(frameArray[0]);
            [frameArray removeObjectAtIndex:0];
        } completion:nil];
        
        // 监听点击
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClik:)]];
    }
    
}
/**
 *  监听label的点击
 */
- (void)labelClik:(UITapGestureRecognizer *)recognizer
{
    //获得点击的label、
    UILabel *label = (UILabel *)recognizer.view;
    
    //初始化控制器
    Sear3DViewController *vc = [[Sear3DViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    switch (label.tag) {
        case 0:

            vc.title = @"全部";
            break;
        case 1:

            vc.title = @"欧美";
        case 2:
            
            vc.title = @"其他";
            break;
            
        case 3:

            vc.title = @"华语";
            break;
            
        case 4:

            vc.title = @"韩国";
            break;
            
        case 5:

            vc.title = @"日本";
            break;
            
        case 6:

           vc.title = @"音乐人";
            break;
            
        case 7:

            vc.title = @"翻唱";
            break;
            
        case 8:
            vc.title = @"电影";
            break;
        default:
            break;
    }
    
    vc.index = label.tag;
    NSLog(@"%ld", label.tag);
   
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
