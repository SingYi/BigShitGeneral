//
//  Record.m
//  大将军
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "Record.h"
#import "Dog.h"

@implementation Record
+ (BOOL)insertRecordOfFamaleDogToSQLiterWithContext:(NSManagedObjectContext *)ctx
                                     ppv:(NSDate *)ppv
                               distemper:(NSDate *)distemper
                             coronavirus:(NSDate *)coronavirus
                                  rabies:(NSDate *)rabies
                              toxoplasma:(NSDate *)toxoplasma
                           ininsecticide:(NSDate *)ininsecticide
                          outinsecticide:(NSDate *)outinsecticide
                                pregnant:(NSDate *)pregnant
                                delivery:(NSDate *)delivery
                               neutering:(NSNumber *)neutering
                                   other:(NSString *)other
                                    Dog:(NSManagedObject *)dog {
    //传入上下文,创建Dog对象
    NSManagedObject *record = [NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:ctx];
    
    [record setValue:ppv forKey:@"ppv"];
    [record setValue:distemper forKey:@"distemper"];
    [record setValue:coronavirus forKey:@"coronavirus"];
    [record setValue:rabies forKey:@"rabies"];
    [record setValue:toxoplasma forKey:@"toxoplasma"];
    [record setValue:ininsecticide forKey:@"ininsecticide"];
    [record setValue:pregnant forKey:@"pregnant"];
    [record setValue:delivery forKey:@"delivery"];
    [record setValue:other forKey:@"other"];
    [record setValue:outinsecticide forKey:@"outinsecticide"];
    [record setValue:dog forKey:@"dog"];
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

+ (BOOL)insertRecordOfMmaleDogToSQLiterWithContext:(NSManagedObjectContext *)ctx
                                               ppv:(NSDate *)ppv
                                         distemper:(NSDate *)distemper
                                       coronavirus:(NSDate *)coronavirus
                                            rabies:(NSDate *)rabies
                                        toxoplasma:(NSDate *)toxoplasma
                                     ininsecticide:(NSDate *)ininsecticide
                                    outinsecticide:(NSDate *)outinsecticide
                                         neutering:(NSNumber *)neutering
                                             other:(NSString *)other
                                               Dog:(NSManagedObject *)dog {
    //传入上下文,创建Dog对象
    NSManagedObject *record = [NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:ctx];
    
    [record setValue:ppv forKey:@"ppv"];
    [record setValue:distemper forKey:@"distemper"];
    [record setValue:coronavirus forKey:@"coronavirus"];
    [record setValue:rabies forKey:@"rabies"];
    [record setValue:toxoplasma forKey:@"toxoplasma"];
    [record setValue:ininsecticide forKey:@"ininsecticide"];
    [record setValue:other forKey:@"other"];
    [record setValue:outinsecticide forKey:@"outinsecticide"];
    [record setValue:dog forKey:@"dog"];
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

+ (BOOL)duplicateCheckingRecordWithContext:(NSManagedObjectContext *)ctx
                                   DogName:(NSString *)dogName {
    Record *recordObj = [self fetchRecordToSQLiterWithContext:ctx DogName:dogName];
    if (recordObj) {
        NSLog(@"这只狗狗已经有记录了");
        return YES;
    }else {
        return NO;
    }
}


+ (Record *)fetchRecordToSQLiterWithContext:(NSManagedObjectContext *)ctx
                                    DogName:(NSString *)dogName {
    //初始化查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要查询的实体
    request.entity = [NSEntityDescription entityForName:@"Record" inManagedObjectContext:ctx];
    //设置条件过滤
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@", dogName];
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
