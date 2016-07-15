//
//  HeadImageModel.m
//  大将军
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 SingYi. All rights reserved.
//

#import "HeadImageModel.h"

@interface HeadImageModel ()

@end

@implementation HeadImageModel
+ (NSArray *)getDogModels{
    NSArray *arrNames = @[@"贵宾(泰迪)", @"哈士奇", @"阿拉斯加", @"比熊", @"萨摩耶", @"金毛", @"边牧", @"拉布拉多", @"德牧(黑背)", @"八哥", @"博美", @"法国斗牛犬", @"英国斗牛犬", @"古牧", @"吉娃娃", @"柯基犬", @"柯利犬(苏牧)", @"喜乐蒂", @"小鹿犬", @"腊肠", @"北京犬", @"柴犬", @"秋田犬", @"迷你雪纳瑞", @"松狮犬", @"美国可卡犬", @"英国可卡犬", @"约克夏", @"罗威纳犬", @"西施犬", @"马尔济斯犬", @"中国沙皮犬", @"中华田园犬", @"西高地梗", @"比特", @"蝴蝶犬", @"斑点狗", @"冠毛犬", @"猎狐梗", @"苏格兰梗", @"高加索", @"卡斯罗", @"美国恶霸", @"惠比特", @"迷你杜宾", @"澳洲牧羊犬", @"波士顿梗", @"拳师犬", @"藏獒", @"伯恩山", @"比格犬", @"贝灵顿", @"巴吉度", @"大丹犬", @"杜高犬", @"凯利蓝根", @"牛头梗", @"日本狆", @"史宾格", @"苏联红", @"斯塔福", @"圣伯纳", @"万能梗", @"软毛麦色梗", @"巨型雪纳瑞", @"日本银狐", @"雪达犬", @"细犬", @"灵缇", @"大白熊", @"杜宾", @"阿富汗犬", @"罗索梗", @"其他犬种"];
    NSMutableArray *arrDogModels = [NSMutableArray array];
    for (NSInteger i = 0; i < arrNames.count; i ++) {
        HeadImageModel *model = [[HeadImageModel alloc] init];
        model.name = arrNames[i];
        NSString *cellImageName = [NSString stringWithFormat:@"dogs_name%ld.png", i + 1];
        NSString *iconImageName = [NSString stringWithFormat:@"dogs_name%lds.png", i + 1];
        model.cellImage = cellImageName;
        model.iconImage = iconImageName;
        [arrDogModels addObject:model];
    }
    return  arrDogModels;
}

@end
