//
//  KeyBoardVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/7/25.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "KeyBoardVC.h"
#import "XYKeyBoard.h"

@interface KeyBoardVC ()

@property (nonatomic, strong) XYKeyBoard *keyBoard;///

@end

static int labelTag = 999;

static int pointTag = 9991;

int labelNum = 6;

@implementation KeyBoardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat labelWidth = 50;
    
    CGFloat padSpace = (kScreenWidth-labelNum*labelWidth)/2;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(padSpace, 100, labelWidth*labelNum+labelNum+1, labelWidth+2)];
    [self.view addSubview:backView];
    backView.backgroundColor = [UIColor grayColor];
    
    for (int i = 0; i < labelNum; i++) {
        UILabel *label = [UILabel LabelWithColor:[UIColor redColor] andTextFont:30 andText:@"" addSubView:backView tapClick:^{
            [self.keyBoard showKeyBoard];
        }];
        label.backgroundColor = [UIColor whiteColor];
        label.tag = labelTag+i;
        label.textAlignment = NSTextAlignmentCenter;
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(labelWidth);
            make.left.equalTo(1+(labelWidth+1)*i);
            make.top.equalTo(1);
        }];
        
        UIView *point = [[UIView alloc] init];
        point.backgroundColor = [UIColor whiteColor];
        [label addSubview:point];
        CGFloat pointWidth = 15;
        point.tag = pointTag + i;
        [point setApplyColoursCornerRadious: pointWidth/2];
        [point makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(pointWidth);
            make.centerY.equalTo(label.centerY);
            make.centerX.equalTo(label.centerX);
        }];
    }
}

- (XYKeyBoard *)keyBoard {
    if (_keyBoard == nil){
        _keyBoard = [[XYKeyBoard alloc] initWithFrame:self.view.bounds];
        _keyBoard.maxNum = labelNum;
        [self.view addSubview:_keyBoard];
        MJWeakSelf
        [_keyBoard setInputChangeAction:^(NSString * _Nonnull text) {
            NSUInteger length = text.length;
            for (int i = 0 ; i < labelNum; i++) {
//                NSString *charctor = @"";
//                if (length > i) {
//                    charctor = [text substringWithRange:NSMakeRange(i, 1)];
//                }
//                UILabel *label = (UILabel *)[weakSelf.view viewWithTag:labelTag+i];
//                label.text = charctor;
                UIView *point = (UIView *)[weakSelf.view viewWithTag:pointTag+i];
                point.backgroundColor = (length > i) ? [UIColor blackColor] : [UIColor whiteColor];
            }
            
        }];
    }
    
    return _keyBoard;
}


@end
