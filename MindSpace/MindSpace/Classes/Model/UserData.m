//
//  UserData.m
//  MindSpace
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import "UserData.h"
static UserData *handle = nil;
@implementation UserData

+(instancetype)sharedInstance{
    if (handle ==nil) {
        handle = [[UserData alloc]init];
    }
    return handle;
}

-(UserInformation *)data{
    if (!_data) {
        _data = [[UserInformation alloc]init];
    }
    return _data;
}

- (NSMutableArray *)dataArticle {
    if (!_dataArticle) {
        _dataArticle = [NSMutableArray array];
    }
    return _dataArticle;
    
}

-(void)addPerson:(Person *)person{
    self.p = person;
    self.IsLogin = YES;
}

-(void)isLogin:(BOOL)login{
    self.IsLogin = login;
}

- (NSString *)userName {
    return self.p.username;
}


- (void)addDataArticle:(NSArray *)article {
    self.dataArticle = [[NSMutableArray alloc] initWithArray:article];
}


- (NSArray *)pushDataArticle {
    return self.dataArticle;
}

@end
