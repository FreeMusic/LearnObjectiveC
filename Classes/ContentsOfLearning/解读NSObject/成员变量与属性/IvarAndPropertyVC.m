//
//  IvarAndPropertyVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2020/7/16.
//  Copyright © 2020 橘子. All rights reserved.
//

#import "IvarAndPropertyVC.h"
#import "IvarPropertyObject.h"
#import <objc/runtime.h>

@interface IvarAndPropertyVC ()

@end

@implementation IvarAndPropertyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //*********获取所有属性**********//
    [self lxy_ObjectWithIvars];
    /// 获取所有成员变量
    [self lxy_ObjectWithProperties];
}

- (void)threadPlayInBackgrond {
    XYLog(@"threadPlayInBackgrond");
}

//*********获取所有属性**********//
- (void)lxy_ObjectWithIvars {
    unsigned int ivarCount = 0;
    Ivar *invars = class_copyIvarList([IvarPropertyObject class], &ivarCount);
    for (unsigned int i = 0; i < ivarCount; i++) {
        Ivar ivar = invars[i];
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        
        XYLog(@"属性名称为 ： %s     类型 ：%s", name, type);
    }
}

/// 获取所有成员变量
- (void)lxy_ObjectWithProperties {
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList([IvarPropertyObject class], &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        //属性名
        const char *name = property_getName(property);
        //属性描述
        const char *propertyAttr = property_getAttributes(property);
        
        XYLog(@"成员变量的名称：%s   类型：%s", propertyAttr, name);
        //属性的特性
        unsigned int attrCount = 0;
        objc_property_attribute_t *atts = property_copyAttributeList(property, &attrCount);
        for (unsigned int k = 0; k < attrCount; k++) {
            objc_property_attribute_t attr = atts[k];
            const char *attrname = attr.name;
            const char *value = attr.value;
            
//            XYLog(@"成员变量的描述：%s   value：%s", attrname, value);
        }
        free(atts);
    }
    
    free(properties);
}

@end
