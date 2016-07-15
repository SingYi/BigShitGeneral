//
//  HeadImageCollectionViewCell.m
//  大将军
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "HeadImageCollectionViewCell.h"
#define CELL_W self.bounds.size.width
#define CELL_H self.bounds.size.height

@interface HeadImageCollectionViewCell ()

@end

@implementation HeadImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconImage];
        [self addSubview:self.nameLab];
    }
    return self;
}

- (void)setDog:(HeadImageModel *)dog {
    
}


#pragma mark - Getter
- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.frame = CGRectMake(0, 0, CELL_W, CELL_W);
        _iconImage.layer.cornerRadius = CELL_W * 0.5;
        _iconImage.layer.masksToBounds = YES;
        _iconImage.backgroundColor = [UIColor redColor];
    }
    return _iconImage;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.frame = CGRectMake(0, CELL_W, CELL_W, CELL_H - CELL_W);
        _nameLab.textColor = [UIColor blackColor];
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.font = [UIFont systemFontOfSize:10];
        _nameLab.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLab;
}
@end
