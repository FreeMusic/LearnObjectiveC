//
//  XYCollectionViewFlowLayout.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/8/1.
//  Copyright © 2022 橘子. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface XYCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic) CGFloat maximumInteritemSpacing;

@property (nonatomic, strong) NSArray *attributes;///

@property (nonatomic, copy) FinishCaculateFlowLayoutAttributesBlock finishAttributes;///

@end

NS_ASSUME_NONNULL_END
