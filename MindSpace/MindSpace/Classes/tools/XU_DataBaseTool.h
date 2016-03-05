//
//  XU_DataBaseTool.h
//  Douban
//
//  Created by lanou3g on 16/1/4.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "UserInformation.h"
#import "sqlite3.h"

@interface XU_DataBaseTool : NSObject
//@property(nonatomic,strong)NSMutableArray *data;

+(instancetype)sharedInstance;

-(void)openDB;

-(void)closeDB;

-(void)createTable;

-(void)addPerson:(Person*)person;

-(NSArray<Person*>*)selectAll;

-(Person *)selectByUsername:(NSString*)username;

-(void)createUserArticle;

-(int)addArticle:(UserInformation*)article;

-(NSArray<UserInformation*>*)selectArt;

-(NSArray<UserInformation*>*)selectArtByUsername:(NSString*)username;


-(void)deleteArt:(NSString*)art;



@end
