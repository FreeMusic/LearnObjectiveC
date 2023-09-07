//
//  UIPDFSelectVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/11/10.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "UIPDFSelectVC.h"

@interface UIPDFSelectVC ()<UIDocumentPickerDelegate>

@property (nonatomic, strong) UIButton *button;//
@property (nonatomic, strong) UIDocumentPickerViewController *documentPickVC;//

@end

@implementation UIPDFSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *types = @[
        @"public.content",
        @"public.text",
        @"public.source-code ",
        @"public.image",
        @"public.audiovisual-content",
        @"com.adobe.pdf",
        @"com.apple.keynote.key",
        @"com.microsoft.word.doc",
        @"com.microsoft.excel.xls",
        @"com.microsoft.powerpoint.ppt"
    ];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:@"选择PDF" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.button.frame = CGRectMake(0, 100, 100, 50);
    [self.button addTarget:self action:@selector(openSelectPDF) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    self.documentPickVC = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:types inMode:UIDocumentPickerModeOpen];
    self.documentPickVC.delegate = self;
    self.documentPickVC.modalPresentationStyle = UIModalPresentationPageSheet;
    
    
    
}

- (void)openSelectPDF {
    [self presentViewController:self.documentPickVC animated:YES completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    BOOL canAccessingResource = [url startAccessingSecurityScopedResource];
    if(canAccessingResource) {
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error;
        [fileCoordinator coordinateReadingItemAtURL:url options:0 error:&error byAccessor:^(NSURL *newURL) {
            NSString *fileName = @"";
            NSArray *list = [newURL.absoluteString componentsSeparatedByString:@"/"];
            if (list.count > 0) {
              fileName = [list lastObject];
            }
            NSString *result = [fileName stringByReplacingOccurrencesOfString:@"+" withString:@" "];
            fileName = [fileName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            RYQLog(@"%@",fileName);
            NSData *fileData = [NSData dataWithContentsOfURL:newURL];
            NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);             NSString *documentPath = [arr lastObject];
            NSString *desFileName = [documentPath stringByAppendingPathComponent:@"file"];
            BOOL success = [fileData writeToFile:desFileName atomically:YES];
            RYQLog(@"point_test_log%@",desFileName);
            RYQLog(@"%d",success);
            NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:desFileName]];
            RYQLog(@"%@",data);
            [self dismissViewControllerAnimated:YES completion:NULL];
        }];
        if (error) {
            // error handing
        }
    } else {
        // startAccessingSecurityScopedResource fail
    }
    [url stopAccessingSecurityScopedResource];
}

int32_t const VH_CHUNK_SIZE = 8 * 1024;

//另存为
- (NSString *)writefile:(NSString *)filePath
{
    //写入文件路径
    NSString *toPath = [NSString stringWithFormat:@"%@/%@",NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject,[filePath lastPathComponent]];
    //如果存在，先删除
    if ([[NSFileManager defaultManager] fileExistsAtPath:toPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:toPath error:nil];
    }
    //创建文件路径
    if (![[NSFileManager defaultManager] createFileAtPath:toPath contents:nil attributes:nil]) {
        return nil;
    }
    //打开文件
    NSFileHandle *sourceHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    NSFileHandle *writeHandle = [NSFileHandle fileHandleForWritingAtPath:toPath];
    if(sourceHandle == nil || writeHandle == nil) {
        return nil;
    }
    //读取文件写入
    BOOL done = NO;
    while(!done) {
        @autoreleasepool{
            NSData *data = [sourceHandle readDataOfLength:VH_CHUNK_SIZE];
            if([data length] == 0) {
                done = YES;
            }
            [writeHandle seekToEndOfFile];
            [writeHandle writeData:data];
            data = nil;
        }
    }
    //关闭文件
    [sourceHandle closeFile];
    [writeHandle closeFile];
    return toPath;
}

//删除本地上传的文件
- (BOOL)deletefile:(NSString *)uploadPath {
    if ([[NSFileManager defaultManager] fileExistsAtPath:uploadPath]) {
        return [[NSFileManager defaultManager] removeItemAtPath:uploadPath error:nil];
    }
    return NO;
}



@end
