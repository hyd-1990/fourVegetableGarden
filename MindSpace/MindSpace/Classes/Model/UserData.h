//
//  UserData.h
//  MindSpace
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInformation.h"
#import "XU_DataBaseTool.h"


@interface UserData : NSObject
@property(nonatomic, strong)Person *p;
@property(nonatomic, assign)BOOL IsLogin;
@property(nonatomic, strong)NSMutableArray *dataArticle;


@property(nonatomic, strong)UserInformation *data;

+(instancetype)sharedInstance;

-(void)addPerson:(Person*)person;

-(void)isLogin:(BOOL)login;

-(NSString*)userName;

-(void)addDataArticle:(NSArray*)article;


-(NSArray*)pushDataArticle;


@end
