//
//  GPUImageEnumData.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/7/19.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "GPUImageEnumData.h"
#import "GPUImageSDKVC.h"

@interface GPUImageEnumData ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerVC;

@property (nonatomic, strong) NSDictionary *color_keyValues;///颜色调整

@end

@implementation GPUImageEnumData

- (instancetype)init {
    if (self = [super init]) {
        self.color_keyValues = @{
            @"亮度": @"GPUImageBrightnessFilter",
            @"曝光": @"GPUImageExposureFilter",
            @"对比度": @"GPUImageContrastFilter",
            @"饱和度": @"GPUImageSaturationFilter",
            @"灰度系数": @"GPUImageGammaFilter",
            @"级别调整": @"GPUImageLevelsFilter",
            @"颜色矩阵": @"GPUImageColorMatrixFilter",
            @"颜色RGB": @"GPUImageRGBFilter",
            @"色调": @"GPUImageHueFilter",
            @"振动": @"GPUImageVibranceFilter",
            @"白平衡": @"GPUImageWhiteBalanceFilter",
            @"样条曲线": @"GPUImageToneCurveFilter",
            @"阴影和高光": @"GPUImageHighlightShadowFilter",
            @"强度独立阴影和高光": @"GPUImageHighlightShadowTintFilter",
            @"RGB映射": @"GPUImageLookupFilter",
            @"Amatorka动作滤镜": @"GPUImageAmatorkaFilter",
            @"MissEtikate动作滤镜": @"GPUImageMissEtikateFilter",
            @"Soft颜色重映射过滤": @"GPUImageSoftEleganceFilter",
            @"肤色调整滤镜": @"GPUImageSkinToneFilter",
            @"反转图像颜色": @"GPUImageColorInvertFilter",
            @"灰度": @"GPUImageGrayscaleFilter",
            @"单色": @"GPUImageMonochromeFilter",
            @"颜色混合": @"GPUImageFalseColorFilter",
            @"UV滤镜": @"GPUImageHazeFilter",
            @"棕褐色调滤波": @"GPUImageSepiaFilter",
            @"透明度": @"GPUImageOpacityFilter",
            @"纯色": @"GPUImageSolidColorGenerator",
            @"亮度阈值": @"GPUImageLuminanceThresholdFilter",
            @"局部亮度": @"GPUImageAdaptiveThresholdFilter",
            @"平均亮度": @"GPUImageAverageLuminanceThresholdFilter",
            @"直方图": @"GPUImageHistogramFilter",
            @"特殊过滤器": @"GPUImageHistogramGenerator",
            @"平均颜色": @"GPUImageChromaKeyFilter",
            @"给定颜色": @"GPUImageAverageColor",
        };
    }
    
    return self;
}

- (NSDictionary *)filterDataWithType: (GPUFilter)style {
    NSDictionary *keyValues = @{};
    switch (style) {
            case ColorFilterStyle:{
                keyValues = self.color_keyValues;
            }
            break;
            
        default:
            break;
    }
    
    return keyValues;
}

- (NSString *)colorFilterValueForKey:(NSString *)key {
    return [self.color_keyValues valueForKey:key];
}

#pragma mark 懒加载
- (UIImagePickerController *)imagePickerVC {
    if (!_imagePickerVC) {
        _imagePickerVC = [[UIImagePickerController alloc] init];
        // 设置资源来源（相册、相机、图库之一）
        //        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置可用的媒体类型、默认只包含kUTTypeImage，如果想选择视频，请添加kUTTypeMovie
        // 如果选择的是视屏，允许的视屏时长为20秒
        _imagePickerVC.videoMaximumDuration = 20;
        // 允许的视屏质量（如果质量选取的质量过高，会自动降低质量）
        _imagePickerVC.videoQuality = UIImagePickerControllerQualityTypeHigh;
        _imagePickerVC.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage];
        // 设置代理，遵守UINavigationControllerDelegate, UIImagePickerControllerDelegate 协议
        _imagePickerVC.delegate = self;
        _imagePickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
        // 是否允许编辑（YES：图片选择完成进入编辑模式）
        //        _imagePickerVC.allowsEditing = YES;
        
    }
    return _imagePickerVC;
}

- (void)presentSelectAction {
    [LZYPAlertController initActionSheetWithCancleAction:^{
        
    } presentVC:self.presentVC titleContents:@[@"相机", @"相册"] otherAction:^(NSUInteger index) {
        switch (index) {
            case 0:{
                //拍照
                self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
                // model出控制器
                [self.presentVC presentViewController:self.imagePickerVC animated:YES completion:nil];
            }
                break;
            case 1:{
                ////相册
                self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                // model出控制器
                [self.presentVC presentViewController:self.imagePickerVC animated:YES completion:nil];
            }
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.finishSelect) { self.finishSelect(image); }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
