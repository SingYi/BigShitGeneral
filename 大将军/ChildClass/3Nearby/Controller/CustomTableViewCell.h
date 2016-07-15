//
//  CustomTableViewCell.h
//  大将军
//
//  Created by 郑晋洋 on 2016/7/12.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell


@property (nonatomic, strong)UIImageView *ownerImageView;
@property (nonatomic, strong)UILabel *ownerID;
@property (nonatomic, strong)UILabel *distance;
@property (nonatomic, strong)UIImageView *dogImageView;
@property (nonatomic, strong)UILabel *dogName;

@end
