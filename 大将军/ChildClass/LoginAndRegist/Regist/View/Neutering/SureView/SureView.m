//
//  SureView.m
//  大将军
//
//  Created by apple on 16/7/13.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "SureView.h"

#define CELL_W self.bounds.size.width
#define CELL_H self.bounds.size.height

@interface SureView ()
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *nextBtn;
@end

@implementation SureView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageV];
        [self addSubview:self.textView];
        [self addSubview:self.nextBtn];
    }
    return self;
}

- (void)responseToNext {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认提交?" message:@"提交后生日、性别将不可改变" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAct = [UIAlertAction actionWithTitle:@"继续提交" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"clickedNext" object:self];
    }];
    UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:@"我再想想" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:sureAct];
    [alertController addAction:cancelAct];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Getter
- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"狗1.png"]];
        _imageV.bounds = CGRectMake(0, 0, CELL_W * 0.3, CELL_H * 0.3);
        _imageV.center = CGPointMake(CELL_W * 0.5, CELL_H * 0.3);
    }
    return _imageV;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView  = [[UITextView alloc] init];
        _textView.bounds = CGRectMake(0, 0, CELL_W * 0.7, CELL_H * 0.3);
        _textView.center = CGPointMake(CELL_W * 0.5, CELL_H * 0.6);
//        _textView.backgroundColor = [UIColor redColor];
        _textView.font = [UIFont systemFontOfSize:17];
        _textView.text = [NSString stringWithFormat:@"奉天承运,皇帝诏曰:\n       即日起册封 XXX 为 铲屎大将军 \n                                 钦此"] ;
        _textView.editable = NO;
    }
    return _textView;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.bounds = CGRectMake(0, 0, CELL_W * 0.3, CELL_W * 0.3);
        _nextBtn.center = CGPointMake(CELL_W * 0.5, CELL_H * 0.8);
        _nextBtn.backgroundColor = COLOR(212, 20, 24);
        [_nextBtn setTitle:@"谢主隆恩" forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(responseToNext) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.layer.cornerRadius = CELL_W * 0.15;
        _nextBtn.layer.masksToBounds = YES;
    }
    return _nextBtn;
}
@end
