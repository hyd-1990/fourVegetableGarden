//
//  JY_NetTools.m
//  UILesson17_NetWorking2
//
//  Created by lanou3g on 15/12/29.
//  Copyright © 2015年 李金岩. All rights reserved.
//

#import "JY_NetTools.h"

@implementation JY_NetTools

+ (void)solveDataWithUrl:(NSString *)stringUrl HttpMethod:(NSString *)method HttpBody:(NSString *)stringBody revokeBlock:(DataBlock)block{
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //将所有的字母转换成大写
    NSString *Smethod = [method uppercaseString];
    if ([@"POST" isEqualToString:Smethod]) {
        [request setHTTPMethod:Smethod];
        NSData *bodyData = [stringBody dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodyData];
    } else if ([@"GET" isEqualToString:Smethod]){
        
    } else {
//        NSLog(@"方法类型参数错误");
        @throw [NSException exceptionWithName:@"JY Param Error" reason:@"方法类型参数错误" userInfo:nil];
        return;
    }
    //发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        block(data);
    }];
}

+(void)SessionDownloadWithUrl:(NSString *)stringUrl revokeBlock:(ImageSolveBlock)block{
    //1 创建URL
    NSURL *url = [NSURL URLWithString:stringUrl];
    //2 创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //3 创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    //4创建任务
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *ImageData = [NSData dataWithContentsOfURL:location];
        
        UIImage *image = [UIImage imageWithData:ImageData];
        
        //从子线程回到主线程进行界面更新
        dispatch_async(dispatch_get_main_queue(), ^{
            block(image);
        });

    }];
    [task resume];
}

@end
