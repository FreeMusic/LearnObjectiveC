//
//  UITableViewCell+Extention.h
//  LearnObjectiveC
//
//  Created by Apple on 2019/7/11.
//  Copyright © 2019 橘子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (Extention)

@property (nonatomic, assign) CGFloat cellHeight;

+ (id)cellReuseWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
