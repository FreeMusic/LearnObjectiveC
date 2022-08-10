//
//  XYCyclePlayCell.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/8/10.
//  Copyright © 2022 橘子. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TouchIndexRowBlock)(NSUInteger index);

NS_ASSUME_NONNULL_BEGIN

@interface XYCyclePlayCell : UICollectionViewCell

@property (nonatomic, strong) NSString *imageUrl;///

@end

NS_ASSUME_NONNULL_END
