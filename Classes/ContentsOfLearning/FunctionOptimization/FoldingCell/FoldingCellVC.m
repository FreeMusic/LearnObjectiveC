//
//  FoldingCellVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/7/25.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "FoldingCellVC.h"
#import "ElemCell.h"
#import "FoldingModel.h"

@interface FoldingCellVC ()

@property (nonatomic, strong) NSMutableArray *titleArray;///

@end

@implementation FoldingCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[
        @"历史1", @"历史2", @"历史3",@"历史4",@"历史5",@"历史6",@"历史7",@"历史8",@"历史9",@"历史10",@"历史11",@"历史12",
        @"历史13",@"历史14",@"历史15",@"历史16",@"历史17",
    ];
    _titleArray = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FoldingModel *model = [[FoldingModel alloc] initWithText:obj];
        [self.titleArray addObject:model];
    }];
    
    [self.collectionView registerClass:[ElemCell class] forCellWithReuseIdentifier:@"ElemCell"];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ElemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ElemCell" forIndexPath:indexPath];
    FoldingModel *model = self.titleArray[indexPath.row];
    [cell setLabelText:model.text];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    RYQLog(@"%ld", indexPath.row);
}

/**
 设置item的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    FoldingModel *model = self.titleArray[indexPath.row];
    return CGSizeMake(model.width, 30);
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
    return 5;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 70, 0, 70);
}


@end
