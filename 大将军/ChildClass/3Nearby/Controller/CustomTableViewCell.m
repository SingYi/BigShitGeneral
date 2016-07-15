//
//  CustomTableViewCell.m
//  大将军
//
//  Created by 郑晋洋 on 2016/7/12.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "CustomTableViewCell.h"

#define CONTENTVIEW_W self.contentView.bounds.size.width
#define CONTENTVIEW_H self.contentView.bounds.size.height

@interface CustomTableViewCell ()
@end

@implementation CustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviewsForContentView];
    }
    return self;
}

- (void)addSubviewsForContentView{
    
    [self.contentView addSubview:self.ownerImageView];
    [self.contentView addSubview:self.ownerID];
    [self.contentView addSubview:self.distance];
    
    
}

#pragma mark -- Getter

- (UIImageView *)ownerImageView {
    if (!_ownerImageView) {
        _ownerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"377adab44aed2e73fb882d4c8501a18b87d6fa69.jpg"]];
        _ownerImageView.center = CGPointMake( 60, 50);
        _ownerImageView.bounds = CGRectMake(0, 0, 80, 80);
        _ownerImageView.layer.masksToBounds = YES;
        _ownerImageView.layer.cornerRadius = _ownerImageView.bounds.size.width * 0.5;
        _ownerImageView.layer.borderWidth = 2.0;
        _ownerImageView.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return _ownerImageView;
}

- (UILabel *)ownerID {
    if (!_ownerID) {
        _ownerID = [[UILabel alloc] init];
        _ownerID.frame = CGRectMake(120, 10, 100, 35);
        
    }
    return _ownerID;
}

- (UILabel *)distance {
    if (!_distance) {
        _distance = [[UILabel alloc] init];
        _distance.frame = CGRectMake(120, 55, 100, 35);
    }
    return _distance;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
