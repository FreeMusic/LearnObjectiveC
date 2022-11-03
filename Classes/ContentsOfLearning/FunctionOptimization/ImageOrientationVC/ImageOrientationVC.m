//
//  ImageOrientationVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/11/2.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "ImageOrientationVC.h"

@interface ImageOrientationVC ()

@property (nonatomic, strong) UIScrollView *scrollView;///
@property (nonatomic, strong) UIImageView *originalImageView;///
@property (nonatomic, strong) UIImageView *roateImageView;///
@property (nonatomic, assign) NSUInteger tapRoateNum;
@property (nonatomic, strong) UIButton *saveButton;///

@end

@implementation ImageOrientationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.scrollView];
    NSString *url = @"http://photo.tanwin.cn/tempfile/2022-10-31/85568d2f2412c6e6623dc65e2036f4b2.jpg";
    self.tapRoateNum = 0;
    
    self.originalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2)];
    self.originalImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.originalImageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        CGFloat height = self.originalImageView.image.size.height;
        CGFloat width = self.originalImageView.image.size.width;
        self.originalImageView.frame = CGRectMake(0, 0, kScreenWidth, (kScreenWidth*height)/width);
    }];
    [self.scrollView addSubview:self.originalImageView];
        
    UIButton *roateButton = [UIButton ButtonWithTitle:@"顺时针旋转90度" ButtonBackColor:ButtonYellowColor CornerRadius:4 addSubView:self.scrollView buttonActionBlock:^(UIButton * _Nullable button) {
        ++self.tapRoateNum;
        [UIView animateWithDuration:0.5 animations:^{
            self.originalImageView.transform = CGAffineTransformRotate(self.originalImageView.transform, M_PI_2);
        }];
    }];
    [roateButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(200);
        make.height.equalTo(50);
        make.centerX.equalTo(self.scrollView.centerX);
        make.top.equalTo(self.originalImageView.bottom).offset(10);
    }];
    
    self.saveButton = [UIButton ButtonWithTitle:@"保存旋转图" ButtonBackColor:ButtonYellowColor CornerRadius:4 addSubView:self.scrollView buttonActionBlock:^(UIButton * _Nullable button) {
        [self replayImage];
    }];
    [self.saveButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(200);
        make.height.equalTo(50);
        make.centerX.equalTo(self.scrollView.centerX);
        make.top.equalTo(roateButton.bottom).offset(10);
    }];
    
    self.roateImageView = [[UIImageView alloc] init];
    self.roateImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:self.roateImageView];
    [self.roateImageView remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(kScreenHeight);
        make.left.equalTo(0);
        make.top.equalTo(self.saveButton.bottom).offset(10);
    }];
    
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight*3);
}

- (void)replayImage {
    
    CGFloat height = self.originalImageView.image.size.height;
    CGFloat width = self.originalImageView.image.size.width;
    UIImage *image = self.originalImageView.image;
    UIImage *changeImage = nil;
    switch (self.tapRoateNum % 4) {
        case 0:
        {
            changeImage = image;
        }
            break;
        case 1:
        {
            changeImage = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationRight];
        }
            break;
        case 2:
        {
            changeImage = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationDown];
        }
            break;
        case 3:
        {
            changeImage = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationLeft];
        }
            break;
            
        default:
        {
            changeImage = image;
        }
            break;
    }
    self.roateImageView.frame = CGRectMake(0, 0, kScreenWidth, (kScreenWidth*height)/width);
    self.roateImageView.image = changeImage;
}

@end
