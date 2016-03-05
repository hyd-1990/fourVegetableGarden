//
//  HomeDetailViewController.m
//  MindSpace
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController ()<UIWebViewDelegate>


@property (nonatomic, strong)UIWebView *webView;

@property(nonatomic, strong)UILabel *label;

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.text]];
    
    [self.view addSubview:self.webView];
    
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 45)];
    self.label.backgroundColor = [UIColor whiteColor];
    self.label.text = self.titleText;
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.webView addSubview:self.label];
    
    
    [self.webView loadRequest:request];
    
    self.webView.delegate = self;
    
   
    
    // Do any additional setup after loading the view.
}

//实现协议
//开始加载的时候调用
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"开始加载");
    
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    //
    UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    //    [act setCenter:CGPointMake(10, 200)];
    [act setCenter:view.center];//设置旋转菊花的中心位置
    [act setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];//设置菊花的样式
    [view addSubview: act];
    
    [act startAnimating];
}

//加载失败的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    //    取消view
    UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [act stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    
    NSLog(@"加载失败");
}

//加载完成的时候调用
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //    取消view
    UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [act stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    
    NSLog(@"加载完成");
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
