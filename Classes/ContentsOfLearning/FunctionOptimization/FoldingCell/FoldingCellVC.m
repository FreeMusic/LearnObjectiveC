//
//  FoldingCellVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/7/25.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "FoldingCellVC.h"
#import "FoldingModel.h"
#import "XYFoldTool.h"
#import "XYFoldCell.h"

@interface FoldingCellVC ()

@property (nonatomic, strong) NSMutableArray *titleArray;///
@property (nonatomic, strong) NSArray *dataSource;///
///
@property (nonatomic, assign) NSUInteger touchSection;///

@end

@implementation FoldingCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[
        @"历史1", @"历史2", @"历史3",@"历史4",@"历史5",@"历史6",@"历史7",@"历史8",@"历史9",@"历史10",@"历史11",@"历史12",
        @"历史13",@"历史14",@"历史15",@"历史16",@"历史17",
    ];
    _titleArray = [NSMutableArray array];
    _touchSection = -99;
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FoldingModel *model = [[FoldingModel alloc] initWithText:obj];
        [self.titleArray addObject:model];
    }];
    
    XYFoldTool *tool = [[XYFoldTool alloc] init];
    [tool initCollectionView];
    [tool calculateNumberOfRowsInTableViewWithSource:self.titleArray complitionBlock:^(NSArray *attributes) {
        self.dataSource = attributes;
        [self.tableView reloadData];
    }];
    
    [self.tableView registerClass:[XYFoldCell class] forCellReuseIdentifier:@"XYFoldCell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYFoldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XYFoldCell"];
    NSArray *list = self.dataSource[indexPath.section];
    [cell setDataSource:list];
    [cell setTouchIndexRow:^(NSUInteger index) {
        RYQLog(@"点击了第%ld行  第%ld个", indexPath.section, index);
        self->_touchSection = indexPath.section;
        [self.tableView reloadData];
    }];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (_touchSection == section) {
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = [UIColor yellowColor];

        return footerView;
    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_touchSection == section) {
        return 300;
    }

    return 0;
}


@end
