//
//  UIColor+Extention.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2020/11/13.
//  Copyright © 2020 橘子. All rights reserved.
//

#import "UIColor+Extention.h"

@implementation UIColor (Extention)

+ (UIColor*)randomColor {

NSInteger aRedValue = arc4random() %255;

NSInteger aGreenValue = arc4random() %255;

NSInteger aBlueValue = arc4random() %255;

UIColor *randColor = [UIColor colorWithRed:aRedValue /255.0f green:aGreenValue /255.0f blue:aBlueValue alpha:1.0f];

return randColor;

}

@end
