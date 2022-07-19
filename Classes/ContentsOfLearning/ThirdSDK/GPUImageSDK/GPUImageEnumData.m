//
//  GPUImageEnumData.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/7/19.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "GPUImageEnumData.h"

@interface GPUImageEnumData ()

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

@end
