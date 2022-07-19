//
//  GPUImageSDKVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/7/19.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "GPUImageSDKVC.h"

@interface GPUImageSDKVC ()

@end

@implementation GPUImageSDKVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImage *inputImage = [UIImage imageNamed:@"ShaeotView"];
//
//    GPUImageBrightnessFilter *disFilter = [[GPUImageBrightnessFilter alloc] init];
//
//    //设置要渲染的区域
//    [disFilter forceProcessingAtSize:inputImage.size];
//    [disFilter useNextFrameForImageCapture];
//
//    //获取数据源
//    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
//    //添加滤镜
//    [stillImageSource addTarget:disFilter];
//
//    //开始渲染
//    [stillImageSource processImage];
//
//    //获取渲染后的图片
//    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
//
//    //加载
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:newImage];
//    imageView.frame = self.view.frame;
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:imageView];
}



@end
