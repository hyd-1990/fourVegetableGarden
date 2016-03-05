//
//  HomeModel.m
//  MindSpace
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

- (void)setValue:(id)value forKey:(NSString *)key {
    //如果接口给的数据有和系统冲突的关键字，在这里进行判断，单独赋值
    if ([key isEqualToString:@"id"]) {
        self.UID = value;
    }
    [super setValue:value forKey:key];

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
