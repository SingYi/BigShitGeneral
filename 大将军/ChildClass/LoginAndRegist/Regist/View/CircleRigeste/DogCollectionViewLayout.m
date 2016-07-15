//
//  DogCollectionViewLayout.m
//  大将军
//
//  Created by apple on 16/7/11.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "DogCollectionViewLayout.h"
#import "DogCollectionLayoutAttributes.h"

@interface DogCollectionViewLayout ()
//cell夹角
@property (nonatomic, assign) CGFloat anglePerItem;

//属性数组
@property (nonatomic, copy) NSArray <DogCollectionLayoutAttributes *> *attributesList;

//cell偏移角度
@property (nonatomic, assign) CGFloat angle;

//cell总偏移角度
@property (nonatomic, assign) CGFloat angleAtExtreme;


@end

@implementation DogCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.radius = 20;
        self.itemSize = CGSizeMake(SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.7);
    }
    return self;
}

//当半径改变时你需要重新计算所有值，所以要在 didSet 中调用invalidateLayout()
- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    [self invalidateLayout];
}

- (CGSize)collectionViewContentSize {
    NSInteger number = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(self.itemSize.width * number, SCREEN_HEIGHT * 0.8);
}

-(void)prepareLayout
{   //和init相似，必须call super的prepareLayout以保证初始化正确
    [super prepareLayout];
    
    CGFloat centerX = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.bounds) * 0.5f
    ;
    
    NSInteger numberOfItem = [self.collectionView numberOfItemsInSection:0];
    
    NSMutableArray *mAttributesList = [NSMutableArray arrayWithCapacity:numberOfItem];
    
    for (NSInteger index = 0; index < numberOfItem; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        DogCollectionLayoutAttributes *attributes = [DogCollectionLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        attributes.size = self.itemSize;
        attributes.center = CGPointMake(centerX, SCREEN_HEIGHT * 0.5);
        attributes.angle = -self.anglePerItem * (CGFloat)index + self.angle;
        attributes.anchorPoint = CGPointMake(0.5, -1.5);
        [mAttributesList addObject:attributes];
    }
    self.attributesList = [mAttributesList copy];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attributesList;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.attributesList[indexPath.row];
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}


#pragma mark - Getter
- (CGFloat)anglePerItem {
    return M_PI / 6;
}

- (CGFloat)angle{
    return self.angleAtExtreme * -self.collectionView.contentOffset.x / ([self collectionViewContentSize].width - CGRectGetWidth(self.collectionView.bounds));
}

- (CGFloat)angleAtExtreme{
    return [self.collectionView numberOfItemsInSection:0] > 0 ? -([self.collectionView numberOfItemsInSection:0] - 1) * self.anglePerItem : 0;
}
@end
