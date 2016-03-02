//
//  HomeModel.h
//  MindSpace
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
//图片地址
@property(nonatomic, strong)NSString *thumbnail;
//标题
@property(nonatomic, strong)NSString *title;

@property(nonatomic, strong)NSString *excerpt;
//作者
@property(nonatomic, strong)NSString *author;
//评论
@property(nonatomic, strong)NSString *comment;
//喜欢
@property(nonatomic, strong)NSString *good;
//阅读数
@property(nonatomic, strong)NSString *view;
//音频地址
@property(nonatomic, strong)NSString *fm;
//视频地址
@property(nonatomic, strong)NSString *video;
//详情地址
@property(nonatomic, strong)NSString *share;

//id
@property(nonatomic, strong)NSString *UID;

@end
