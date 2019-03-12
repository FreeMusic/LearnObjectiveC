//
//  BoundsNextVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/12.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "BoundsNextVC.h"
#import "NSArray+ErrorHandle.h"
#import "NSMutableArray+ErrorHandle.h"

@interface BoundsNextVC ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation BoundsNextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSArray arrayWithObjects:@"语文", @"数学", @"英语", nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
#pragma mark - cellForRowAtIndexPath
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        if (indexPath.row < self.dataSource.count) {
            UITextField *textFiled = [[UITextField alloc] init];
            textFiled.frame = CGRectMake(100, 0, kScreenWidth-100, 50);
            textFiled.placeholder = @"此处是NSArray的数组越界处理";
            [cell addSubview:textFiled];
        }else{
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
            label.textColor = [UIColor blackColor];
            label.text = @"点击此处去查看NSMutableArray的数组越界处理";
            [cell addSubview:label];
        }
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
