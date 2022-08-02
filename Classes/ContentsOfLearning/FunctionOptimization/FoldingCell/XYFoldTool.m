//
//  XYFoldTool.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/8/1.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "XYFoldTool.h"
#import "FoldingModel.h"
#import "ElemCell.h"
#import "XYCollectionViewFlowLayout.h"

static XYFoldTool *_instace;

@interface XYFoldTool ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;///
@property (nonatomic, strong) NSArray *dataSource;///
@property (nonatomic, copy) FinishCaculateFlowLayoutAttributesBlock finishAttributes;///

@end

@implementation XYFoldTool

+ (instancetype)sharedInstance{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _instace = [[self alloc] init];
  });
  return _instace;
}

- (void)initCollectionView {
    [self.collectionView registerClass:[ElemCell class] forCellWithReuseIdentifier:@"XXXXXElemCell"];
    [[UIApplication sharedApplication].keyWindow addSubview:self.collectionView];
    self.collectionView.hidden = YES;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        XYCollectionViewFlowLayout *flowLayout = [[XYCollectionViewFlowLayout alloc] init];
        [flowLayout setFinishAttributes:^(NSArray *attributes) {
            if (self.finishAttributes) {
                [self handleArray:attributes];
            }
        }];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
        _collectionView.collectionViewLayout = flowLayout;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ElemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XXXXXElemCell" forIndexPath:indexPath];
    FoldingModel *model = self.dataSource[indexPath.row];
    [cell setLabelText:model.text];
    
    return cell;
}

/**
 设置item的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    FoldingModel *model = self.dataSource[indexPath.row];
    return CGSizeMake(model.width, 30);
}

/**
 设置item之间Y的间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return minimumLineSpacing;
}

/**
 设置item之间X的间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return minimumInteritem;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)handleArray: (NSArray *)attributes {
    NSMutableArray *data = [NSMutableArray array];
    CGFloat elemLastPoint = 0;
    NSMutableArray *handleArray = [NSMutableArray array];
    
    for (int i = 0; i < attributes.count; i++) {
        UICollectionViewLayoutAttributes *elem = attributes[i];
        CGFloat yPoint = elem.frame.origin.y;
        if (yPoint != elemLastPoint) {
            [data addObject:[handleArray copy]];
            [handleArray removeAllObjects];
        }
        [handleArray addObject:self.dataSource[i]];
        
        if (i == attributes.count - 1) {
            [data addObject:handleArray];
        }
        elemLastPoint = yPoint;
    }
    
    self.finishAttributes(data);
    _collectionView = nil;
}

- (void)calculateNumberOfRowsInTableViewWithSource:(NSArray *)dataList complitionBlock:(FinishCaculateFlowLayoutAttributesBlock)complitionBlock {
    self.dataSource = dataList;
    self.finishAttributes = complitionBlock;
}

@end
