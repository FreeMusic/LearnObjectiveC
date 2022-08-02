//
//  XYFoldTool.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/8/1.
//  Copyright © 2022 橘子. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYFoldTool : NSObject

+ (instancetype)sharedInstance;

- (void)initCollectionView;

- (void)calculateNumberOfRowsInTableViewWithSource:(NSArray *)dataList complitionBlock:(FinishCaculateFlowLayoutAttributesBlock)complitionBlock;

@end

NS_ASSUME_NONNULL_END
