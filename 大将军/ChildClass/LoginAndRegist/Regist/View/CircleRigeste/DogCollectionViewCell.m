//
//  DogCollectionViewCell.m
//  大将军
//
//  Created by apple on 16/7/11.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "DogCollectionViewCell.h"
#import "DogCollectionLayoutAttributes.h"
#import "NameView.h"

@interface DogCollectionViewCell ()
@property (nonatomic, strong) NameView *cellView;
@end

@implementation DogCollectionViewCell
- (void)layoutSubviews {
    [self initializeUserInterface];
}

- (void)initializeUserInterface {
    self.layer.cornerRadius = SCREEN_WIDTH * 0.05;
    self.layer.masksToBounds = YES;
//    [self.contentView addSubview:self.cellView];
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    
    DogCollectionLayoutAttributes *circularlayoutAttributes = (DogCollectionLayoutAttributes *)layoutAttributes;
    
    self.layer.anchorPoint = circularlayoutAttributes.anchorPoint;
    
    CGFloat num1 = circularlayoutAttributes.anchorPoint.y - 0.5;
    CGFloat num2 = self.bounds.size.height;
    
    CGPoint center = self.center;
    center.y += num1 * num2;
    self.center = center;
}

#pragma mark - Getter
- (NameView *)cellView {
    if (!_cellView) {
        _cellView = [[NameView alloc] initWithFrame:self.bounds];
    }
    return _cellView;
}
@end
