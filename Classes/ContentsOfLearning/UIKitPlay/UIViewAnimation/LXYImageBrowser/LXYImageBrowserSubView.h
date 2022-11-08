//
//  LXYImageBrowserSubView.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/11/4.
//  Copyright © 2022 橘子. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXYImageBrowserModel;

@protocol LXYImageBrowserSubViewDelegate <NSObject>

/* 单击 后的操作 */
- (void)imageBrowserSubViewSingleTapWithModel:(LXYImageBrowserModel *_Nonnull)imageBrowserModel;
/* 改变主视图 的 透明度 */
- (void)imageBrowserSubViewTouchMoveChangeMainViewAlpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_BEGIN

@interface LXYImageBrowserSubView : UIView

@property(nonatomic, weak) id<LXYImageBrowserSubViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame ImageBrowserModel:(LXYImageBrowserModel *)imageBrowserModel;

@end

NS_ASSUME_NONNULL_END
