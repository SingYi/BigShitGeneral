//
//  TableHeader.m
//  大将军
//
//  Created by 石燚 on 16/7/11.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "TableHeader.h"
#import "DateModel.h"
#import "CollectionVCell.h"

@interface  TableHeader ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collection;

@property (nonatomic, strong) DateModel *dateModel;

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) UIView *headerView;

@end

static NSInteger recode = -1;

@implementation TableHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

#pragma mark - frame
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self initDataSource];
    [self initUserInterface];
}

#pragma mark - self-init
- (void)initDataSource {
    _dateModel = [DateModel new];
    self.date = [NSDate date];
}

- (void)initUserInterface {
    [self addSubview:self.collection];
    [self addSubview:self.headerView];
}

#pragma mark - collectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 42;
}

#pragma mark - collectionDelegate 
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    recode = indexPath.row;
    [self.collection reloadData];
    NSInteger firstDay = [_dateModel firstWeekdayInThisMonth:self.date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self.date];
    components.day = indexPath.row - firstDay + 1;
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    calender.timeZone = [NSTimeZone systemTimeZone];
    
    NSDate *date = [calender dateFromComponents:components];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"YYYY年MM月d日";
    if ([self.tableHeaderDelegate respondsToSelector:@selector(TableHeader:selectTime:)]) {
        [self.tableHeaderDelegate TableHeader:self selectTime:[formatter stringFromDate:date]];
    }
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TableCalendarCell" forIndexPath:indexPath];
    NSInteger firstDay = [self.dateModel firstWeekdayInThisMonth:self.date];
    NSInteger total = [self.dateModel totaldaysInMonth:self.date];
    if (indexPath.row == recode) {
        cell.backgroundColor = [UIColor blackColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    if (indexPath.item < firstDay) {
        cell.day.text = @"";
    } else if (indexPath.item + 1 > firstDay + total) {
        cell.day.text = @"";
    } else {
        cell.day.text = [NSString stringWithFormat:@"%ld",indexPath.row - firstDay + 1];
    }
    
    if (indexPath.row + 1 == [_dateModel day:self.date] + firstDay) {
        cell.backgroundColor = [UIColor orangeColor];
    }
    
    return cell;
}

- (void)nextMonth {
   self.date = [_dateModel nextMonth:self.date];
}

- (void)lastMonth {
    self.date = [_dateModel lastMonth:self.date];
}

#pragma mark - setter
- (void)setDate:(NSDate *)date {
    _date = date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"YYYY年MM月d日";
    if ([self.tableHeaderDelegate respondsToSelector:@selector(TableHeader:selectTime:)]) {
        [self.tableHeaderDelegate TableHeader:self selectTime:[formatter stringFromDate:date]];
    }
    [self.collection reloadData];
    
}

#pragma mark - getter
- (UICollectionView *)collection {
    if (!_collection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        //设置大小
        layout.itemSize = CGSizeMake(SCREEN_WIDTH / 7, SCREEN_WIDTH / 7);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, self.bounds.size.width, self.bounds.size.height - 20) collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        [_collection registerClass:[CollectionVCell class] forCellWithReuseIdentifier:@"TableCalendarCell"];
        
    }
    
    return _collection;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
        for (NSInteger i = 0; i < 7; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width / 7 * i, 0, self.bounds.size.width / 7, 20)];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont boldSystemFontOfSize:18];
            label.text = self.weekArray[i];
            [self.headerView addSubview:label];
        }
    }
    return _headerView;
}

- (NSArray *)weekArray {
    return @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
}


@end










