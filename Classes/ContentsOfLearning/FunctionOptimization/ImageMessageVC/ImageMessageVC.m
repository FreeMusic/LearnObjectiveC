//
//  ImageMessageVC.m
//  LearnObjectiveC
//
//  Created by 孙晓阳 on 2019/4/5.
//  Copyright © 2019年 橘子. All rights reserved.
//          简单来说  拍照获取照片，当前时间 和 当前位置
//          相册获取照片，ALAssetsLibrary来获取拍摄时间和拍摄地点

#import "ImageMessageVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <ImageIO/CGImageProperties.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import <Photos/Photos.h>
#import "NSDictionary+CLLocation.h"
#import "GeoCoding.h"

@interface ImageMessageVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerVC;

@property (nonatomic, strong) CLLocationManager *locationManager;//拍照定位

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UILabel *jingdu;
@property (strong, nonatomic) UILabel *weidu;
@property (strong, nonatomic) UILabel *location;

@property (nonatomic, copy) NSString *locationFormat;

@property (nonatomic, strong) NSArray *titles;

@end

@implementation ImageMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    self.imageView = [UIImageView new];
    self.imageView.backgroundColor = [UIColor grayColor];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(650*m6Scale, 300*m6Scale));
        make.top.equalTo(NavigationBarHeight+50*m6Scale);
        make.centerX.equalTo(self.view.centerX);
    }];
    
    NSURL *url = [NSURL URLWithString:@"https://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=baiduwangpan&step_word=&hs=0&pn=10&spn=0&di=201410&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&istype=0&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=undefined&cs=326450101%2C2585356879&os=1480216915%2C3283920824&simid=4192784792%2C943291813&adpicid=0&lpn=0&ln=1409&fr=&fmq=1555405289307_R&fm=&ic=undefined&s=undefined&hd=undefined&latest=undefined&copyright=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&ist=&jit=&cg=&bdtype=0&oriquery=&objurl=http%3A%2F%2Fimg.xiazaizhijia.com%2Fuploads%2F2016%2F1028%2F20161028043020792.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bxtwzwtzit3tw_z%26e3Bv54AzdH3F633vAzdH3F889ac9_z%26e3Bip4s&gsm=0&rpstart=0&rpnum=0&islist=&querylist=&force=undefined"];
    [self.imageView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        XYLog(@"%@    %@     %@", image, error,  imageURL);
        
    }];
    
    self.titles = @[
                    @"拍摄时间：",
                    @"拍摄经度：",
                    @"拍摄维度：",
                    @"拍摄位置："
                    ];
    
    self.time = [self labelWithPosition:0];
    self.jingdu = [self labelWithPosition:1];
    self.weidu = [self labelWithPosition:2];
    self.location = [self labelWithPosition:3];
    
    NSArray *buttonTitles = @[
                              @"拍照",
                              @"选用相册",
                              ];
    for (int i = 0; i < buttonTitles.count; i++) {
        
        UIButton *myButton = [UIButton ButtonWithTitle:buttonTitles[i] ButtonBackColor:ButtonGrayColorWithLine CornerRadius:10 addSubView:self.view buttonActionBlock:^(UIButton *button) {
            [self buttonClick:button];
        }];
        myButton.tag = 10000+i;
        [myButton makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(kScreenWidth/2, 90*m6Scale));
            make.top.equalTo(self.location.bottom).offset(100*m6Scale);
            make.left.equalTo(i*kScreenWidth/2);
        }];
    }
}

- (UILabel *)labelWithPosition:(int)position{
    
    UILabel *label = [UILabel LabelWithColor:BLACK_COLOR andTextFont:12 andText:self.titles[position] addSubView:self.view];
    label.numberOfLines = 0;
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.left);
        make.top.equalTo(self.imageView.bottom).offset((position+1)*70*m6Scale);
        make.right.equalTo(0);
    }];
    
    return label;
}

