//
//  Friends+CoreDataProperties.h
//  大将军
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 SingYi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Friends.h"

NS_ASSUME_NONNULL_BEGIN

@interface Friends (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *iconImage;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *sex;

@end

NS_ASSUME_NONNULL_END
