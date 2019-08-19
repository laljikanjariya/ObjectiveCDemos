//
//  CustomClass+CustomCategory.m
//  Swizzling
//
//  Created by Siya9 on 21/06/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "CustomClass+CustomCategory.h"
#include <objc/runtime.h>

@implementation CustomClass (CustomCategory)
-(void) newMethod {
    [self newMethod];
    NSLog(@"I'm the new method");
}
-(void) originalMethod {
    NSLog(@"I'm the original cat method");
}






























































+(void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(originalMethod);
        SEL swizzledSelector = @selector(newMethod);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}
@end
