//
//  XiangqingViewController.m
//  MindSpace
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import "XiangqingViewController.h"
#import "YALContextMenuTableView.h"
#import "YALNavigationBar.h"
#import "XiangTableViewCell.h"
#import "LoginViewController.h"

#define RankWidth [UIScreen mainScreen].bounds.size.width
#define RankHeight [UIScreen mainScreen].bounds.size.height
@interface XiangqingViewController ()<UITableViewDataSource,UITableViewDelegate,YALContextMenuTableViewDelegate,UIWebViewDelegate
>
@property (nonatomic, strong)UIWebView *webview;
@property (nonatomic, strong)YALContextMenuTableView *contextMenuTableView;

@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) NSArray *menuIcons;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation XiangqingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initiateMenuOptions];
    
    [self.navigationController setValue:[[YALNavigationBar alloc]init] forKeyPath:@"navigationBar"];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = right;
    self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, RankWidth, RankHeight - 64)];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_model.share]];
    [self.webview loadRequest:request];
    self.webview.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.webview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    // 自适应屏幕的宽度
        self.webview.scalesPageToFit = YES;
    [self.view addSubview:self.webview];
    
    self.webview.delegate = self;

    // Do any additional setup after loading the view from its nib.
}

#pragma mark   webView代理方法
// 开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
}

// 加载结束
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
}
// 加载出现错误
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.contextMenuTableView updateAlongsideRotation];
}

#pragma mark -- 抽屉效果第三方
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    //should be called after rotation animation completed
    [self.contextMenuTableView reloadData];
}



- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    
    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //should be called after rotation animation completed
        [self.contextMenuTableView reloadData];
    }];
    [self.contextMenuTableView updateAlongsideRotation];
    
}

- (void)rightAction{
    if (!self.contextMenuTableView) {
        self.contextMenuTableView = [[YALContextMenuTableView alloc]initWithTableViewDelegateDataSource:self];
        self.contextMenuTableView.animationDuration = 0.15;
        //optional - implement custom YALContextMenuTableView custom protocol
        self.contextMenuTableView.yalDelegate = self;
        
        //register nib
        UINib *cellNib = [UINib nibWithNibName:@"XiangTableViewCell" bundle:nil];
        [self.contextMenuTableView registerNib:cellNib forCellReuseIdentifier:@"cell"];
    }
    
    // it is better to use this method only for proper animation
    [self.contextMenuTableView showInView:self.navigationController.view withEdgeInsets:UIEdgeInsetsZero animated:YES];
}

#pragma mark - Local methods

- (void)initiateMenuOptions {
    self.menuTitles = @[@"",
                        @"评论",
                        @"点赞",
                        @"添加好友",
                        @"最爱",
                        @"登陆"];
//    self.titles = @[@"",
//                        @"已评论",
//                        @"已点赞",
//                        @"添加好友",
//                        @"已最爱",
//                        @"已登陆"];
    
    self.menuIcons = @[[UIImage imageNamed:@"Icnclose"],
                       [UIImage imageNamed:@"SendMessageIcn"],
                       [UIImage imageNamed:@"LikeIcn"],
                       [UIImage imageNamed:@"AddToFriendsIcn"],
                       [UIImage imageNamed:@"AddToFavouritesIcn"],
                       [UIImage imageNamed:@"BlockUserIcn"]];
}



#pragma mark - UITableViewDataSource, UITableViewDelegate

- (void)tableView:(YALContextMenuTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView dismisWithIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuTitles.count;
}

- (UITableViewCell *)tableView:(YALContextMenuTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XiangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell) {
        cell.menuTitleLabel.text = [self.menuTitles objectAtIndex:indexPath.row];
        cell.menuImageView.image = [self.menuIcons objectAtIndex:indexPath.row];
    }
    
    return cell;
}
#pragma mark - YALContextMenuTableViewDelegate

- (void)contextMenuTableView:(YALContextMenuTableView *)contextMenuTableView didDismissWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Menu dismissed with indexpath = %@", indexPath);
    if (indexPath.row == 5) {
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }
    
}

#pragma mark - IBAction
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
