//
//  XYMessageTool.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2021/8/11.
//  Copyright © 2021 橘子. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYMessageTool : NSObject

/// 获取本类的元类
+ (Class)getMetaClassWithChildClass:(Class)childClass;

+ (void)addInstanceMethodWithSel:(SEL)sel withClass:(Class)selClass impMethodSel:(SEL)impMethodSel;

+ (void)addClassMethodWithSel:(SEL)sel withClass:(Class)selClass impMethodSel:(SEL)impMethodSel;

@end

NS_ASSUME_NONNULL_END
