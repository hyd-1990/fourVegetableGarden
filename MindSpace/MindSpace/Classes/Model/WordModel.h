//
//  WordModel.h
//  MindSpace
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordModel : NSObject
//标题
@property (nonatomic, copy)NSString *title;

//作者
@property (nonatomic, copy)NSString *author;

//图片
@property (nonatomic, copy)NSString *thumbnail;

//网页
@property (nonatomic,copy)NSString *share;

@end
