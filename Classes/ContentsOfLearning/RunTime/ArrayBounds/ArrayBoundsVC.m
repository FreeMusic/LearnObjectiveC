//
//  ArrayBoundsVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/12.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "ArrayBoundsVC.h"
#import "NSArray+ErrorHandle.h"
#import "NSMutableArray+ErrorHandle.h"
#import "BoundsNextVC.h"

@interface ArrayBoundsVC ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSArray *array;

@end

@implementation ArrayBoundsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *type = nil;
    self.array = [NSArray arrayWithObjects:@"语文", @"数学", @"英语", nil];
    [self.dataSource addObjectVerify:type];
    [self.dataSource addObjectVerify:@"语文"];
    [self.dataSource addObjectVerify:@"数学"];
    [self.dataSource addObjectVerify:@"英语"];
    [self.dataSource insertObjectVerify:type atIndex:10];
    [self.dataSource insertObjectVerify:@"物理" atIndex:2];
}
/**
 *  dataSource
 */
- (NSMutableArray *)dataSource{
    if(!_dataSource){
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count+5;
}
#pragma mark - cellForRowAtIndexPath
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        if (indexPath.row < self.dataSource.count) {
            UITextField *textFiled = [[UITextField alloc] init];
            textFiled.frame = CGRectMake(70, 0, kScreenWidth-70, 50);
            textFiled.placeholder = @"此处是NSMutableArray的数组越界处理";
            [cell addSubview:textFiled];
        }else{
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, kScreenWidth-30, 50)];
            label.textColor = [UIColor blackColor];
            label.text = @"点击此处去查看NSArray的数组越界处理";
            [cell addSubview:label];
        }
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    //cell.textLabel.text = self.dataSource[indexPath.row];
    //cell.textLabel.text = [self.dataSource objectAtIndexVerify:indexPath.row];
    //cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BoundsNextVC *tempVC = [[BoundsNextVC alloc] init];
    
    [self.navigationController pushViewController:tempVC animated:YES];
}


@end
