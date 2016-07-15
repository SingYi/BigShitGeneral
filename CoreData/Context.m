//
//  Context.m
//  coreData一对一练习
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 夏钰. All rights reserved.
//

#import "Context.h"

@implementation Context

+ (NSManagedObjectContext *)context {
    /**< 1. 搭建上下文环境 */
    //从应用程序包中加载模型文件
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    //传入模型对象, 初始化NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    //构建SQLite数据库文件路径
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",docs);
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"dog.data"]];
    //添加永久存储库(SQLite)
    NSError *error = nil;
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    
    if (store == nil) {
        [NSException raise:@"添加数据库错误" format:@"%@",[error localizedDescription]];
    }
    //初始化上下文
    NSManagedObjectContext *ctx = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    //设置persistentStoreCoordinator属性
    ctx.persistentStoreCoordinator = psc;
    return ctx;
}
@end
