//
//  JY_NetTools.h
//  UILesson17_NetWorking2
//
//  Created by lanou3g on 15/12/29.
//  Copyright © 2015年 李金岩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^DataBlock)(NSData *data);
typedef void(^ImageSolveBlock)(UIImage *image);


@interface JY_NetTools : NSObject
//封装的旧方法
+ (void)solveDataWithUrl:(NSString *)stringUrl HttpMethod:(NSString *)method HttpBody:(NSString *)stringBody revokeBlock:(DataBlock)block;

//封装的新方法
//如果是解析（自己写）



//如果是下载图片  (图片都是GET方式)
+(void)SessionDownloadWithUrl:(NSString *)stringUrl revokeBlock:(ImageSolveBlock)block;


@end
