//
//  Dog.h
//  大将军
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Owner, Record;

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSManagedObject

+ (void)insertDogToSQLiterWithContext:(NSManagedObjectContext *)ctx
                                 Name:(NSString *)name
                                 Icon:(NSData *)iconImage
                                  Sex:(NSNumber *)sex
                              Variety:(NSString *)variety
                            Neutering:(NSNumber *)neuterying
                             Birthday:(NSDate *)birthday
                                Owner:(NSManagedObject *)owner;

+ (Dog *)fetchDogFromSQLiterWithContext:(NSManagedObjectContext *)ctx Name:(NSString *)name;

+ (void)deleteDogFromSQLiterWithContext:(NSManagedObjectContext *)ctx Name:(NSString *)name;
+ (BOOL)duplicateCheckingDogWithContext:(NSManagedObjectContext *)ctx
                                   Name:(NSString *)name;
@end

NS_ASSUME_NONNULL_END

#import "Dog+CoreDataProperties.h"
