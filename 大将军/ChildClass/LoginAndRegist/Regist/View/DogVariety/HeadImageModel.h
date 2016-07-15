//
//  HeadImageModel.h
//  大将军
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HeadImageModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSString *cellImage;
@property (nonatomic, strong) NSString *iconImage;



+(NSArray *)getDogModels;

@end
