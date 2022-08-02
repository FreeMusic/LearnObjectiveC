//
//  XYFoldCell.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/8/1.
//  Copyright © 2022 橘子. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TouchIndexRowBlock)(NSUInteger index);

NS_ASSUME_NONNULL_BEGIN

@interface XYFoldCell : UITableViewCell

@property (nonatomic, strong) NSArray *dataSource;///
///
@property (nonatomic, copy) TouchIndexRowBlock touchIndexRow;///

@end

NS_ASSUME_NONNULL_END
