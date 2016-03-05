//
//  WordsViewController.h
//  MindSpace
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface WordsViewController : UIViewController
@property (nonatomic, assign)NSInteger path;

//  记录每个tableView下拉更新的次数
@property (nonatomic, assign)int NUM;
//  接收一下每次更新后的URLString
@property (nonatomic, copy) NSString *ChangedUrlString;

@end
