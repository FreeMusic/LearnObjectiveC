//
//  GPUImageSDKVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/7/19.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "GPUImageSDKVC.h"
#import "GPUImageEnumData.h"
#import "GPUImageEditView.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AddressBook/AddressBook.h>
#import <CoreLocation/CoreLocation.h>
#import "TZImagePickerController.h"

const CGFloat editViewHeight = 300;

@interface GPUImageSDKVC ()

@property (nonatomic, strong) UIImageView *originImageView;///
@property (nonatomic, strong) GPUImageEnumData *enumData;///
@property (nonatomic, strong) GPUImageEditView *editView;///

@end

@implementation GPUImageSDKVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"选择照片" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(photoSelect) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.originImageView = [self createImageViewWithFrame:CGRectMake(0, NavigationBarHeight, kScreenWidth, 0)];
    
    self.enumData = [[GPUImageEnumData alloc] init];
    self.enumData.presentVC = self;
    MJWeakSelf
    [self.enumData setFinishSelect:^(UIImage * _Nonnull image) {
        CGFloat height = kScreenWidth * image.size.height / image.size.width;
        weakSelf.originImageView.image = image;
        weakSelf.originImageView.frame = CGRectMake(0, NavigationBarHeight, kScreenWidth, height);
    }];
    
    //
    UIButton *editButton = [UIButton ButtonWithTitle:@"美颜" ButtonBackColor:ButtonBlackTitleNormalBackColor CornerRadius:8 addSubView:self.view buttonActionBlock:^(UIButton * _Nullable button) {
//        [UIView animateWithDuration:0.3 animations:^{
//            self.editView.frame = CGRectMake(0, kScreenHeight-editViewHeight, kScreenWidth, editViewHeight);
//        }];
        if (self.originImageView.image) {
            UIImage *inputImage = self.originImageView.image;
        
            GPUImageBrightnessFilter *disFilter = [[GPUImageBrightnessFilter alloc] init];
            disFilter.brightness = 0.3;
            //设置要渲染的区域
            [disFilter forceProcessingAtSize:inputImage.size];
            [disFilter useNextFrameForImageCapture];
        
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
            //添加滤镜
            [stillImageSource addTarget:disFilter];
        
            //开始渲染
            [stillImageSource processImage];
        
            //获取渲染后的图片
            UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
        
            //加载
            self.originImageView.image = newImage;
            CGFloat height = kScreenWidth * newImage.size.height / newImage.size.width;
            self.originImageView.frame = CGRectMake(0, NavigationBarHeight, kScreenWidth, height);
        }
    }];
    editButton.frame = CGRectMake(30, kScreenHeight-50-KSafeBarHeight, kScreenWidth-60, 50);
    
}

- (GPUImageEditView *)editView {
    if (_editView == nil){
        _editView = [[GPUImageEditView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenHeight, editViewHeight)];
        [self.view addSubview:_editView];
    }
    
    return _editView;
}

- (UIImageView *)createImageViewWithFrame:(CGRect)frame {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    return imageView;
}

- (void)photoSelect {
//    [self.enumData presentSelectAction];
    TZImagePickerController *imagePickerVC =
    [[TZImagePickerController alloc]initWithMaxImagesCount:3 delegate:self];
//    imagePickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

@end
