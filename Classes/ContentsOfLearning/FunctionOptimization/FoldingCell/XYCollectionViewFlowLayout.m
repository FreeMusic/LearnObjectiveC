//
//  XYCollectionViewFlowLayout.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/8/1.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "XYCollectionViewFlowLayout.h"

@interface XYCollectionViewFlowLayout ()

{
    CGFloat collectionViewWidth;
}

@end

@implementation XYCollectionViewFlowLayout

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.maximumInteritemSpacing = 10;
    self.minimumInteritemSpacing = 10;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.maximumInteritemSpacing = 10;
        self.minimumInteritemSpacing = 10;
        self.minimumLineSpacing = 10;
    }
    return self;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //使用系统帮我们计算好的结果。
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    //第0个cell没有上一个cell，所以从1开始
    for(int i = 1; i < [attributes count]; ++i) {
        //这里 UICollectionViewLayoutAttributes 的排列总是按照 indexPath的顺序来的。
        UICollectionViewLayoutAttributes *curAttr = attributes[i];
        UICollectionViewLayoutAttributes *preAttr = attributes[i-1];
        
        NSInteger origin = CGRectGetMaxX(preAttr.frame);
        //根据  maximumInteritemSpacing 计算出的新的 x 位置
        CGFloat targetX = origin + _maximumInteritemSpacing;
        // 只有系统计算的间距大于  maximumInteritemSpacing 时才进行调整
        if (CGRectGetMinX(curAttr.frame) > targetX) {
            // 换行时不用调整
            if (targetX + CGRectGetWidth(curAttr.frame) < self.collectionView.lz_width) {
                CGRect frame = curAttr.frame;
                frame.origin.x = targetX;
                curAttr.frame = frame;
            }
        }
//        else{
//            CGRect frame = curAttr.frame;
//            frame.origin.x = 0;
//            curAttr.frame = frame;
//        }
    }
    self.attributes = attributes;
    if (self.finishAttributes) {
        self.finishAttributes(attributes);
    }
    
    return attributes;
}


@end
