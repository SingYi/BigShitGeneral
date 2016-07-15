//
//  VarietyView.m
//  大将军
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "VarietyView.h"
#import "HeadImageCollectionViewCell.h"
#import "HeadImageModel.h"

#define CELL_W self.bounds.size.width
#define CELL_H self.bounds.size.height

@interface VarietyView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIImageView *bodyImage;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *lab;
@property (nonatomic, strong) UICollectionView *headCollectionView;
@property (nonatomic, strong) NSArray *dogArr;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) NSMutableDictionary *userInfo;
@property (nonatomic, strong) NSString *varietyName;

@end

static NSString *HeadImageCollectionViewCellId = @"HeadImageCollectionViewCell";

@implementation VarietyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAgain];
    }
    return self;
}

- (void)initAgain {
    [self addSubview:self.bodyImage];
    [self addSubview:self.headImage];
    [self addSubview:self.lab];
    [self addSubview:self.headCollectionView];
    [self addSubview:self.nextBtn];
}

- (void)responseToNext {
    [self.userInfo setObject:self.varietyName forKey:@"variety"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickedNext" object:self userInfo:self.userInfo];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dogArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HeadImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HeadImageCollectionViewCellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    HeadImageModel *dog = self.dogArr[indexPath.item];
    cell.nameLab.text = dog.name;
    cell.iconImage.image = [UIImage imageNamed:dog.cellImage];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.headImage.animationImages = @[[UIImage imageNamed:@"change1"], [UIImage imageNamed:@"change2"], [UIImage imageNamed:@"change3"], [UIImage imageNamed:@"change4"], [UIImage imageNamed:@"change5"], [UIImage imageNamed:@"change6"], [UIImage imageNamed:@"change7"]];
    self.headImage.animationDuration = 0.2;
    self.headImage.animationRepeatCount = 1;
    [self.headImage startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.headImage stopAnimating];
        HeadImageModel *model = self.dogArr[indexPath.item];
        self.headImage.image = [UIImage imageNamed:model.iconImage];
        self.varietyName = model.name;
    });
}

#pragma mark - Getter
- (UIImageView *)bodyImage {
    if (!_bodyImage) {
        _bodyImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bodyImage"]];
        _bodyImage.bounds = CGRectMake(0, 0, CELL_W * 0.2, CELL_W * 0.2);
        _bodyImage.center = CGPointMake(CELL_W * 0.5, CELL_H * 0.23);
    }
    return _bodyImage;
}

- (UIImageView *)headImage {
    if (!_headImage) {
        _headImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dogs_name74s.png"]];
        _headImage.bounds = CGRectMake(0, 0, CELL_W * 0.2, CELL_W * 0.25);
        _headImage.center = CGPointMake(CELL_W * 0.5, CELL_H * 0.22);
        self.varietyName = @"其他犬种";
    }
    return _headImage;
}

- (UILabel *)lab {
    if (!_lab) {
        _lab = [[UILabel alloc] init];
        _lab.bounds = CGRectMake(0, 0, CELL_W * 0.5, CELL_H * 0.05);
        _lab.center = CGPointMake(CELL_W * 0.5, CELL_H * 0.35);
        _lab.text = @"来自汪星的部落";
        _lab.textColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        _lab.textAlignment = NSTextAlignmentCenter;
        _lab.font = [UIFont systemFontOfSize:15];
    }
    return _lab;
}

- (UICollectionView *)headCollectionView {
    if (!_headCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(CELL_W * 0.2, CELL_W * 0.25);
        flowLayout.minimumLineSpacing = CELL_W * 0.03;
        flowLayout.minimumInteritemSpacing = CELL_W * 0.02;
        flowLayout.sectionInset = UIEdgeInsetsMake(CELL_W * 0.03, CELL_W * 0.03, CELL_W * 0.03, CELL_W * 0.03);
        
        _headCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CELL_W - 20, CELL_H * 0.37) collectionViewLayout:flowLayout];
        _headCollectionView.center = CGPointMake(CELL_W * 0.5, CELL_H * 0.6);
        _headCollectionView.backgroundColor = [UIColor whiteColor];
        _headCollectionView.delegate = self;
        _headCollectionView.dataSource = self;
        _headCollectionView.showsVerticalScrollIndicator = NO;

        //注册原型cell
        [_headCollectionView registerClass:[HeadImageCollectionViewCell class] forCellWithReuseIdentifier:HeadImageCollectionViewCellId];
    }
    return _headCollectionView;
}

- (NSArray *)dogArr {
    if (!_dogArr) {
        _dogArr = [HeadImageModel getDogModels];
    }
    return _dogArr;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.bounds = CGRectMake(0, 0, CELL_W * 0.25, CELL_W * 0.25);
        _nextBtn.center = CGPointMake(CELL_W * 0.5, CELL_H * 0.9);
        _nextBtn.backgroundColor = COLOR(212, 20, 24);
        [_nextBtn setTitle:@"下一题" forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(responseToNext) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.layer.cornerRadius = CELL_W * 0.25 * 0.5;
        _nextBtn.layer.masksToBounds = YES;
    }
    return _nextBtn;
}

- (NSMutableDictionary *)userInfo {
    if (!_userInfo) {
        _userInfo = [NSMutableDictionary dictionary];
    }
    return _userInfo;
}
@end
