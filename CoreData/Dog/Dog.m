//
//  Dog.m
//  大将军
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "Dog.h"
#import "Owner.h"
#import "Record.h"

@implementation Dog

+ (void)insertDogToSQLiterWithContext:(NSManagedObjectContext *)ctx
                                 Name:(NSString *)name
                                 Icon:(NSData *)iconImage
                                  Sex:(NSNumber *)sex
                              Variety:(NSString *)variety
                            Neutering:(NSNumber *)neuterying
                             Birthday:(NSDate *)birthday
                                Owner:(NSManagedObject *)owner {
    /**< 2.添加数据到数据库 */
    //传入上下文,创建一个实体Dog对象
    NSManagedObject *dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:ctx];
    //设置Dog属性
    [dog setValue:name forKey:@"name"];
    [dog setValue:iconImage forKey:@"iconImage"];
    [dog setValue:sex forKey:@"sex"];
    [dog setValue:variety forKey:@"variety"];
    [dog setValue:neuterying forKey:@"neutering"];
    [dog setValue:birthday forKey:@"birthday"];
    NSError *error = nil;
    BOOL success = [ctx save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
    }else {
        NSLog(@"保存成功");
    }
}

+ (BOOL)duplicateCheckingDogWithContext:(NSManagedObjectContext *)ctx
                                  Name:(NSString *)name {
    Dog *objDog = [self fetchDogFromSQLiterWithContext:ctx Name:name];
    if (objDog) {
        NSLog(@"已存在这只狗狗!请勿重复添加!");
        return YES;
    }else {
        return NO;
    }
}

+ (Dog *)fetchDogFromSQLiterWithContext:(NSManagedObjectContext *)ctx Name:(NSString *)name {
    /**< 3.从数据库中查询数据 */
    //初始化查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要查询的实体
    request.entity = [NSEntityDescription entityForName:@"Dog" inManagedObjectContext:ctx];
    //设置排序(按birthday升序)
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"birthday" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    //设置条件过滤
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@", name];
    request.predicate = predicate;
    //执行请求
    NSError *error = nil;
    NSArray *objs = [ctx executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@",[error localizedDescription]];
    }
    //遍历数据
    for (NSManagedObject *obj in objs) {
        NSLog(@"name = %@",[obj valueForKey:@"name"]);
        NSLog(@"birthday = %@", [obj valueForKey:@"birthday"]);
        NSLog(@"sex = %@", [obj valueForKey:@"sex"]);
    }
    return [objs firstObject];
}

+ (void)deleteDogFromSQLiterWithContext:(NSManagedObjectContext *)ctx Name:(NSString *)name {
    
    Dog *dog = [self fetchDogFromSQLiterWithContext:ctx Name:name];
    /**< 4.删除数据库中的对象*/
    //传入需要删除的实体对象
    if (!dog) {
        NSLog(@"不存在这个狗狗");
        return;
    }else {
        [ctx deleteObject:dog];
    }
    
    //将结果同步到数据库
    NSError *error = nil;
    [ctx save:&error];
    if (error) {
        [NSException raise:@"删除错误" format:@"%@",[error localizedDescription]];
    }else {
        NSLog(@"删除成功");
    }
}

@end
