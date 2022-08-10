//
//  XYCyclePlayView.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/8/10.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "XYCyclePlayView.h"
#import "XYCyclePlayCell.h"

static NSUInteger multiple = 99999;

@interface XYCyclePlayView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;///
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation XYCyclePlayView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = dataSource;
        _currentIndex = 0;
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[XYCyclePlayCell class] forCellWithReuseIdentifier:@"XYCyclePlayCell"];
        
        [self startTimer];
    }
    return self;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.collectionViewLayout = flowLayout;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count * multiple;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XYCyclePlayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XYCyclePlayCell" forIndexPath:indexPath];
    NSUInteger index = (indexPath.row % self.dataSource.count);
    [cell setImageUrl: [self.dataSource objectAtIndex:index]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.touchIndexRow) {
        NSUInteger index = (indexPath.row % self.dataSource.count);
        self.touchIndexRow(index);
    }
}

/**
 设置item的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.frame.size;
}

/**
 设置item之间Y的间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

/**
 设置item之间X的间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)startTimer {
    if (_dataSource.count == 0) {
        [[XYGCDTimer shareTimer] removeTimer];
    }else{
        [[XYGCDTimer shareTimer] startTimerWithTimeInterVal:3 circleBlock:^{
            CGFloat width = self.frame.size.width;
            NSInteger index = self->_currentIndex + 1;
            [self.collectionView setContentOffset:CGPointMake(index * width , 0) animated:YES];
            self->_currentIndex = index;
        }];
    }
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.collectionView reloadData];
}

- (void)dealloc {
    [[XYGCDTimer shareTimer] removeTimer];
}

@end
