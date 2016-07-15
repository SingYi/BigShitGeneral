//
//  SexView.m
//  大将军
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "SexView.h"
#define CELL_W self.bounds.size.width
#define CELL_H self.bounds.size.height

@interface SexView ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *birthday;
@property (nonatomic, strong) UIDatePicker *pickerView;
@property (nonatomic, strong) UILabel *sexLab;
@property (nonatomic, strong) UIButton *maleBtn;
@property (nonatomic, strong) UIButton *famaleBtn;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) NSMutableDictionary *userInfo;
@property (nonatomic, assign) BOOL dogSex;
@end

@implementation SexView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAgain];
    }
    return self;
}

- (void)initAgain {
    [self addSubview:self.birthday];
    self.birthday.inputView = self.pickerView;
    [self addSubview:self.sexLab];
    [self addSubview:self.maleBtn];
    [self addSubview:self.famaleBtn];
    [self addSubview:self.nextBtn];
}

- (void)responseToNext {
    if (self.birthday.text.length == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"狗狗生日不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertController dismissViewControllerAnimated:YES completion:nil];
        });
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    NSDate *birthday = self.pickerView.date;
//    NSLog(@"bir = %@",birthday);
    NSNumber *sex = [NSNumber numberWithBool:self.dogSex];
    [self.userInfo setObject:birthday forKey:@"birthday"];
    [self.userInfo setObject:sex forKey:@"sex"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickedNext" object:self userInfo:self.userInfo];
}

- (void)chooseSexWithBtn:(UIButton *)sender isSelected:(BOOL)isSelected {
    
    if (self.btn) {
        self.btn.selected = NO;
    }
    if (isSelected == YES) {
        self.btn = sender;
        self.btn.selected = YES;
    }
}

- (void)responseToSexBtn:(UIButton *)sender {
//    NSLog(@"%ld", sender.tag);
    if (sender.tag == 100) {
        self.dogSex = YES;
        [self chooseSexWithBtn:sender isSelected:YES];
    }
    if (sender.tag == 101) {
        self.dogSex = NO;
        [self chooseSexWithBtn:sender isSelected:YES];
    }
}

#pragma mark - UITextFieldDelegate
// 这个是监听键盘return键的回调方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY年MM月dd日";
    formatter.locale = [NSLocale currentLocale];
    NSString *date = [formatter stringFromDate:self.pickerView.date];
    self.birthday.text = date;
    [self endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

#pragma mark - Getter
- (UITextField *)birthday {
    if (!_birthday) {
        _birthday = [[UITextField alloc] init];
        _birthday.bounds = CGRectMake(0, 0, CELL_W * 0.7, CELL_H * 0.1);
        _birthday.center = CGPointMake(CELL_W * 0.5, CELL_H * 0.35);
        _birthday.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.1];
        _birthday.placeholder = @"汪星人登陆纪念日";
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"生日.png"]];
        imageView.bounds = CGRectMake(0, 0, CELL_W * 0.15, CELL_H * 0.1);
        imageView.contentMode = UIViewContentModeCenter;
        _birthday.leftView = imageView;
        _birthday.leftViewMode = UITextFieldViewModeAlways;
        _birthday.layer.cornerRadius = CELL_H * 0.05;
        _birthday.layer.masksToBounds = YES;
        _birthday.delegate = self;
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        UIBarButtonItem *sureBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldShouldReturn:)];
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldShouldReturn:)];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        toolbar.items = @[cancelBtn, spaceItem, sureBtn];
        _birthday.inputAccessoryView = toolbar;
    }
    return _birthday;
}

- (UIDatePicker *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _pickerView.datePickerMode = UIDatePickerModeDate;
        _pickerView.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        NSDate *today = [NSDate date];
        _pickerView.maximumDate = today;
    }
    return _pickerView;
}

- (UILabel *)sexLab {
    if (!_sexLab) {
        _sexLab = [[UILabel alloc] init];
        _sexLab.bounds = CGRectMake(0, 0, CELL_W * 0.7, CELL_H * 0.05);
        _sexLab.center = CGPointMake(CELL_W * 0.5, CELL_H * 0.5);
        _sexLab.text = @"王子? 公主?";
        _sexLab.textAlignment = NSTextAlignmentCenter;
        _sexLab.textColor = COLOR(212, 20, 24);
    }
    return _sexLab;
}

- (UIButton *)maleBtn {
    if (!_maleBtn) {
        _maleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _maleBtn.bounds = CGRectMake(0, 0, CELL_W * 0.1, CELL_W * 0.1);
        _maleBtn.center = CGPointMake(CELL_W * 0.3, CELL_H * 0.65);
        [_maleBtn setImage:[UIImage imageNamed:@"男性未选中"] forState:UIControlStateNormal];
        [_maleBtn setImage:[UIImage imageNamed:@"男性选中"] forState:UIControlStateSelected];
        [_maleBtn addTarget:self action:@selector(responseToSexBtn:) forControlEvents:UIControlEventTouchUpInside];
        _maleBtn.tag = 100;
        self.dogSex = YES;
        [self chooseSexWithBtn:_maleBtn isSelected:YES];
    }
    return _maleBtn;
}

- (UIButton *)famaleBtn {
    if (!_famaleBtn) {
        _famaleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _famaleBtn.bounds = CGRectMake(0, 0, CELL_W * 0.1, CELL_W * 0.1);
        _famaleBtn.center = CGPointMake(CELL_W * 0.7, CELL_H * 0.65);
        [_famaleBtn setImage:[UIImage imageNamed:@"女性未选中"] forState:UIControlStateNormal];
        [_famaleBtn setImage:[UIImage imageNamed:@"女性选中"] forState:UIControlStateSelected];
        [_famaleBtn addTarget:self action:@selector(responseToSexBtn:) forControlEvents:UIControlEventTouchUpInside];
        _famaleBtn.tag = 101;
    }
    return _famaleBtn;
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] init];
    }
    return _btn;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.bounds = CGRectMake(0, 0, CELL_W * 0.25, CELL_W * 0.25);
        _nextBtn.center = CGPointMake(CELL_W * 0.5, CELL_H * 0.85);
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
