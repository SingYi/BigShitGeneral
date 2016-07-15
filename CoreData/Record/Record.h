//
//  Record.h
//  大将军
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Record : NSManagedObject

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
                                                Dog:(NSManagedObject *)dog;

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
                                               Dog:(NSManagedObject *)dog;

+ (BOOL)duplicateCheckingRecordWithContext:(NSManagedObjectContext *)ctx
                                   DogName:(NSString *)dogName;

+ (Record *)fetchRecordToSQLiterWithContext:(NSManagedObjectContext *)ctx
                                    DogName:(NSString *)dogName;
@end

NS_ASSUME_NONNULL_END

#import "Record+CoreDataProperties.h"
