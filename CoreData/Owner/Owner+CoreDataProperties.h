//
//  Owner+CoreDataProperties.h
//  大将军
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 SingYi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Owner.h"

NS_ASSUME_NONNULL_BEGIN

@interface Owner (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *account;
@property (nullable, nonatomic, retain) NSNumber *sex;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSData *iconImage;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSManagedObject *dog;
@property (nullable, nonatomic, retain) NSManagedObject *workingDog;

@end

NS_ASSUME_NONNULL_END
