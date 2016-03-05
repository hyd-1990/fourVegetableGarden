//
//  XU_DataBaseTool.m
//  Douban
//
//  Created by lanou3g on 16/1/4.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "XU_DataBaseTool.h"
static XU_DataBaseTool *handler = nil;
@implementation XU_DataBaseTool
+(instancetype)sharedInstance{
    if (handler == nil) {
        handler = [[self alloc]init];
    }
    return handler;
}

static sqlite3 *db = nil;

-(void)openDB{
    if (db !=nil) {
//        NSLog(@"数据库已经打开，无需重复打开");
        return;
    }
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingString:@"/dataBase.sqlite"];
    NSLog(@"%@",filePath);
    int result = sqlite3_open(filePath.UTF8String, &db);
    if (result == SQLITE_OK) {
//        NSLog(@"打开数据库成功！！");
    }else{
//        NSLog(@"打开数据库失败!!!");
    }
}

-(void)closeDB{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
//        NSLog(@"关闭数据库成功");
        db = nil;
    }else{
//        NSLog(@"关闭数据库失败");
    }
}

-(void)createTable{
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS Person (pid INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , username TEXT NOT NULL  UNIQUE , password TEXT NOT NULL)"];
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
//        NSLog(@"person创建表成功");
    }else{
//        NSLog(@"person创建表失败%d",result);
    }
}


-(void)createUserArticle{
    NSString *sql = [NSString stringWithFormat:@"CREATE  TABLE IF NOT EXISTS Article (username TEXT NOT NULL , article TEXT PRIMARY KEY  NOT NULL  UNIQUE )"];
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
//        NSLog(@"person创建表成功");
    }else{
//        NSLog(@"person创建表失败%d",result);
    }
}


-(void)addPerson:(Person *)person{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO Person (username,password) VALUES ('%@','%@')",person.username,person.password];
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
//        NSLog(@"插入数据成功");
    }
    else{
//        NSLog(@"插入数据失败%d",result);
    }
}

/*
-(int)addArticle:(UserInformation *)article {
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO Activity (username,article) VALUES ('%@','%@')",article.username,article.article];
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
//        NSLog(@"插入数据成功");
    }
    else{
//        NSLog(@"插入数据失败%d",result);
    }
    return result;
}
 */

-(NSArray<Person *> *)selectAll{
    NSMutableArray *array = [NSMutableArray array];
    NSString *sql = @"SELECT * FROM Person";
    sqlite3_stmt *stmt = NULL;
    int result = sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            Person *p = [[Person alloc]init];
            int pid = sqlite3_column_int(stmt, 0);
            NSString *username = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSString *password = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
        
            p.pid = pid;
            p.username = username;
            p.password = password;
           
            [array addObject:p];
        }
    }
    sqlite3_finalize(stmt);
    return array;
}

-(NSArray<UserInformation *> *)selectArt{
    NSMutableArray *array = [NSMutableArray array];
    NSString *sql = @"SELECT * FROM Article";
    sqlite3_stmt *stmt = NULL;
    int result = sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW){
            UserInformation *user = [[UserInformation alloc]init];
            NSString *username = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
           
            user.username = username;
            
            [array addObject:user];
        }
    }
    sqlite3_finalize(stmt);
    return array;
}

-(Person *)selectByUsername:(NSString *)username{
    Person *p = [[Person alloc]init];
    for (Person *pt in [self selectAll]) {
        if (pt.username == username) {
            p = pt;
        }
    }
    return p;
}

-(NSArray<UserInformation*>*)selectArtByUsername:(NSString*)username{
    NSMutableArray *data = [NSMutableArray array];
    for (UserInformation*u in [self selectArt]) {
        if ([u.username isEqualToString:username]) {
            [data addObject:u];
        }
    }
    return data;
}


-(void)deleteArt:(NSString*)art{
    NSLog(@"%@",art);
    NSString*sql = [NSString stringWithFormat:@"delete from Article where article = '%@'",art];
    //2执行sql语句
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
//        NSLog(@"删除成功");
    }
    else{
//        NSLog(@"删除失败%d",result);
    }
}


@end
