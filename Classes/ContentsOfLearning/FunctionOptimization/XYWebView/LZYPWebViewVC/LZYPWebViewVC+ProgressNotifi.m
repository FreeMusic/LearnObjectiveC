//
//  LZYPWebViewVC+ProgressNotifi.m
//  LZYP
//
//  Created by sxy on 2019/11/9.
//  Copyright © 2019 LZYP-iOS-Andrew. All rights reserved.
//

#import "LZYPWebViewVC+ProgressNotifi.h"


@implementation LZYPWebViewVC (ProgressNotifi)



#pragma mark - 监听加载进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    MJWeakSelf;
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == self.webView) {
            [weakSelf.progressView setAlpha:1.0f];
            [weakSelf.progressView setProgress:weakSelf.webView.estimatedProgress animated:YES];
            if(weakSelf.webView.estimatedProgress >= 1.0f) {
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [weakSelf.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [weakSelf.progressView setProgress:0.0f animated:NO];
                }];
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }  else if ([keyPath isEqualToString:@"title"]) {
        if (object == weakSelf.webView) {
            weakSelf.titleLabel.text = weakSelf.webView.title;
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
