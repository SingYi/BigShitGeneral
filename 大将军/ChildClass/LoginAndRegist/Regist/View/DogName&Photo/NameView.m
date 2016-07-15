//
//  NameView.m
//  大将军
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "NameView.h"
#import "Context.h"
#import "Dog.h"
#import "Owner.h"

#define CELL_W self.bounds.size.width
#define CELL_H self.bounds.size.height

@interface NameView ()<UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    
}
@property (nonatomic, strong) UIButton *headIcon;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) NSMutableDictionary *userInfo;
@end

@implementation NameView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAgain];
    }
    return self;
}


- (void)initAgain {
    [self addSubview:self.headIcon];
    [self addSubview:self.nameTextField];
    [self addSubview:self.nextBtn];
}

- (void)responseToNext {
    [self.nameTextField resignFirstResponder];
    NSData *iconImage = UIImageJPEGRepresentation(self.headIcon.currentImage, 0.5);
    NSString *name = self.nameTextField.text;
    if (self.nameTextField.text.length == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"狗狗名称不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertController dismissViewControllerAnimated:YES completion:nil];
        });
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    NSManagedObjectContext *ctx = [Context context];
    BOOL dogExist = [Dog duplicateCheckingDogWithContext:ctx Name:name];
    
    if (dogExist == YES) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"狗狗重复啦,重新去个名字吧!" message:nil preferredStyle:UIAlertControllerStyleAlert];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertController dismissViewControllerAnimated:YES completion:nil];
        });
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{
        }];
        return;
    }else {
        [self.userInfo setObject:iconImage forKey:@"iconImage"];
        [self.userInfo setObject:name forKey:@"name"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"clickedNext" object:self userInfo:self.userInfo];
    }

}

- (void)addPhoto {
    UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
    pickerView.delegate = self;
    
    if  ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请选择照片来源" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *photoLibraryAct = [UIAlertAction actionWithTitle:@"打开照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            pickerView.sourceType = UIImagePickerControllerSourceTypePhotoLibrary | UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pickerView animated:YES completion:nil];
        }];
        UIAlertAction *cameraAct = [UIAlertAction actionWithTitle:@"打开照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerView.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            pickerView.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pickerView animated:YES completion:nil];
        }];
        UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:photoLibraryAct];
        [alertController addAction:cameraAct];
        [alertController addAction:cancelAct];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if ((picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) | UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
        UIImage  *photo = info[UIImagePickerControllerOriginalImage];
//        NSLog(@"%@", photo);
        [self.headIcon setImage:photo forState:UIControlStateNormal];
    }
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImage *photo = info[UIImagePickerControllerOriginalImage];
//        NSLog(@"%@", photo);
        [self.headIcon setImage:photo forState:UIControlStateNormal];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate
// 这个是监听键盘return键的回调方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}


#pragma mark - Getter

- (UIButton *)headIcon {
    if (!_headIcon) {
        _headIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        _headIcon.bounds = CGRectMake( 0, 0, CGRectGetWidth(self.bounds) * 0.4, CGRectGetWidth(self.bounds) * 0.4);
        _headIcon.center = CGPointMake(CELL_W * 0.5, CELL_H * 0.35);
        _headIcon.backgroundColor = COLOR(212, 20, 24);
        _headIcon.layer.cornerRadius = CELL_W * 0.2;
        _headIcon.layer.masksToBounds = YES;
        [_headIcon setImage:[UIImage imageNamed:@"拍照.png"] forState:UIControlStateNormal];
        [_headIcon addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headIcon;
}

- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.bounds = CGRectMake(0, 0, CELL_W * 0.8, CELL_H * 0.1);
        _nameTextField.center = CGPointMake(CELL_W * 0.5, CELL_H * 0.6);
        _nameTextField.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.1];
        _nameTextField.placeholder = @"点此输入汪星人代号";
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"狗爪.png"]];
        imageView.bounds = CGRectMake(0, 0, CELL_W * 0.15, CELL_H * 0.1);
        imageView.contentMode = UIViewContentModeCenter;
        _nameTextField.leftView = imageView;
        _nameTextField.leftViewMode = UITextFieldViewModeAlways;
        _nameTextField.layer.cornerRadius = CELL_H * 0.05;
        _nameTextField.layer.masksToBounds = YES;
        _nameTextField.delegate = self;
        _nameTextField.returnKeyType = UIReturnKeyDone;
    }
    return _nameTextField;
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
