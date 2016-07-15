//
//  DoggyCollectionView.h
//  大将军
//
//  Created by 石燚 on 16/7/7.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoggyCollectionView : UIView

@property (nonatomic, strong) NSArray *doggyArray;

//- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame WithDoggyArray:(NSArray *)array;

@end
