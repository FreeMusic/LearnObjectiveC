//
//  MyTableReFreshVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "MyTableReFreshVC.h"

@interface MyTableReFreshVC ()

@end

@implementation MyTableReFreshVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    //请求数据
    [self serviceData];
    self.navigationController.navigationBar.translucent = NO;
}
/**
 数据源
 */
- (NSMutableArray *)dataSource{
    if(!_dataSource){
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
/**
 请求数据
 */
- (void)serviceData{
    __weak typeof(self) weakSelf = self;
    //仿微博的下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self setUpData];
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    [self setUpData];
    //进入界面就开始刷新一下
    //    [self.tableView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf setUpData];
    }];
    // 默认先隐藏footer
    self.tableView.mj_footer.hidden = NO;
}

#pragma mark - 消息数据
-(void)setUpData{
    
}
/**
 请求数据成功后 刷新tableView
 */
- (void)refreshTableViewWithDataSource:(NSArray *)array{
    if (self.page==1) {
        self.dataSource = [NSMutableArray arrayWithArray:array];
        
        self.noDataImgView.hidden = !(self.dataSource.count == 0);
    }else{
        [self.dataSource addObjectsFromArray:array];
        self.noDataImgView.hidden = YES;
    }
    
    [self.tableView reloadData];
    
    if (array.count){
        [self.tableView.mj_footer endRefreshing];//有数据可以加载
    }else{
        [self.tableView.mj_footer endRefreshingWithNoMoreData];//没有数据可以加载
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 结束刷新
    [self.tableView.mj_header endRefreshing];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

@end
