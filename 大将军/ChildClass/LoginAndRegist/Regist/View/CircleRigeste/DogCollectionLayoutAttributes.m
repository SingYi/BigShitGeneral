//
//  DogCollectionLayoutAttributes.m
//  大将军
//
//  Created by apple on 16/7/11.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "DogCollectionLayoutAttributes.h"

@interface DogCollectionLayoutAttributes ()

@end

@implementation DogCollectionLayoutAttributes

- (id)copyWithZone:(NSZone *)zone {
    DogCollectionLayoutAttributes *copiedAttribute = [super copyWithZone:zone];
    copiedAttribute.anchorPoint = self.anchorPoint;
    copiedAttribute.angle = self.angle;
    return copiedAttribute;
}

#pragma mark - Getter & Setter
- (CGPoint)anchorPoint {
    return CGPointMake(0.5, -1.5);
}

- (void)setAngle:(CGFloat)angle {
    _angle = angle;
//    self.zIndexs = (int)(_angle * 100000);
    self.transform = CGAffineTransformMakeRotation(_angle);
}
@end
