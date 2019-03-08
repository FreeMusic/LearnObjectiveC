//
//  MyTableViewVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "MyTableViewVC.h"

@interface MyTableViewVC ()

@end

@implementation MyTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
}

/**
 tableView的懒加载
 */
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = WHITE_COLOR;
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionHeaderHeight = 0;
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}
/**
 无数据背景图
 */
- (UIImageView *)noDataImgView{
    if(!_noDataImgView){
        _noDataImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"withOutData"]];
        [self.tableView addSubview:_noDataImgView];
        [_noDataImgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.tableView.centerX);
            make.centerY.equalTo(self.tableView.centerY);
            make.size.equalTo(CGSizeMake(170*m6Scale, 170*m6Scale));
        }];
    }
    return _noDataImgView;
}

#pragma  UITableViewDataSource---numberOfRowsInSection
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Messages.count;
}

#pragma UITableViewDataSource---cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    ObjectiveModel *model = self.Messages[indexPath.row];
    cell.textLabel.text = model.title;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120*m6Scale;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ObjectiveModel *model = self.Messages[indexPath.row];
    
    if (model.vcName) {
        UIViewController *vc = [NSClassFromString(model.vcName) new];
        vc.title = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        model.vc.title = model.title;
        [self.navigationController pushViewController:model.vc animated:YES];
    }
}

@end
