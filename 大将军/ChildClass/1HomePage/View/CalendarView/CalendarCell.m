//
//  CalendarCell.m
//  大将军
//
//  Created by 石燚 on 16/7/7.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "CalendarCell.h"

@implementation CalendarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.day];
        [self.contentView addSubview:self.month];
    }
    return self;
}


- (UILabel *)day {
    if (!_day) {
        _day = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height / 2, self.bounds.size.width, self.bounds.size.height / 2)];
        _day.font = [UIFont boldSystemFontOfSize:14];
        _day.textAlignment = NSTextAlignmentCenter;
    }
    return _day;
}

- (UILabel *)month {
    if (!_month) {
        _month = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height / 2)];
        _month.font = [UIFont boldSystemFontOfSize:10];
        _month.textAlignment = NSTextAlignmentCenter;
    }
    return _month;
}

@end
