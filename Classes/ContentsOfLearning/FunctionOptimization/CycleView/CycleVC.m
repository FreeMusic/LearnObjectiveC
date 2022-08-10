//
//  CycleVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/8/10.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "CycleVC.h"
#import "XYCyclePlayView.h"

@interface CycleVC ()

@end

@implementation CycleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *url = @"http://photo.tanwin.cn/tempfile/2022-08-10/cb82ad0204c186d0ee08332cd4f762e2.jpg";
    
    NSArray *dataSource = @[
        url,
        @"http://photo.tanwin.cn/tempfile/2022-08-10/acdc9e5fe7a4df1f1df87ad9f3dbd979.jpg",
        @"http://photo.tanwin.cn/tempfile/2022-08-10/afa1353008c3b07668af1557464a23cb.jpg",
        @"http://photo.tanwin.cn/tempfile/2022-08-10/cc860b48b5a6fc701e18284fa58c7516.jpg"
    ];
    
    XYCyclePlayView *cycleView = [[XYCyclePlayView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, kScreenWidth, 300) dataSource:dataSource];
    [self.view addSubview:cycleView];
    [cycleView setTouchIndexRow:^(NSUInteger index) {
        RYQLog(@"点击了%ld", index);
    }];
}

- (void)dealloc {
    [[XYGCDTimer shareTimer] removeTimer];
}

@end
