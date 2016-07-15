//
//  TableHeader.h
//  大将军
//
//  Created by 石燚 on 16/7/11.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableHeader;

@protocol TableHeaderDelegate <NSObject>

- (void)TableHeader:(TableHeader *)tableHeader selectTime:(NSString *)time;

@end

@interface TableHeader : UIView

@property (nonatomic, weak) id<TableHeaderDelegate> tableHeaderDelegate;

- (void)nextMonth;

- (void)lastMonth;

- (void)today;

@end





