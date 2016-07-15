//
//  LocalDogListViewController.m
//  大将军
//
//  Created by 郑晋洋 on 16/7/7.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "LocalDogListViewController.h"
#import "CustomTableViewCell.h"

#import <AMapSearchKit/AMapSearchKit.h>

@interface LocalDogListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *searchTableView;
@property (nonatomic, strong) NSArray *poi1;

@end

@implementation LocalDogListViewController

static NSString *cellIdentifier = @"Identifier";

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noty:) name:@"1" object:nil];
}

- (void)noty:(NSNotification *)notify {
    self.poi1 = [NSArray arrayWithArray:notify.object];
    [_searchTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSearchTableView];
}

#pragma mark -- Init
- (void)initSearchTableView {
    self.searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49) style:UITableViewStylePlain];
    self.searchTableView.backgroundColor = [UIColor whiteColor];
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
//    [self.searchTableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.searchTableView];
    
}

#pragma mark -- UITableViewDelegateAndDataSources
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.poi1.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    AMapNearbyUserInfo *info = self.poi1[indexPath.row];
    cell.ownerID.text = [NSString stringWithFormat:@"昵称：%@",info.userID];
    cell.distance.text = [NSString stringWithFormat:@"距离：%d米",(int)info.distance];
    
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d米",(int)info.distance];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}




@end
