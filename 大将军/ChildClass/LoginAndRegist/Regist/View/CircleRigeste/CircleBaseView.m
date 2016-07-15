//
//  NameView.m
//  大将军
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "CircleBaseView.h"

@interface CircleBaseView ()
@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLab;
@end

@implementation CircleBaseView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeUserInterface];
    }
    return self;
}

- (void)initializeUserInterface {
    self.backgroundColor = [UIColor whiteColor];
    [self addEdging];
    [self addSubview:self.titleView];
    [self.titleView addSubview:self.titleLab];
}

- (void)addEdging {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(SCREEN_WIDTH * 0.05, SCREEN_WIDTH * 0.05)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 10;
    shapeLayer.strokeColor = COLOR(212, 20, 24).CGColor;
    [self.layer addSublayer:shapeLayer];
}

#pragma mark - Getter
- (UIImageView *)backView {
    if (!_backView) {
        _backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpeg"]];
        _backView.frame = [UIScreen mainScreen].bounds;
        UIView *view = [[UIView alloc] initWithFrame:_backView.bounds];
        view.backgroundColor = [UIColor colorWithWhite:0.08 alpha:0.9];
        [_backView addSubview:view];
    }
    return _backView;
}

- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) * 0.15)];
        _titleView.backgroundColor = COLOR(212, 20, 24);
    }
    return _titleView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds) * 0.7, CGRectGetHeight(self.titleView.bounds) * 0.7);
        _titleLab.center = CGPointMake(CGRectGetMidX(self.titleView.bounds), CGRectGetMidY(self.titleView.bounds));
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont boldSystemFontOfSize:20];
        _titleLab.text = @"汪星人专属档案";
    }
    return _titleLab;
}
@end
