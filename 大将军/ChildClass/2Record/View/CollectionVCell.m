//
//  CollectionVCell.m
//  大将军
//
//  Created by 石燚 on 16/7/11.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "CollectionVCell.h"

@implementation CollectionVCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.day];
    }
    return self;
}


- (UILabel *)day {
    if (!_day) {
        _day = [[UILabel alloc]initWithFrame:self.bounds];
        _day.textColor = [UIColor redColor];
        _day.font = [UIFont boldSystemFontOfSize:24];
        _day.textAlignment = NSTextAlignmentCenter;
    }
    return _day;
}

@end
