//
//  TableRecord1Cell.m
//  大将军
//
//  Created by 石燚 on 16/7/8.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "TableRecord1Cell.h"

@implementation TableRecord1Cell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUserInterface];
    }
    return self;
}

- (void)initUserInterface {
    
}


#pragma mark - getter
- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.frame = CGRectMake(20, 0, self.bounds.size.width / 3, self.bounds.size.height);
        
        _titleLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLable];
    }
    return _titleLable;
}

- (UISwitch *)cellSwitch {
    if (!_cellSwitch) {
        _cellSwitch = [[UISwitch alloc]init];
        _cellSwitch.center = CGPointMake(self.bounds.size.width / 4 * 3, self.bounds.size.height / 2);
    }
    return _cellSwitch;
}






@end





