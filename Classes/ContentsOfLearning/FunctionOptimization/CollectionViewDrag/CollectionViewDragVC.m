//
//  CollectionViewDragVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/10/21.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "CollectionViewDragVC.h"
#import "DragColloectionViewCell.h"

@interface CollectionViewDragVC ()

@property (nonatomic, strong) NSMutableArray *dataSource;///

@end

@implementation CollectionViewDragVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[DragColloectionViewCell class] forCellWithReuseIdentifier:@"DragColloectionViewCell"];
    
    // 添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
    [self.collectionView addGestureRecognizer:longPress];
    self.dataSource = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index < 100; index ++) {
        [self.dataSource addObjectVerify:[NSString stringWithFormat:@"第%ld个", index]];
    }
    [self.collectionView reloadData];
}

- (void)handlelongGesture: (UILongPressGestureRecognizer *)longPress {
    switch (longPress.state) {
            //手势开始长按
        case UIGestureRecognizerStateBegan: {
            //判断手势的落点是否在Cell上
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longPress locationInView:self.collectionView]];
            if (indexPath == nil) {break;}
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
            [self.view bringSubviewToFront:cell];
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
            
        case UIGestureRecognizerStateChanged: {
            [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:self.collectionView]];
        }
            break;
        case UIGestureRecognizerStateEnded: {
            [self.collectionView endInteractiveMovement];
        }
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
 
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DragColloectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DragColloectionViewCell" forIndexPath:indexPath];
    cell.title = [self.dataSource objectAtIndexVerify:indexPath.row];
    
    return cell;
}

/**
 设置item的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenWidth - 40)/4, (kScreenWidth - 40)/4);
}

/**
 设置item之间Y的间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return (self.dataSource.count > 1);
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *moveTitle = [self.dataSource objectAtIndexVerify:sourceIndexPath.row];
    [self.dataSource removeObject:moveTitle];
    if (destinationIndexPath.row == self.dataSource.count) {
        [self.dataSource addObjectVerify:moveTitle];
    }else{
        [self.dataSource insertObjectVerify:moveTitle atIndex:destinationIndexPath.row];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    XYLog(@"didSelectItemAtIndexPath%ld", indexPath.row);
}


@end
