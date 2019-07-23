//
//  FigureOutLayoutVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/7/11.
//  Copyright © 2019 橘子. All rights reserved.
//

#import "FigureOutLayoutVC.h"
#import "LayOutCell.h"

@interface FigureOutLayoutVC ()

@end

@implementation FigureOutLayoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, 400*m6Scale);
    self.collectionView.center = self.view.center;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[LayOutCell class] forCellWithReuseIdentifier:@"LayOutCell"];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LayOutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LayOutCell" forIndexPath:indexPath];
    [cell zoomCardView];
    
    return cell;
}

/**
 设置item的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenWidth, 400*m6Scale);
}

@end
