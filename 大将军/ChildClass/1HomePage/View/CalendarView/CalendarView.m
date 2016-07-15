//
//  CalendarView.m
//  大将军
//
//  Created by 石燚 on 16/7/7.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "CalendarView.h"
#import "CalendarCell.h"
#import "CustomLayout.h"
#import "DateModel.h"

@interface CalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource>

//自定义布局
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CustomLayout *customerLayout;

//时间模型
@property (nonatomic, strong) DateModel *dateModel;

@end

@implementation CalendarView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUserDataSource];
        [self initUserInterface];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self initUserDataSource];
    [self initUserInterface];
}

- (void)initUserDataSource {
    _dateModel = [DateModel new];
}

- (void)initUserInterface {
    [self addSubview:self.collectionView];
}

#pragma mark - collectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 61;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"interesting" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor orangeColor];
    
    NSDate *beforDate = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * (-30 + indexPath.row)];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"d日";
    cell.day.text = [formatter stringFromDate:beforDate];
    formatter.dateFormat = @"M月";
    cell.month.text = [formatter stringFromDate:beforDate];
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    BOOL isWeekend = [calender isDateInWeekend:beforDate];
    if (isWeekend) {
        cell.backgroundColor = [UIColor redColor];
    }


    cell.layer.cornerRadius = 10;
    cell.layer.masksToBounds = YES;
    
    return cell;
}

#pragma mark - delegate 
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger idx = indexPath.row;
    [self.collectionView setContentOffset:CGPointMake((idx - 2) * SCREEN_WIDTH / 5, 0) animated:YES];
    
}

#pragma mark - getter
- (CustomLayout *)customerLayout {
    if (!_customerLayout) {
        _customerLayout = [CustomLayout new];
        
        //设置大小
        _customerLayout.itemSize = CGSizeMake(SCREEN_WIDTH / 5, SCREEN_WIDTH / 5);
        
        //设置方向
        _customerLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _customerLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.customerLayout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        
        _collectionView.bounces = YES;
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        //注册原型cell
        [_collectionView registerClass:[CalendarCell class] forCellWithReuseIdentifier:@"interesting"];
        _collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    }
    return _collectionView;
}

- (void)scrollToCenter {
    [self.collectionView setContentOffset:CGPointMake(([self.collectionView numberOfItemsInSection:0] / 2 - 2) * SCREEN_WIDTH / 5, 0) animated:YES];
}

#pragma mark - randomColor
- (UIColor *)randomColor {
    UIColor *color = [UIColor colorWithRed:(arc4random() % 255 + 1) / 255.0 green:(arc4random() % 255 + 1) / 255.0 blue:(arc4random() % 255 + 1) / 255.0 alpha:1];
    return color;
}

@end





