//
//  DoggyLayout.m
//  大将军
//
//  Created by 石燚 on 16/7/8.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "DoggyLayout.h"

@interface DoggyLayout ()

{
    CGFloat _viewHeight;
    CGFloat _itemHeight;
}

@end

@implementation DoggyLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    if (_visibleCount < 1) {
        _visibleCount = 5;
    }

    _viewHeight = CGRectGetWidth(self.collectionView.frame);
    _itemHeight = self.itemSize.width;


}

//设置滑动范围
- (CGSize)collectionViewContentSize {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    if (cellCount > 3) {
        return CGSizeMake((_itemHeight + 10) * cellCount, CGRectGetHeight(self.collectionView.frame));
    } else {
        return CGSizeMake(SCREEN_WIDTH, CGRectGetHeight(self.collectionView.frame));
    }
    
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    CGFloat centerY = (self.collectionView.contentOffset.x) + _viewHeight / 2;
    NSInteger index = centerY / _itemHeight;
    
    NSInteger count = (self.visibleCount - 1) / 2;
    NSInteger minIndex = MAX(0, (index - count));
    NSInteger maxIndex = MIN((cellCount - 1), (index + count));
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = minIndex; i <= maxIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
    }
    return array;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attributes.size = self.itemSize;
    CGFloat attributesY ;
    
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    
    if (cellCount > 3) {
        attributesY = (_itemHeight + 10) * indexPath.row + _itemHeight / 2;
    } else {
        attributesY = SCREEN_WIDTH / (cellCount * 2) * (indexPath.row * 2 + 1);
    }
    
    attributes.center = CGPointMake(attributesY, CGRectGetHeight(self.collectionView.frame) / 2);

    
    return attributes;
}




- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}


@end















