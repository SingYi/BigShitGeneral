//
//  RecordController.m
//  大将军
//
//  Created by 石燚 on 16/7/6.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "RecordController.h"
#import "TableRecord1Cell.h"
#import "TableHeader.h"

@interface RecordController ()<UITableViewDelegate,UITableViewDataSource,TableHeaderDelegate>

//记录的table
@property (nonatomic, strong) UITableView *tableView;
//头部视图的日历
@property (nonatomic, strong) TableHeader *tableHeader;

@property (nonatomic, strong) NSArray *cellTitleArray;

//上一月和下一月
@property (nonatomic, strong) UIButton *nextMonthBtn;
@property (nonatomic, strong) UIButton *lastMonthBtn;

@end

@implementation RecordController


- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUserDataSuource];
    [self initUserInterface];
    
}

//初始化数据源
- (void)initUserDataSuource {
    
}

//初始化界面
- (void)initUserInterface {
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.tableView];
    [self.navigationController.navigationBar addSubview:self.nextMonthBtn];
    [self.navigationController.navigationBar addSubview:self.lastMonthBtn];
}

#pragma mark - talbeViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    cell.textLabel.text = self.cellTitleArray[indexPath.row];

    UISwitch *cellSwitch = [[UISwitch alloc]init];
    [cellSwitch addTarget:self action:@selector(switchAction:) forControlEvents:(UIControlEventValueChanged)];
    cellSwitch.on = NO;
    
    cell.accessoryView = cellSwitch;
    
    if (indexPath.row == self.cellTitleArray.count - 1) {
        cell.accessoryView = nil;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;;
    }

    return cell;
}

#pragma makr - CELLSWITCH
- (void)switchAction:(UISwitch *)sender {
    if (sender.on) {
        NSLog(@"1");
    } else {
        NSLog(@"2");
    }
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_HEIGHT / 10;
}

#pragma mark - tableHeaderDelegate 
- (void)TableHeader:(TableHeader *)tableHeader selectTime:(NSString *)time {
    self.navigationItem.title = time;
}

#pragma mark - nextMonthAndlastMonth
- (void)nextMonth {
    [self.tableHeader nextMonth];
}

- (void)lastMonth {
    [self.tableHeader lastMonth];
}


#pragma mark - getter
//table视图
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = [UIColor redColor];

        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[TableRecord1Cell class] forCellReuseIdentifier:@"TableRecord1Cell"];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
        
        _tableView.tableHeaderView = self.tableHeader;
    }
    return _tableView;
}

//上一月和下一月
- (UIButton *)nextMonthBtn {
    if (!_nextMonthBtn) {
        _nextMonthBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_nextMonthBtn setTitle:@"下一月" forState:(UIControlStateNormal)];
        _nextMonthBtn.frame = CGRectMake(SCREEN_WIDTH / 7 * 5, self.navigationController.navigationBar.bounds.size.height / 3, SCREEN_WIDTH / 7, self.navigationController.navigationBar.bounds.size.height / 2);
        [_nextMonthBtn setBackgroundColor:[UIColor redColor]];
        _nextMonthBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_nextMonthBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_nextMonthBtn addTarget:self action:@selector(nextMonth) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _nextMonthBtn;
}

- (UIButton *)lastMonthBtn {
    if (!_lastMonthBtn) {
        _lastMonthBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_lastMonthBtn setTitle:@"上一月" forState:(UIControlStateNormal)];
        _lastMonthBtn.frame = CGRectMake(SCREEN_WIDTH / 7, self.navigationController.navigationBar.bounds.size.height / 3, SCREEN_WIDTH / 7, self.navigationController.navigationBar.bounds.size.height / 2);
        [_lastMonthBtn setBackgroundColor:[UIColor redColor]];
        [_lastMonthBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _lastMonthBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_lastMonthBtn addTarget:self action:@selector(lastMonth) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _lastMonthBtn;
}

//头部视图的日历
- (TableHeader *)tableHeader {
    if (!_tableHeader) {
        _tableHeader = [[TableHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH / 7 * 6 + 20)];
        _tableHeader.backgroundColor = [UIColor whiteColor];
        _tableHeader.tableHeaderDelegate = self;
    }
    
    return _tableHeader;
}

- (NSArray *)cellTitleArray {
    if (!_cellTitleArray) {
        _cellTitleArray = @[@"体外驱虫",@"体内驱虫",@"免疫疫苗",@"弓形虫免疫",@"怀孕",@"生宝宝",@"纪念日"];
    }
    return _cellTitleArray;
}



@end










