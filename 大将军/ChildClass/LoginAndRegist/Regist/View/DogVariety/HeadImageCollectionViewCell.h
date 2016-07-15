//
//  HeadImageCollectionViewCell.h
//  大将军
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadImageModel.h"

@interface HeadImageCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) HeadImageModel *dog;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *nameLab;
@end
