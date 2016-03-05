//
//  CQ_NetTools.h
//  UIlesson17-NetWorking2
//
//  Created by lanou3g on 15/12/29.
//  Copyright © 2015年 徐未钱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WordModel.h"
typedef void(^DateBlok)(NSData *data);
typedef void(^imageSolveblock) (UIImage *image);//已经确定是图片
typedef void(^ModelArrayBlock)(NSMutableArray *array);
@interface CQ_NetTools : NSObject
//封装的旧方法
+(void)solveDataWithUrl:(NSString *)StringUrl HttpMethod:(NSString *)method HttpBody:(NSString *)stringBody revokeBlock:(DateBlok)block;
//新方法

////  新方法
////  如果是解析
//+ (void)SessionDataWithUrl:(NSString *)StringUrl HttpMethod:(NSString *)method HtpBody:(NSString *)stringBody revokeBlock:(DictBlock)block;
//


//如果是下载图片(只是下载图片)
+ (void)SessionDownloadWithUrl:(NSString *)stringUrl revokeBlock:(imageSolveblock)block;

//  解析返回model的数组
+ (void)SessionModelDataWithUrl:(NSString *)StringUrl HttpMethod:(NSString *)method HtpBody:(NSString *)stringBody revokeBlock:(ModelArrayBlock)block;

@end
