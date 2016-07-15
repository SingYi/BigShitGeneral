//
//  NeuteringView.m
//  大将军
//
//  Created by apple on 16/7/13.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "NeuteringView.h"

#define CELL_W self.bounds.size.width
#define CELL_H self.bounds.size.height

@interface NeuteringView ()
@property (nonatomic, strong) UILabel *quesLab;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *yesBtn;
@property (nonatomic, strong) UIButton *noBtn;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *yesLab;
@property (nonatomic, strong) UILabel *noLab;
@property (nonatomic, strong) NSMutableDictionary *userInfo;
@property (nonatomic, assign) BOOL neutering;

@end

@implementation NeuteringView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.quesLab];
        [self addSubview:self.nextBtn];
        [self addSubview:self.yesBtn];
        [self addSubview:self.noBtn];
        [self addSubview:self.yesLab];
        [self addSubview:self.noLab];
    }
    return self;
}

- (void)responseToNext {
    NSNumber *neutering = [NSNumber numberWithBool:_neutering];
    [self.userInfo setObject:neutering forKey:@"neutering"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickedNext" object:self userInfo:self.userInfo];
}

- (void)chooseWithBtn:(UIButton *)sender isSelected:(BOOL)isSelected {
    
    if (self.btn) {
        self.btn.selected = NO;
    }
    if (isSelected == YES) {
        self.btn = sender;
        self.btn.selected = YES;
    }
}

- (void)responseToBtns:(UIButton *)sender {
    if (sender.tag == 102) {
//        NSLog(@"未绝育");
        _neutering = NO;
        [self chooseWithBtn:sender isSelected:YES];
    }
    if (sender.tag == 103) {
//        NSLog(@"绝育");
        _neutering = YES;
        [self chooseWithBtn:sender isSelected:YES];
    }
}

- (UIButton *)getBtnWithCenter:(CGPoint)center NormalImageName:(NSString *)normalImageName SelectedImageName:(NSString *)selectedImageName Tag:(NSInteger)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, CELL_W * 0.23, CELL_W * 0.23);
    btn.center = center;
    [btn setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:self action:@selector(responseToBtns:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (UILabel *)getLabelWithText:(NSString *)text Center:(CGPoint)center {
    UILabel *lab = [[UILabel alloc] init];
    lab.bounds = CGRectMake(0, 0, CELL_W * 0.3, CELL_H * 0.05);
    lab.center = center;
    lab.text = text;
    lab.textColor = [UIColor blackColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:10];
    return lab;
}
#pragma mark - Getter
- (UILabel *)quesLab {
    if (!_quesLab) {
        _quesLab = [[UILabel alloc] init];
        _quesLab.bounds = CGRectMake(0, 0, CELL_W * 0.7, CELL_H * 0.05);
        _quesLab.center = CGPointMake(CELL_W * 0.5, CELL_H * 0.25);
        _quesLab.textColor = COLOR(212, 20, 24);
        _quesLab.textAlignment = NSTextAlignmentCenter;
        _quesLab.text = @"麻麻,我还能生小小汪嘛?";
    }
    return _quesLab;
}

- (UIButton *)yesBtn {
    if (!_yesBtn) {
       _yesBtn = [self getBtnWithCenter:CGPointMake(CELL_W * 0.3, CELL_H * 0.5) NormalImageName:@"yes未选中.png" SelectedImageName:@"yes选中.png" Tag:102];
        [self chooseWithBtn:_yesBtn isSelected:YES];
    }
    return _yesBtn;
}

- (UIButton *)noBtn {
    if (!_noBtn) {
        _noBtn = [self getBtnWithCenter:CGPointMake(CELL_W * 0.7, CELL_H * 0.5) NormalImageName:@"no未选中.png" SelectedImageName:@"no选中.png" Tag:103];
    }
    return _noBtn;
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] init];
    }
    return _btn;
}

- (UILabel *)yesLab {
    if (!_yesLab) {
        _yesLab = [self getLabelWithText:@"是的是的还可以" Center:CGPointMake(CELL_W * 0.3, CELL_H * 0.6)];
        _neutering = NO;
    }
    return _yesLab;
}

- (UILabel *)noLab {
    if (!_noLab) {
        _noLab = [self getLabelWithText:@"不不不你不行了" Center:CGPointMake(CELL_W * 0.7, CELL_H * 0.6)];
    }
    return _noLab;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.bounds = CGRectMake(0, 0, CELL_W * 0.25, CELL_W * 0.25);
        _nextBtn.center = CGPointMake(CELL_W * 0.5, CELL_H * 0.8);
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
