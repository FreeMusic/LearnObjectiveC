//
//  MyCollectionViewVC.h
//  LearnObjectiveC
//
//  Created by Apple on 2019/7/23.
//  Copyright © 2019 橘子. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyCollectionViewVC : BaseViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
