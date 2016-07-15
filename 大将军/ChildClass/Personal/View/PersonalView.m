//
//  PersonalView.m
//  大将军
//
//  Created by 石燚 on 16/7/7.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "PersonalView.h"

@interface PersonalView ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

//用户头像
@property (nonatomic, strong) UIImageView *userHeader;

//doggy头像
@property (nonatomic, strong) UICollectionView *collectionView;



//设置相关
@property (nonatomic, strong) UITableView *settingView;

@end

@implementation PersonalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self initUserInterface];
    }
    return self;
}

- (void)initUserInterface {
    self.backgroundColor = [UIColor blueColor];
    [self addSubview:self.userHeader];
    [self addSubview:self.settingView];
    [self addSubview:self.collectionView];
}

#pragma mark - tableViewDelegateAndDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"settingCell"];
        
    }
    cell.backgroundColor = [UIColor blackColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
}

#pragma mark - getter
- (UIImageView *)userHeader {
    if (!_userHeader) {
        _userHeader = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 20, SCREEN_HEIGHT / 20, SCREEN_WIDTH / 4, SCREEN_WIDTH / 4)];
        _userHeader.backgroundColor = [UIColor orangeColor];
        _userHeader.layer.cornerRadius = SCREEN_WIDTH / 8;
        _userHeader.layer.masksToBounds = YES;
    }
    return _userHeader;
}

- (UITableView *)settingView {
    if (!_settingView) {
        _settingView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.4, self.bounds.size.width, SCREEN_HEIGHT * 0.6) style:(UITableViewStylePlain)];
        
        _settingView.delegate = self;
        _settingView.dataSource = self;
        
        
    }
    return _settingView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 20 + SCREEN_WIDTH / 4, self.bounds.size.width, SCREEN_HEIGHT * 0.4 - SCREEN_HEIGHT / 20 - SCREEN_WIDTH / 4) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}




@end












