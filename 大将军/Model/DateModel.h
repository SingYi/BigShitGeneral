//
//  DateModel.h
//  大将军
//
//  Created by 石燚 on 16/7/7.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateModel : NSObject


#pragma mark - method
//第一天是星期几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;

//一个月有多少天
- (NSInteger)totaldaysInMonth:(NSDate *)date;

//上一个月
- (NSDate *)lastMonth:(NSDate *)date;

//下一个月
- (NSDate *)nextMonth:(NSDate *)date;

#pragma mark - data
- (NSInteger)day:(NSDate *)date;

- (NSInteger)month:(NSDate *)date;

- (NSInteger)year:(NSDate *)date;

@end
