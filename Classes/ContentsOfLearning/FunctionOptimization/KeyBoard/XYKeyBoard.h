//
//  XYKeyBoard.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/7/25.
//  Copyright © 2022 橘子. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^InputChangeBlock) (NSString * _Nonnull text);

NS_ASSUME_NONNULL_BEGIN

@interface XYKeyBoard : UIView

@property (nonatomic, copy) InputChangeBlock inputChangeAction;///

@property (nonatomic, assign) int maxNum;///

- (void)showKeyBoard;

- (void)hideKeyBoard;

@end

NS_ASSUME_NONNULL_END