- (void)buttonClick:(UIButton *)sender{
    switch (sender.tag) {
        case 10000:{
            //拍照
            self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            // model出控制器
            [self presentViewController:self.imagePickerVC animated:YES completion:nil];
        }
            break;
        case 10001:{
            ////相册
            self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            // model出控制器
            [self presentViewController:self.imagePickerVC animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark 拍照定位

-(void)getLocation
{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        [self.locationManager requestAlwaysAuthorization];
        
        [self.locationManager requestWhenInUseAuthorization];
        
        //设置寻址精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 5.0;
        [self.locationManager startUpdatingLocation];
    }
}

//定位失败后调用此代理方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{}

//获取一次定位，然后关掉manager
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //防止多次调用
    
    CLLocation *currentLocation = [locations lastObject];
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    
    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
    
    if (locationAge > 5.0) return;
    
    if (currentLocation.horizontalAccuracy < 0) return;
    
    //判断是不是属于国内范围
    if (![GeoCoding isLocationOutOfChina:[currentLocation coordinate]]) {
        //转换后的coord
        coord = [GeoCoding transformFromWGSToGCJ:[currentLocation coordinate]];
    }

    //当前经纬度
    self.jingdu.text = [NSString stringWithFormat:@"拍摄纬度：%f", coord.longitude];
    self.weidu.text = [NSString stringWithFormat:@"拍摄经度：%f", coord.latitude];
    
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    
    CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    
    __weak typeof(self)weakSelf = self;
    
    //反向地理编码的请求 -> 根据经纬度 获取 位置
    [clGeoCoder reverseGeocodeLocation:newLocation completionHandler: ^(NSArray *placemarks,NSError *error) {
        
        for (CLPlacemark *placeMark in placemarks)
        {
            NSDictionary *addressDic=placeMark.addressDictionary;
            
            NSArray *location_Arr = [addressDic objectForKey:@"FormattedAddressLines"];//系统格式化后的位置
            
            weakSelf.location.text = [NSString stringWithFormat:@"拍摄位置：%@", [location_Arr firstObject]];
        }
    }];
    
    [self.locationManager stopUpdatingLocation];
    
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    //[Generic] Creating an image format with an unknown type is an error
    
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.imageView.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"info:----->\n%@", info);
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera) {//拍照
        
        //照片mediaInfo
        NSDictionary * imageMetadata = info[@"UIImagePickerControllerMediaMetadata"];
        
        NSDictionary *tIFFDictionary =  [imageMetadata objectForKey:(NSString *)kCGImagePropertyTIFFDictionary];
        
        NSString * pictureTime = tIFFDictionary[@"DateTime"];//2016:01:05 11:45:36
        
        self.time.text = [NSString stringWithFormat:@"拍摄时间：%@", pictureTime];
        
        if ([CLLocationManager locationServicesEnabled]) {
            
            //获取经纬度
            [self getLocation];
            
        }else {
            NSLog(@"请开启定位功能！");
        }
        
    } else if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){//相册
        
        NSURL *assetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
        
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        
        XYLog(@"%@", info);
        
        __block NSMutableDictionary *imageMetadata_GPS = nil;
        
        __weak typeof(self)weakSelf = self;
        
        [library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            
            //获取时间
            NSDate* pictureDate = [asset valueForProperty:ALAssetPropertyDate];
            NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"yyyy:MM:dd HH:mm:ss";
            formatter.timeZone = [NSTimeZone localTimeZone];
            NSString * pictureTime = [formatter stringFromDate:pictureDate];
            weakSelf.time.text = [NSString stringWithFormat:@"拍摄时间：%@", pictureTime];
            
            //获取GPS
            imageMetadata_GPS = [[NSMutableDictionary alloc] initWithDictionary:asset.defaultRepresentation.metadata];
            
            NSDictionary *GPSDict=[imageMetadata_GPS objectForKey:(NSString*)kCGImagePropertyGPSDictionary];
            
            if (GPSDict!=nil) {
                
                CLLocation *loc=[GPSDict locationFromGPSDictionary];
                
                weakSelf.weidu.text = [NSString stringWithFormat:@"拍摄纬度：%f", loc.coordinate.latitude];
                weakSelf.jingdu.text = [NSString stringWithFormat:@"拍摄经度：%f", loc.coordinate.longitude];
                
                CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
                
                CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:loc.coordinate.latitude longitude:loc.coordinate.longitude];
                
                //反向地理编码的请求 -> 根据经纬度 获取 位置
                [clGeoCoder reverseGeocodeLocation:newLocation completionHandler: ^(NSArray *placemarks,NSError *error) {
                    for (CLPlacemark *placeMark in placemarks)
                    {
                        NSDictionary *addressDic=placeMark.addressDictionary;
                        
                        NSArray *location_Arr = [addressDic objectForKey:@"FormattedAddressLines"];//系统格式化后的位置
                        
                        weakSelf.location.text = [NSString stringWithFormat:@"拍摄位置：%@", [location_Arr firstObject]];
                        
                    }
                }];
                
            }else{
                weakSelf.weidu.text = @"拍摄纬度：此照片没有GPS信息";
                weakSelf.jingdu.text = @"拍摄经度：此照片没有GPS信息";
                weakSelf.location.text = @"拍摄位置：此照片没有拍摄位置";
            }
            
        }
         
                failureBlock:^(NSError *error) {
                }];
    }
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"点击了取消按钮");
    [picker dismissViewControllerAnimated:YES completion:nil];
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
        // 是否允许编辑（YES：图片选择完成进入编辑模式）
        //        _imagePickerVC.allowsEditing = YES;
        
    }
    return _imagePickerVC;
}


-(CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 1000.0f;
    }
    return _locationManager;
}

@end
