//
//  RegisterViewController.m
//  大将军
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "RegisterViewController.h"
#import "AddDogViewController.h"

#import <CoreData/CoreData.h>
#import "Dog.h"
#import "Owner.h"
#import "Context.h"

@interface RegisterViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UITextField *accountTextField;//账号
@property (nonatomic, strong) UITextField *passwordTextField;//密码
@property (nonatomic, strong) UIButton *registerBtn;//注册按钮
@property (nonatomic, strong) UIButton *delegateBtn;//协议按钮

@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
   }

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeUserInterface];
}

- (void)initializeUserInterface {
    [self setNavigation];
    [self.view addSubview:self.backView];
    [self.view addSubview:self.accountTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.delegateBtn];
}

#pragma mark - Events
- (void)responseToRegisterBtn {
    if (self.accountTextField.text.length == 0 || self.passwordTextField.text.length == 0) {
        [self showAlertWithMessage:@"大将军没有称谓或密文!"  dismiss:nil];
        return;
    }
    NSManagedObjectContext *ctx = [Context context];
    Dog *doggy = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:ctx];
    BOOL check = [Owner duplicateCheckingOwnerWithContext:ctx Account:self.accountTextField.text];
    
    if (check == NO) {
        [self showAlertWithMessage:@"用户名已存在!" dismiss:nil];
        return;
    }
    BOOL flag = [Owner insertOwnerToSQLiterWithContext:ctx Account:self.accountTextField.text   Password:self.passwordTextField.text Dog:doggy];
    if (flag == YES) {
        [self.view endEditing:true];
        [self showAlertWithMessage:@"注册成功!" dismiss:^(void){
            [[NSUserDefaults standardUserDefaults] setObject:self.accountTextField.text forKey:@"ownerAccount"];

            [self.navigationController pushViewController:[[AddDogViewController alloc] init] animated:YES];
        }];

    }else {
        [self showAlertWithMessage:@"注册失败!" dismiss:nil];
        return;
    }
}

- (void)showAlertWithMessage:(NSString *)message dismiss:(void(^)(void))dismiss{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertController dismissViewControllerAnimated:YES completion:^{
            if (dismiss) {
                dismiss();
            }
        }];
    });
}

- (void)responseToDelegateBtn {
    NSLog(@"查看协议");
}

#pragma mark - Navigation
- (void)setNavigation {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationItem.title = @"注册";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backToLoginView)];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithWhite:0.5 alpha:1];
}

- (void)backToLoginView {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Methods
- (UITextField *)createTextFieldWithCenterH:(CGFloat)centerH Placeholder:(NSString *)placeholder SecureTextEntry:(BOOL)secureTextEntry LeftLabelText:(NSString *)leftText {
    UITextField *textField = [[UITextField alloc] init];
    textField.bounds = CGRectMake(0, 0, SCREEN_WIDTH * 0.76, SCREEN_HEIGHT * 0.064);
    textField.center = CGPointMake(SCREEN_WIDTH * 0.5, centerH);
    textField.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    //占位符
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:COLOR(102, 103, 104), NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    //清除按钮
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.clearsOnBeginEditing = YES;
    //圆角
    textField.layer.cornerRadius = CGRectGetHeight(textField.bounds) * 0.5;
    textField.layer.masksToBounds = YES;
    //字体
    textField.font = [UIFont systemFontOfSize:17];
    textField.textColor = [UIColor whiteColor];
    //左视图
    UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.18, CGRectGetHeight(textField.bounds))];
    leftLab.text = leftText;
    leftLab.textAlignment = NSTextAlignmentRight;
    leftLab.textColor = [UIColor colorWithWhite:0.6 alpha:1];
    textField.leftView = leftLab;
    textField.leftViewMode = UITextFieldViewModeAlways;
    //保密输入
    if (secureTextEntry == YES) {
        textField.secureTextEntry = YES;
    }
    if (secureTextEntry == NO) {
        textField.secureTextEntry = NO;
    }
    return textField;
}


- (NSMutableAttributedString *)getBtnTitle {
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"注册表示你同意铲屎大将军服务使用协议和隐私条款" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:COLOR(102, 103, 104)}];
    [title addAttributes:@{NSForegroundColorAttributeName:COLOR(212, 20, 24)} range:NSMakeRange(7, 11)];
    [title addAttributes:@{NSForegroundColorAttributeName:COLOR(212, 20, 24)} range:NSMakeRange(19, 4)];
    return title;
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.accountTextField) {
        [textField resignFirstResponder];
        [self.passwordTextField becomeFirstResponder];
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark - Getter
- (UIImageView *)backView {
    if (!_backView) {
        _backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background1.jpeg"]];
        _backView.frame = [UIScreen mainScreen].bounds;
        UIView *view = [[UIView alloc] initWithFrame:_backView.bounds];
        view.backgroundColor = [UIColor colorWithWhite:0.08 alpha:0.9];
        [_backView addSubview:view];
    }
    return _backView;
}

- (UITextField *)accountTextField {
    if (!_accountTextField) {
        _accountTextField = [self createTextFieldWithCenterH:SCREEN_HEIGHT * 0.21 Placeholder:@" 请输入大将军暗号" SecureTextEntry:NO LeftLabelText:@"大将军: " ];
        _accountTextField.delegate = self;
    }
    return _accountTextField;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [self createTextFieldWithCenterH:SCREEN_HEIGHT * 0.3 Placeholder:@" 请输入大将军密文" SecureTextEntry:NO LeftLabelText:@"密   文: "];
        _passwordTextField.delegate = self;
    }
    return _passwordTextField;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerBtn.bounds = CGRectMake(0, 0, SCREEN_WIDTH * 0.76, SCREEN_HEIGHT * 0.064);
        _registerBtn.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.4);
        _registerBtn.backgroundColor = COLOR(212, 20, 24);
        [_registerBtn setTitle:@"注    册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(responseToRegisterBtn) forControlEvents:UIControlEventTouchUpInside];
        
        _registerBtn.layer.cornerRadius = CGRectGetHeight(_registerBtn.bounds) * 0.25;
        _registerBtn.layer.masksToBounds = YES;
    }
    return _registerBtn;
}


- (UIButton *)delegateBtn {
    if (!_delegateBtn) {
        _delegateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _delegateBtn.bounds = CGRectMake(0, 0, SCREEN_WIDTH * 0.8, SCREEN_WIDTH * 0.05);
        _delegateBtn.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.46);
        [_delegateBtn addTarget:self action:@selector(responseToDelegateBtn) forControlEvents:UIControlEventTouchUpInside];
        [_delegateBtn setAttributedTitle:[self getBtnTitle] forState:UIControlStateNormal];
    }
    
    return _delegateBtn;
}

@end
