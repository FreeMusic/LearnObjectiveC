//
//  XYKeyBoard.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/7/25.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "XYKeyBoard.h"

static CGFloat keyBoardHeight = 240;
static CGFloat TimeInterval = 0.3;

static int baseTag = 4598;

static NSString *deleteString = @"删除";

@interface XYKeyBoard ()

@property (nonatomic, strong) UIView *keyBoardView;///

@property (nonatomic, strong) NSArray *boardArray;///
///
@property (nonatomic, strong) NSString *inputString;///

@end

@implementation XYKeyBoard

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat width = (kScreenWidth - 2) / 3;
        CGFloat height = (keyBoardHeight - 3) / 4;
        
        self.inputString = @"";
        _maxNum = 6;
        
        _keyBoardView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, keyBoardHeight)];
        _keyBoardView.backgroundColor = [UIColor grayColor];
        self.boardArray = @[
            @"1", @"2", @"3", @"4", @"5", @"6", @"7",
            @"8", @"9", @"X", @"0", deleteString,
        ];
        for (int i = 0; i < _boardArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:_boardArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            int y = i / 3;
            int x = i % 3;
            button.tag = baseTag + i;
            button.frame = CGRectMake(x*(width+1), y*(height+1), width, height);
            button.backgroundColor = [UIColor whiteColor];
            [button addTarget:self action:@selector(touchNum:) forControlEvents:UIControlEventTouchUpInside];
            [_keyBoardView addSubview:button];
        }
        [self addSubview:_keyBoardView];
    }
    
    return self;
}

- (void)touchNum:(UIButton *)sender {
    NSString *input = self.boardArray[sender.tag - baseTag];
    if ([input isEqualToString:deleteString]) {
        if (self.inputString.length == 0) {return;}
        NSInteger length = self.inputString.length - 1;
        self.inputString = [self.inputString substringToIndex:length];
    }else{
        if (self.maxNum && !(self.inputString.length < self.maxNum)) {
            [self hideKeyBoard];
            return;
        }
        self.inputString = [self.inputString stringByAppendingString:input];
        if (self.inputString.length == self.maxNum) {
            [self hideKeyBoard];
        }
    }
    if (self.inputChangeAction) {
        self.inputChangeAction(self.inputString);
    }
}

- (void)showKeyBoard {
    self.hidden = NO;
    [UIView animateWithDuration:TimeInterval animations:^{
        self.keyBoardView.frame = CGRectMake(0, kScreenHeight - keyBoardHeight, kScreenWidth, keyBoardHeight);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hideKeyBoard];
}

- (void)hideKeyBoard {
    [UIView animateWithDuration:TimeInterval animations:^{
        self.keyBoardView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, keyBoardHeight);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

@end
