//
//  Owner.m
//  大将军
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "Owner.h"
#import "Dog.h"

@implementation Owner

+ (BOOL)insertOwnerToSQLiterWithContext:(NSManagedObjectContext *)ctx
                                Account:(NSString *)account
                               Password:(NSString *)Password
                                    Dog:(NSManagedObject *)dog {
    //传入上下文,创建Owner对象
    NSManagedObject *owner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner" inManagedObjectContext:ctx];
    
    //设置Owner属性
    [owner setValue:account forKey:@"account"];
    [owner setValue:Password forKey:@"password"];
    //设置Dog和Owner之间的关联关系
    [dog setValue:owner forKey:@"owner"];
    //利用上下文,将数据同步至永久化储存库
    
    NSError *error = nil;
    BOOL success = [ctx save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
    }else {
        NSLog(@"用户保存成功");
        return YES;
    }
    return YES;
}


+ (BOOL)duplicateCheckingOwnerWithContext:(NSManagedObjectContext *)ctx
                                  Account:(NSString *)account {
    //设置Owner属性
    Owner *ownerObj = [self fetchOwnerToSQLiterWithContext:ctx Account:account];
    if (ownerObj) {
        NSLog(@"该账号已存在,请重新输入");
        return NO;
    }else {
        return YES;
    }
}


+ (Owner *)fetchOwnerToSQLiterWithContext:(NSManagedObjectContext *)ctx
                                  Account:(NSString *)account {
    //初始化查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要查询的实体
    request.entity = [NSEntityDescription entityForName:@"Owner" inManagedObjectContext:ctx];
    //设置条件过滤
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"account like %@", account];
    request.predicate = predicate;
    //执行请求
    NSError *error = nil;
    NSArray *objs = [ctx executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@",[error localizedDescription]];
    }
    //遍历数据
    for (NSManagedObject *obj in objs) {
        NSLog(@"account = %@",[obj valueForKey:@"account"]);
    }
    return [objs firstObject];
}
@end
