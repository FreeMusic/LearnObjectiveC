//
//  UICollectionViewAnimationVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/11/8.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "UICollectionViewAnimationVC.h"
#import "AnimationCell.h"

@interface UICollectionViewAnimationVC ()

@end

@implementation UICollectionViewAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.collectionView registerClass:[AnimationCell class] forCellWithReuseIdentifier:@"AnimationCell"];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}

/**
 设置item的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (kScreenWidth - 50) / 3;
    return CGSizeMake(width, width);
}
/**
 设置item之间Y的间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
/**
 设置item之间X的间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}


@end
