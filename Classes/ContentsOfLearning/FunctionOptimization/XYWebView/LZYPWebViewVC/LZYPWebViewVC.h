//
//  LZYPWebViewVC.h
//  LZYP
//
//  Created by sxy on 2019/10/25.
//  Copyright © 2019 LZYP-iOS-Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
//webView的加载类型
typedef NS_ENUM(NSUInteger, LZYPWebViewContentType) {
    LZYPWebViewURLContentType,//加载URL形式
    LZYPWebViewPLabelContentType,//加载P标签的形式
};

NS_ASSUME_NONNULL_BEGIN

@interface LZYPWebViewVC : UIViewController

/** 相关链接*/
@property (nonatomic, copy) NSString *content;

/** 标题 */
@property (nonatomic, strong) UIColor *webTitleColor;

@property (nonatomic, strong) UIColor *naviBackGroundColor;//导航栏的颜色
@property (nonatomic, strong) UILabel *titleLabel;//网页头部标签
/** 进度条颜色 */
@property (nonatomic, assign) UIColor *progressColor;

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIView *naviView;//
@property (nonatomic, strong) UIProgressView *progressView;//webView的进度条
@property (nonatomic, copy) NSString *webTitle;///网页标题

@property (nonatomic, assign) LZYPWebViewContentType contentType;

- (instancetype)initWithContent:(NSString *)content contentType:(LZYPWebViewContentType)contentType navBgColor:(UIColor *)navColor titleColor:(UIColor *)titleColor;

- (instancetype)initWithURL:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
