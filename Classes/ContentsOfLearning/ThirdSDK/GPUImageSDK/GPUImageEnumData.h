//
//  GPUImageEnumData.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/7/19.
//  Copyright © 2022 橘子. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ColorFilterStyle,
} GPUFilter;

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageEnumData : NSObject

- (NSDictionary *)filterDataWithType: (GPUFilter)style;

- (NSString *)colorFilterValueForKey:(NSString *)key;

@end

/**
 一、颜色调整

 GPUImageBrightnessFilter：调整图像的亮度

 brightness(亮度)：调整后的亮度（-1.0 - 1.0，默认值为0.0）

 GPUImageExposureFilter：调整图像的曝光

 exposure(曝光)：调整曝光（-10.0 - 10.0，默认值为0.0）

 GPUImageContrastFilter：调整图像的对比度

 contrast(对比度)：调整后的对比度（0.0 - 4.0，默认值为1.0）

 GPUImageSaturationFilter：调整图像的饱和度

 saturation(饱和度)：应用于图像的饱和度或去饱和度（0.0 - 2.0，默认值为1.0）

 GPUImageGammaFilter：调整图像的灰度系数

 gamma：要应用的伽玛调整（0.0 - 3.0，默认值为1.0）

 GPUImageLevelsFilter：类似Photoshop的级别调整。min，max，minOut和maxOut参数是[0,1]范围内的浮点数。

 如果Photoshop中的参数在[0,255]范围内，则必须先将它们转换为[0,1]。gamma / mid参数是float> = 0，这与Photoshop中的值匹配。
 如果要应用于RGB以及各个通道，则需要使用此滤波器两次：首先是单个通道，然后是所有通道。

 GPUImageColorMatrixFilter：通过对图像应用矩阵来变换图像的颜色

 colorMatrix：用于转换图像中每种颜色的4x4矩阵
 intensity(强度)：新变换颜色替换每个像素的原始颜色的程度

 GPUImageRGBFilter：调整图像的各个RGB通道

 red、green、blue：每个颜色通道乘以的标准化值。范围从0.0开始，默认值为1.0。

 GPUImageHueFilter：调整图像的色调

 hue(色调)：色调角度，以度为单位。默认为90度

 GPUImageVibranceFilter：调整图像的振动

 vibrance：要应用的振动调整，使用0.0作为默认值，建议的最小值/最大值分别为-1.2和1.2左右。

 GPUImageWhiteBalanceFilter：调整图像的白平衡。

 temperature(温度)：以ºK为单位调整图像的温度，默认值为5000。请注意，4000到5000之间的比例几乎与5000和7000之间的比例一样重要。
 tint(色调)：调整图像的色调，[-200 ,200]，默认值为0。

 GPUImageToneCurveFilter：根据每个颜色通道的样条曲线调整图像的颜色。

 redControlPoints、greenControlPoints、blueControlPoints
 rgbCompositeControlPoints：色调曲线采用一系列控制点，这些控制点定义每个颜色分量的样条曲线，或复合材料中的所有三个颜色分量。它们作为NSValue包装的CGPoints存储在NSArray中，标准化的X和Y坐标为0-1，默认值为(0,0)、(0.5,0.5)、(1,1)。

 GPUImageHighlightShadowFilter：调整图像的阴影和高光

 shadows(阴影)：增加以减轻阴影，从0.0到1.0，默认值为0.0。
 highlights(高光)：减少高亮变暗，从1.0到0.0，默认为1.0。

 GPUImageHighlightShadowTintFilter：允许您使用颜色和强度独立地着色图像的阴影和高光。

 shadowTintColor：阴影色调RGB颜色（GPUVector4）。默认值:( {1.0f, 0.0f, 0.0f, 1.0f}红色）。
 highlightTintColor：突出显示色调RGB颜色（GPUVector4）。默认值:( {0.0f, 0.0f, 1.0f, 1.0f}蓝色）。
 shadowTintIntensity：阴影色调强度，从0.0到1.0。默认值：0.0
 highlightTintIntensity：突出显示色调强度，从0.0到1.0，默认值为0.0。

 GPUImageLookupFilter：使用RGB颜色查找图像重新映射图像中的颜色。

 首先，使用最喜欢的照片编辑应用程序将过滤器应用于GPUImage / framework / Resources中的lookup.png。为了使其正常工作，每个像素颜色必须不依赖于其他像素（例如，模糊将不起作用）。如果需要更复杂的过滤器，可以根据需要创建任意数量的查找表。准备好后，使用新的lookup.png文件作为GPUImageLookupFilter的第二个输入。

 GPUImageAmatorkaFilter：基于Amatorka的Photoshop动作的照片滤镜

 如果要使用此效果，则必须将GPUImage资源文件夹中的lookup_amatorka.png添加到应用程序包中。

 GPUImageMissEtikateFilter：基于Miss Etikate的Photoshop动作的照片滤镜：

 如果要使用此效果，则必须将GPUImage资源文件夹中的lookup_miss_etikate.png添加到应用程序包中。

 GPUImageSoftEleganceFilter：另一种基于查找的颜色重映射过滤器。

 如果要使用此效果，则必须将GPUImage资源文件夹中的lookup_soft_elegance_1.png和lookup_soft_elegance_2.png添加到应用程序包中。

 GPUImageSkinToneFilter：肤色调整滤镜，可影响独特的浅色肤色，并相应调整粉色/绿色或粉色/橙色范围。默认值以白种人皮肤为目标，但可根据需要进行调整。

 skinToneAdjust：调整肤色的量。默认值：0.0，建议最小值/最大值：-0.3和0.3。
 skinHue：检测皮肤色调。默认值：0.05（白种人皮肤偏红皮肤）。
 skinHueThreshold：皮肤色调的变化量，默认值：40.0。
 maxHueShift：允许的最大色调偏移量，默认值：0.25。
 maxSaturationShift =要移动的最大饱和度（使用橙色时），默认值：0.4。
 upperSkinToneColor = GPUImageSkinToneUpperColorGreen或 GPUImageSkinToneUpperColorOrange

 GPUImageColorInvertFilter：反转图像的颜色

 GPUImageGrayscaleFilter：将图像转换为灰度（饱和度滤镜的执行速度略快，无法改变颜色的贡献）

 GPUImageMonochromeFilter：根据每个像素的亮度将图像转换为单色版本

 intensity(强度)：特定颜色替换正常图像颜色的程度（0.0 - 1.0，默认值为1.0）
 color：用作效果基础的颜色，默认值为（0.6,0.45,0.3,1.0）。

 GPUImageFalseColorFilter：使用图像的亮度在两个用户指定的颜色之间混合

 firstColor：、secondColor： 第一种和第二种颜色分别指定哪些颜色代替图像的暗区和亮区。默认值为（0.0,0.0,0.5）amd（1.0,0.0,0.0）。

 GPUImageHazeFilter：用于添加或删除雾霾（类似于UV滤镜）

 distance(距离)：应用的颜色强度，默认值为0.-和.3之间的值最好。
 slope(斜率)：颜色变化量，默认值为0.-和.3之间的值最好。

 GPUImageSepiaFilter：简单的棕褐色调滤波器

 intensity(强度)：棕褐色调替换正常图像颜色的程度（0.0 - 1.0，默认值为1.0）

 GPUImageOpacityFilter：调整传入图像的Alpha通道

 opacity(不透明度)：将每个像素的传入Alpha通道乘以（0.0 - 1.0，默认值为1.0）的值

 GPUImageSolidColorGenerator：输出生成的纯色图像。您需要使用-forceProcessingAtSize定义图像大小：

 color：用于填充图像的四分量格式的颜色。

 GPUImageLuminanceThresholdFilter：亮度高于阈值的像素将显示为白色，下面的像素将显示为黑色

 threshold(阈值)：亮度threshold，从0.0到1.0，默认值为0.5

 GPUImageAdaptiveThresholdFilter：确定像素周围的局部亮度，如果低于该局部亮度则将像素变为黑色，如果高于该值则变为白色。这对于在不同光照条件下挑选文本非常有用。

 blurRadiusInPixels：背景平均模糊半径的乘数，以像素为单位，默认值为4。

 GPUImageAverageLuminanceThresholdFilter：这应用阈值操作，其中阈值根据场景的平均亮度连续调整。

 thresholdMultiplier：这是平均亮度乘以的一个因子，以达到要使用的最终threshold。默认情况下，这是1.0。

 GPUImageHistogramFilter：分析输入图像并创建输出直方图

 其中包含每个颜色值出现的频率。该滤波器的输出是3像素高，256像素宽的图像，其中心（垂直）像素包含与发生各种颜色值的频率相对应的像素。每个颜色值占据256个宽度位置中的一个，从左侧的0到右侧的255。可以为各个颜色通道（kGPUImageHistogramRed，kGPUImageHistogramGreen，kGPUImageHistogramBlue），图像的亮度（kGPUImageHistogramLuminance）或一次所有三个颜色通道（kGPUImageHistogramRGB）生成此直方图。
 downsamplingFactor：不是对每个像素进行采样，而是指示采样的图像的哪个部分。默认情况下，这是16，最小值为1.这是为了防止直方图饱和，直方图只能在每个颜色值过载之前记录256个像素。

 GPUImageHistogramGenerator：这是一个特殊的过滤器，因为它主要用于处理GPUImageHistogramFilter。

 它生成由GPUImageHistogramFilter生成的颜色直方图的输出表示，但它可以重新用于显示其他类型的值。它接收图像并查看中心（垂直）像素。然后，它在输出纹理中的单独彩色图形中绘制RGB分量的数值。您可能需要强制此过滤器的大小才能使其输出可见。

 GPUImageAverageColor：处理输入图像并通过平均图像中每个像素的RGBA分量来确定场景的平均颜色。缩减过程用于逐步下采样GPU上的源图像，然后在CPU上进行短平均计算。此过滤器的输出没有意义，但您需要将colorAverageProcessingFinishedBlock属性设置为一个块，该块接受四个颜色分量和一个帧时间并对它们执行某些操作。

 GPUImageLuminosity：与GPUImageAverageColor类似，这会将图像缩小到平均亮度。您需要设置luminosityProcessingFinishedBlock来处理此过滤器的输出，该输出仅返回亮度值和帧时间。

 GPUImageChromaKeyFilter：对于图像中的给定颜色，将alpha通道设置为0.这类似于GPUImageChromaKeyBlendFilter，而不是在第二个图像中混合匹配的颜色，这不会占用第二个图像而只是转动一个给定的颜色颜色透明。

 thresholdSensitivity：要替换的目标颜色需要与颜色匹配的接近程度（默认值为0.4）；
 smoothing(平滑)：混合颜色匹配的平滑程度（默认值为0.1）；

 二、图像处理

 图像调整滤镜，包含锐化，2D、3D变换，裁剪，检测，模糊等

 GPUImageTransformFilter：对图像应用任意2-D或3-D变换

 affineTransform：需要一个CGAffineTransform来调整二维图像
 transform3D：需要一个CATransform3D来操纵三维图像
 ignoreAspectRatio：默认情况下，保留变换图像的宽高比，但可以将其设置为YES以使变换独立于宽高比

 GPUImageCropFilter：将图像裁剪到特定区域，然后仅将该区域传递到滤镜中的下一个舞台

 cropRegion：从图像中裁剪出来的矩形区域，标准化为0.0 - 1.0的坐标。（0.0,0.0）位置位于图像的左上角。

 GPUImageLanczosResamplingFilter：可以使用Lanczos重采样对图像进行上采样或下采样，从而比标准线性或三线性插值产生明显更好的质量。只需使用forceProcessingAtSize：设置过滤器的目标输出分辨率，然后对该新大小重新采样图像。

 GPUImageSharpenFilter：锐化图像

 sharpness(锐度)：应用的锐度调整（-4.0 - 4.0，默认值为0.0）

 GPUImageUnsharpMaskFilter：应用非锐化蒙版

 blurRadiusInPixels：基础高斯模糊的模糊半径，默认值为4.0
 intensity(强度)：锐化的强度，从0.0开始，默认值为1.0

 GPUImageGaussianBlurFilter：硬件优化的可变半径高斯模糊

 texelSpacingMultiplier：纹素之间间距的乘数，范围从0.0开始，默认值为1.0。调整此项可能会略微增加模糊强度，但会在结果中引入伪影。强烈建议首先使用其他参数，然后再触摸此参数。
 blurRadiusInPixels：用于模糊的半径（以像素为单位），默认值为2.0。这会调整高斯分布函数中的sigma变量。
 blurRadiusAsFractionOfImageWidth和blurRadiusAsFractionOfImageHeight：设置这些属性将允许模糊半径随图像的大小缩放
 blurPasses：顺序模糊传入图像的次数。通过越多，过滤器越慢。

 GPUImageBoxBlurFilter：硬件优化的可变半径框模糊

 texelSpacingMultiplier：纹素之间间距的乘数，范围从0.0开始，默认值为1.0。调整此项可能会略微增加模糊强度，但会在结果中引入伪影。强烈建议首先使用其他参数，然后再触摸此参数。
 blurRadiusInPixels：用于模糊的半径（以像素为单位），默认值为2.0。这会调整高斯分布函数中的sigma变量。
 blurRadiusAsFractionOfImageWidth：
 blurRadiusAsFractionOfImageHeight：设置这些属性将允许模糊半径随图像的大小缩放
 blurPasses：顺序模糊传入图像的次数。通过越多，过滤器越慢。

 GPUImageSingleComponentGaussianBlurFilter：GPUImageGaussianBlurFilter的修改，仅对红色组件进行操作

 texelSpacingMultiplier：纹素之间间距的乘数，范围从0.0开始，默认值为1.0。调整此项可能会略微增加模糊强度，但会在结果中引入伪影。强烈建议首先使用其他参数，然后再触摸此参数。
 blurRadiusInPixels：用于模糊的半径（以像素为单位），默认值为2.0。这会调整高斯分布函数中的sigma变量。
 blurRadiusAsFractionOfImageWidth和blurRadiusAsFractionOfImageHeight：设置这些属性将允许模糊半径随图像的大小缩放
 blurPasses：顺序模糊传入图像的次数。通过越多，过滤器越慢。

 GPUImageGaussianSelectiveBlurFilter：保持焦点在圆形区域内的高斯模糊

 blurRadiusInPixels：用于模糊的半径（以像素为单位），默认值为5.0。这会调整高斯分布函数中的sigma变量。
 excludeCircleRadius：从模糊中排除的圆形区域的半径
 excludeCirclePoint：从模糊中排除圆形区域的中心
 excludeBlurSize：模糊部分和清晰圆之间区域的大小
 aspectRatio：图像的宽高比，用于调整对焦区域的圆度。默认情况下，这与图像宽高比匹配，但您可以覆盖此值。

 GPUImageGaussianBlurPositionFilter：GPUImageGaussianSelectiveBlurFilter的反转，仅在某个圆圈内应用模糊

 blurSize：模糊大小的乘数，范围从0.0开始，默认值为1.0
 blurCenter：模糊的中心，默认为0.5,0.5
 blurRadius：模糊的半径，默认为1.0

 GPUImageiOSBlurFilter：尝试在控制中心等位置复制iOS 7上使用的背景模糊。

 blurRadiusInPixels：用于模糊的半径（以像素为单位），默认值为12.0，调整高斯分布函数中的sigma变量。
 saturation(饱和度)：饱和度范围从0.0（完全去饱和）到2.0（最大饱和度），0.8为正常水平
 downsampling(下采样)：下采样的程度，然后对输入图像进行上采样以最小化高斯模糊内的计算，默认值为4.0。

 GPUImageMedianFilter：在3x3区域内获取三种颜色分量的中值

 GPUImageBilateralFilter：双边模糊，试图模糊相似的颜色值，同时保留锐边

 texelSpacingMultiplier：纹素读取之间间距的乘数，范围从0.0开始，默认值为4.0
 distanceNormalizationFactor：中心颜色与样本颜色之间距离的归一化因子，默认值为8.0。

 GPUImageTiltShiftFilter：模拟倾斜移位镜头效果

 blurRadiusInPixels：基础模糊的半径，以像素为单位，默认情况下为7.0。
 topFocusLevel：图像中对焦区域顶部的标准化位置，此值应低于bottomFocusLevel，默认值为0.4
 bottomFocusLevel：图像中对焦区域底部的标准化位置，此值应高于topFocusLevel，默认值为0.6
 focusFallOffRate：图像模糊远离对焦区域的速率，默认为0.2

 GPUImage3x3ConvolutionFilter：针对图像运行3x3卷积内核

 convolutionKernel：卷积核是一个3x3的值矩阵，用于应用于像素及其周围8个像素。矩阵以行主顺序指定，左上角像素为一个，右下角为三个。三个。如果矩阵中的值不等于1.0，则图像可能会变亮或变暗。

 GPUImageSobelEdgeDetectionFilter：Sobel边缘检测，边缘以白色突出显示

 texelWidth和texelHeight：这些参数会影响检测到的边缘的可见性
 edgeStrength：调整过滤器的动态范围。较高的值会导致较强的边缘，但会使强度色彩空间饱和，默认值为1.0。

 GPUImagePrewittEdgeDetectionFilter：Prewitt边缘检测，边缘以白色突出显示

 texelWidth和texelHeight：这些参数会影响检测到的边缘的可见性
 edgeStrength：调整过滤器的动态范围。较高的值会导致较强的边缘，但会使强度色彩空间饱和。默认值为1.0。

 GPUImageThresholdEdgeDetectionFilter：执行Sobel边缘检测，但应用阈值而不是给出渐进的强度值

 texelWidth和texelHeight：这些参数会影响检测到的边缘的可见性
 edgeStrength：调整过滤器的动态范围，较高的值会导致较强的边缘，但会使强度色彩空间饱和，默认值为1.0。
 threshold：高于此threshold的任何边缘将为黑色，并且任何低于白色的边缘。范围从0.0到1.0，默认值为0.8。

 GPUImageCannyEdgeDetectionFilter：这使用完整的Canny过程突出显示一个像素宽的边缘

 texelWidth和texelHeight：这些参数会影响检测到的边缘的可见性
 blurRadiusInPixels：高斯模糊的基础模糊半径。默认值为2.0。
 blurTexelSpacingMultiplier：底层模糊纹理间距乘数。默认值为1.0。
 upperThreshold：梯度大小超过此阈值的任何边将通过并显示在最终结果中，默认值为0.4。
 lowerThreshold：梯度幅度低于此阈值的任何边缘都将失败并从最终结果中移除，默认值为0.1。

 GPUImageHarrisCornerDetectionFilter：在输入图像上运行Harris角点检测算法，并生成一个图像，其中这些角点为白色像素，其他一切都为黑色。可以设置cornersDetectedBlock，并为您提供一个角落列表（在规范化的0…1 X，Y坐标中），用于您要执行的任何其他操作。

 blurRadiusInPixels：基础高斯模糊的半径。默认值为2.0。
 sensitivity(灵敏度)：应用于调整滤波器中生成的角度图的动态范围的内部比例因子。默认值为5.0。
 threshold(阈值)：将点检测为拐角的threshold。这可能会根据尺寸，照明条件和iOS设备相机类型而有很大差异，因此可能需要一些实验才能适合您的情况。默认值为0.20。

 GPUImageNobleCornerDetectionFilter：在Harris角点检测器上运行Noble变量。其行为如上所述用于Harris检测器。

 blurRadiusInPixels：基础高斯模糊的半径。默认值为2.0。
 sensitivity(灵敏度)：应用于调整滤波器中生成的角度图的动态范围的内部比例因子。默认值为5.0。
 threshold(阈值)：将点检测为拐角的threshold。这可能会根据尺寸，照明条件和iOS设备相机类型而有很大差异，因此可能需要一些实验才能适合您的情况。默认值为0.2。

 GPUImageShiTomasiCornerDetectionFilter：运行Shi-Tomasi特征检测器。其行为如上所述用于Harris检测器。

 blurRadiusInPixels：基础高斯模糊的半径。默认值为2.0。
 sensitivity(灵敏度)：应用于调整滤波器中生成的角度图的动态范围的内部比例因子。默认值为1.5。
 threshold(阈值)：将点检测为拐角的threshold。这可能会根据尺寸，照明条件和iOS设备相机类型而有很大差异，因此可能需要一些实验才能适合您的情况。默认值为0.2。

 GPUImageNonMaximumSuppressionFilter：目前仅用作Harris角点检测滤波器的一部分，这将在每个像素周围采样1像素的盒子，并确定中心像素的红色通道是否是该区域中的最大值。如果是，它就会停留。如果不是，则对所有颜色分量设置为0。

 GPUImageXYDerivativeFilter：Harris角点检测滤波器中的一个内部组件，它计算这一点左右像素之间的平方差，这个像素上下的像素的平方差，以及这两个差异的乘积。

 GPUImageCrosshairGenerator：它在图像上绘制一系列十字准线，最常用于识别机器视觉特征。它不像其他滤镜那样采用标准图像，而是采用其-renderCrosshairsFromArray：count：方法中的一系列点来完成实际绘制。您需要强制此过滤器以您需要的特定输出大小进行渲染。

 crosshairWidth：要在屏幕上绘制的十字准线的宽度（以像素为单位）。

 GPUImageDilationFilter：执行图像扩张操作，其中矩形邻域中红色通道的最大强度用于该像素的强度。要初始化的矩形区域的半径在初始化时指定，范围为1-4像素。这适用于灰度图像，并可扩展明亮区域。

 GPUImageRGBDilationFilter：这与GPUImageDilationFilter相同，只是它作用于所有颜色通道，而不仅仅是红色通道。

 GPUImageErosionFilter：执行图像侵蚀操作，其中矩形邻域中的红色通道的最小强度用于该像素的强度。要初始化的矩形区域的半径在初始化时指定，范围为1-4像素。这适用于灰度图像，并可扩展暗区。

 GPUImageRGBErosionFilter：这与GPUImageErosionFilter相同，只是它作用于所有颜色通道，而不仅仅是红色通道。

 GPUImageOpeningFilter：这会对图像的红色通道进行侵蚀，然后进行相同半径的扩张。半径在初始化时设置，范围为1-4像素。这会过滤掉较小的明亮区域。

 GPUImageRGBOpeningFilter：这与GPUImageOpeningFilter相同，只是它作用于所有颜色通道，而不仅仅是红色通道。

 GPUImageClosingFilter：这会对图像的红色通道执行扩张，然后对同一半径进行侵蚀。半径在初始化时设置，范围为1-4像素。这会滤除较小的暗区。

 GPUImageRGBClosingFilter：这与GPUImageClosingFilter相同，只是它作用于所有颜色通道，而不仅仅是红色通道。

 GPUImageLocalBinaryPatternFilter：执行8个周围像素的红色通道的强度与中心像素的红色通道的强度的比较，将比较结果编码为变为该像素强度的位串。最低有效位是右上角比较，逆时针以正确比较结束为最高位。

 GPUImageLowPassFilter：这会对传入的视频帧应用低通滤波器。这基本上累积了先前帧的加权滚动平均值和当前帧的加权滚动平均值。这可以用于去噪视频，添加运动模糊或用于创建高通滤波器。

 filterStrength：它控制先前累积的帧与当前累积的帧混合的程度。范围从0.0到1.0，默认值为0.5。
 GPUImageHighPassFilter：这会对传入的视频帧应用高通滤波器。这是低通滤波器的反函数，显示当前帧与先前帧的加权滚动平均值之间的差异。这对于运动检测最有用。
 filterStrength：它控制先前累积帧的混合程度，然后从当前累计帧中减去。范围从0.0到1.0，默认值为0.5。

 GPUImageMotionDetector：这是一个基于高通滤波器的运动检测器。您可以设置motionDetectionBlock，并且在每个输入帧上，它将为您提供场景中任何检测到的移动的质心（在标准化的X，Y坐标中）以及场景的运动强度。

 lowPassFilterStrength：它控制幕后使用的低通滤波器的强度，以建立与传入帧进行比较的基线。范围从0.0到1.0，默认值为0.5。

 GPUImageHoughTransformLineDetector：使用Hough变换检测图像中的线到并行坐标空间。

 edgeThreshold：检测到一个点属于用于确定线的边的阈值。默认值为0.9。
 lineDetectionThreshold：检测到局部最大值属于并行坐标空间中的线的阈值。默认值为0.20。
 linesDetectedBlock：在检测到行时调用此块，通常在每个已处理的帧上。包含归一化斜率和m，b对（y = mx + b）中的截距的AC阵列，以及检测到的行数和视频帧的当前时间戳的计数。

 GPUImageLineGenerator：一个生成可以覆盖场景的线的辅助类。

 setLineColorRed：调整这些线条的颜色：绿色：蓝色：
 lineWidth：行的宽度（以像素为单位），默认值为1.0。

 GPUImageMotionBlurFilter：将定向运动模糊应用于图像

 blurSize：模糊大小的乘数，范围从0.0开始，默认值为1.0
 blurAngle：模糊的角度方向，以度为单位，默认为0度。

 GPUImageZoomBlurFilter：将定向运动模糊应用于图像

 blurSize：模糊大小的乘数，范围从0.0开始，默认值为1.0
 blurCenter：模糊的标准化中心，默认情况（0.5,0.5）

 三、混合模式

 GPUImageChromaKeyBlendFilter：用第二个图像有选择地替换第一个图像中的颜色

 thresholdSensitivity：要替换的目标颜色需要与颜色匹配的接近程度（默认值为0.4）
 smoothing(平滑)：混合颜色匹配的平滑程度（默认值为0.1）

 GPUImageDissolveBlendFilter：应用两个图像的溶解混合

 mix：第二个图像覆盖第一个图像的程度（0.0 - 1.0，默认值为0.5）

 GPUImageMultiplyBlendFilter：应用两个图像的多重混合

 GPUImageAddBlendFilter：应用两个图像的叠加混合

 GPUImageSubtractBlendFilter：应用两个图像的减法混合

 GPUImageDivideBlendFilter：应用两个图像的分割混合

 GPUImageOverlayBlendFilter：应用两个图像的叠加混合

 GPUImageDarkenBlendFilter：通过获取图像之间每个颜色分量的最小值来混合两个图像

 GPUImageLightenBlendFilter：通过获取图像之间每个颜色分量的最大值来混合两个图像

 GPUImageColorBurnBlendFilter：应用两个图像的颜色刻录混合

 GPUImageColorDodgeBlendFilter：应用两个图像的颜色减淡混合

 GPUImageScreenBlendFilter：应用两个图像的屏幕混合

 GPUImageExclusionBlendFilter：应用两个图像的排除混合

 GPUImageDifferenceBlendFilter：应用两个图像的差异混合

 GPUImageHardLightBlendFilter：应用两个图像的硬光混合

 GPUImageSoftLightBlendFilter：应用两个图像的柔和光混合

 GPUImageAlphaBlendFilter：根据第二个alpha通道将第二个图像混合在第一个图像上

 mix：第二个图像覆盖第一个图像的程度（0.0 - 1.0，默认值为1.0）

 GPUImageSourceOverBlendFilter：在两个图像的混合上应用源

 GPUImageColorBurnBlendFilter：应用两个图像的颜色刻录混合

 GPUImageColorDodgeBlendFilter：应用两个图像的颜色减淡混合

 GPUImageNormalBlendFilter：应用两个图像的正常混合

 GPUImageColorBlendFilter：应用两个图像的颜色混合

 GPUImageHueBlendFilter：应用两个图像的色调混合

 GPUImageSaturationBlendFilter：应用两个图像的饱和度混合

 GPUImageLuminosityBlendFilter：应用两个图像的光度混合

 GPUImageLinearBurnBlendFilter：应用两个图像的线性刻录混合

 GPUImagePoissonBlendFilter：应用两个图像的泊松混合

 mix：混合范围从0.0（仅图像1）到1.0（仅图像2渐变），1.0为正常水平
 numIterations：传播渐变的次数。

 GPUImageMaskFilter：使用另一个图像掩盖一个图像

 四、视觉效果

 包含溶解，添加混合，分割混合，乘法混合，叠加混合，减淡混合，加深混合等

 GPUImagePixellateFilter：对图像或视频应用像素化效果

 fractionalWidthOfAPixel：像素的大小，作为图像宽度和高度的一小部分（0.0 - 1.0，默认值为0.05）

 GPUImagePolarPixellateFilter：根据极坐标而不是笛卡尔坐标对图像或视频应用像素化效果

 center：应用像素化的中心，默认为（0.5,0.5）
 pixelSize：小数像素大小，分为宽度和高度分量。默认值为（0.05,0.05）

 GPUImagePolkaDotFilter：将图像分解为常规网格中的彩色点

 fractionalWidthOfAPixel：点的大小，作为图像宽度和高度的一小部分（0.0 - 1.0，默认值为0.05）
 dotScaling：每个网格空间的一小部分由一个点占用，从0.0到1.0，默认值为0.9。

 GPUImageHalftoneFilter：对图像应用半色调效果，如新闻打印

 fractionalWidthOfAPixel：半色调点的大小，作为图像宽度和高度的一小部分（0.0 - 1.0，默认值为0.05）

 GPUImageCrosshatchFilter：这会将图像转换为黑白交叉线图案

 crossHatchSpacing：图像的小数宽度，用作交叉线的间距。默认值为0.03。
 lineWidth：交叉线的相对宽度。默认值为0.003。

 GPUImageSketchFilter：将视频转换为草图。这只是Sobel边缘检测滤波器，颜色反转

 texelWidth与texelHeight：这些参数会影响检测到的边缘的可见性
 edgeStrength：调整过滤器的动态范围。较高的值会导致较强的边缘，但会使强度色彩空间饱和。默认值为1.0。

 GPUImageThresholdSketchFilter：与草图过滤器相同，只有边缘是阈值而不是灰度

 texelWidth与texelHeight：这些参数会影响检测到的边缘的可见性
 edgeStrength：调整过滤器的动态范围。较高的值会导致较强的边缘，但会使强度色彩空间饱和。默认值为1.0。
 threshold(阈值)：高于此阈值的任何边缘将为黑色，并且任何低于白色的边缘。范围从0.0到1.0，默认值为0.8

 GPUImageToonFilter：它使用Sobel边缘检测在物体周围放置黑色边框，然后量化图像中的颜色，为图像提供类似卡通的质量。

 texelWidth与texelHeight：这些参数会影响检测到的边缘的可见性
 threshold(阈值)：边缘检测的灵敏度，较低的值更敏感。范围从0.0到1.0，默认值为0.2
 quantizationLevels：要在最终图像中表示的颜色级别数。默认值为10.0

 GPUImageSmoothToonFilter：它使用与GPUImageToonFilter类似的过程，只有在使用高斯模糊的香椿效果之前才能消除噪音。

 texelWidth与texelHeight：这些参数会影响检测到的边缘的可见性
 blurRadiusInPixels：基础高斯模糊的半径。默认值为2.0。
 threshold(阈值)：边缘检测的灵敏度，较低的值更敏感。范围从0.0到1.0，默认值为0.2
 quantizationLevels：要在最终图像中表示的颜色级别数。默认值为10.0

 GPUImageEmbossFilter：对图像应用浮雕效果

 intensity(强度)：压花的强度，从0.0到4.0，1.0为正常水平

 GPUImagePosterizeFilter：这会将颜色动态范围缩小为指定的步数，从而产生类似卡通的简单着色图像。

 colorLevels：减少图像空间的颜色级别数。范围从1到256，默认值为10。

 GPUImageSwirlFilter：在图像上创建漩涡扭曲

 radius：从中心开始应用失真的半径，默认值为0.5
 center：图像的中心（在0 - 1.0的标准化坐标中）关于哪个扭曲，默认值为（0.5,0.5）
 angle：应用于图像的扭曲量，默认值为1.0

 GPUImageBulgeDistortionFilter：在图像上创建凸起失真

 radius：从中心开始应用失真的半径，默认值为0.25
 center：图像的中心（在0 - 1.0的标准化坐标中）有关其扭曲的内容，默认值为（0.5,0.5）
 scale：要应用的失真量，从-1.0到1.0，默认值为0.5

 GPUImagePinchDistortionFilter：创建图像的捏合扭曲

 radius：从中心开始应用失真的半径，默认值为1.0
 center：图像的中心（在0 - 1.0的标准化坐标中）有关其扭曲的内容，默认值为（0.5,0.5）
 scale：要应用的失真量，从-2.0到2.0，默认值为1.0

 GPUImageStretchDistortionFilter：创建图像的拉伸扭曲

 center：图像的中心（在0 - 1.0的标准化坐标中）有关其扭曲的内容，默认值为（0.5,0.5）

 GPUImageSphereRefractionFilter：模拟玻璃球体的折射

 center：应用失真的中心，默认值为（0.5,0.5）
 radius：失真的半径，范围从0.0到1.0，默认值为0.25
 refractiveIndex：球体的折射率，默认值为0.71

 GPUImageGlassSphereFilter：与GPUImageSphereRefractionFilter相同，只是图像没有倒置，玻璃边缘有一点点结霜

 center：应用失真的中心，默认值为（0.5,0.5）
 radius：失真的半径，范围从0.0到1.0，默认值为0.25
 refractiveIndex：球体的折射率，默认值为0.71

 GPUImageVignetteFilter：执行渐晕效果，淡化边缘处的图像

 vignetteCenter：tex coords（CGPoint）中晕影的中心，默认值为0.5,0.5
 vignetteColor：用于晕影（GPUVector3）的颜色，默认为黑色
 vignetteStart：与晕影效果开始的中心的标准化距离，默认值为0.5
 vignetteEnd：与晕影效果结束的中心的标准化距离，默认值为0.75

 GPUImageKuwaharaFilter：Kuwahara图像抽象，会产生类似油画的图像，但它的计算成本非常高，因此在iPad 2上渲染帧可能需要几秒钟，这最适合用于静止图像。

 radius：整数，指定应用过滤器时要测试的中心像素外的像素数，默认值为4，较高的值会创建更抽象的图像，但代价是处理时间要长得多。
 GPUImageKuwaharaRadius3Filter：经过优化，只能在三个像素的半径上工作
 GPUImagePerlinNoiseFilter：生成一个充满Perlin噪声的图像
 colorFinish：生成噪声的颜色范围
 scale：生成的噪声的缩放比例

 GPUImageCGAColorspaceFilter：模拟CGA监视器的色彩空间

 GPUImageMosaicFilter：此滤镜采用输入tileset，tile必须以亮度提升。它查看输入图像并根据该图块的亮度用输入图块替换每个显示图块。这是复制其他应用程序中看到的ASCII视频过滤器，但是tileset可以是任何东西。

 GPUImageJFAVoronoiFilter：生成Voronoi映射，供以后使用。

 sizeInPixels：各个元素的大小

 GPUImageVoronoiConsumerFilter：接收Voronoi地图，并使用它来过滤传入的图像。

 sizeInPixels：各个元素的大小

 作者：骑着蜗牛追流星
 链接：https://www.jianshu.com/p/456cc371d195
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 **/

NS_ASSUME_NONNULL_END
