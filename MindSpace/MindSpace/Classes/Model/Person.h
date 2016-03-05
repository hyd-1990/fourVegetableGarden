//
//  Person.h
//  MindSpace
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic,assign)NSInteger pid;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *password;

@end
