//
//  DocumentVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/10/31.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "DocumentVC.h"
#import <QuickLook/QuickLook.h>
#import "LZYPWebViewVC.h"

@interface DocumentVC ()<QLPreviewControllerDelegate, QLPreviewControllerDataSource>

@property (nonatomic, strong) QLPreviewController *previewController;

@end

@implementation DocumentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LZYPWebViewVC *webVC = [[LZYPWebViewVC alloc] initWithURL:@"http://photo.tanwin.cn/test/video/video_165415.mp4"];
    [self.navigationController pushViewController:webVC animated:YES];
//    //http://photo.tanwin.cn/tempfile/2022-10-31/85568d2f2412c6e6623dc65e2036f4b2.jpg
//    //http://photo.tanwin.cn/flowbusi/project-contract/2021-03-02/6e226f22e2dc9a7b17679caf6ec18679.pdf
//    NSString *url = @"http://photo.tanwin.cn/flowbusi/project-contract/2021-03-02/6e226f22e2dc9a7b17679caf6ec18679.pdf";
////    self.fileURL = [NSURL URLWithString:url];
//
//    self.title = @"附件预览";
//    _previewController = [[QLPreviewController alloc] init];
//    _previewController.dataSource = self;
//    _previewController.delegate = self;
//
//    _previewController.view.frame = CGRectMake(0, 64, self.view.frame.size.width , self.view.frame.size.height);
//    _previewController.currentPreviewItemIndex = 0;
//    self.previewController.view.backgroundColor = [UIColor yellowColor];
//    // [self addChildViewController:_previewController];
//    [self.view addSubview:_previewController.view];
////    [_previewController reloadData];
//
//    [self startDownloadFile:url];
}

- (void)startDownloadFile:(NSString *)fileUrl {
    AFHTTPSessionManager *mannager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:fileUrl]];
    NSURLSessionDownloadTask *task = [mannager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        RYQLog(@"%f", 1.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fullPath = [filePath stringByAppendingPathComponent:response.suggestedFilename];
        RYQLog(@"%@", fullPath);
        self.fileURL = [NSURL fileURLWithPath:fullPath];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.previewController reloadData];
        });
        
        return self.fileURL;
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        RYQLog(@"%@", filePath);
    }];
    
    [task resume];
}

- (id) previewController: (QLPreviewController *) controller previewItemAtIndex: (NSInteger) index{
    return self.fileURL;
}
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}



@end
