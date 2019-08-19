//
//  CustomClass.m
//  Swizzling
//
//  Created by Siya9 on 21/06/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "CustomClass.h"

@implementation CustomClass
-(id) init {
    self = [super init];
    return self;
}

-(void) originalMethod {
    NSLog(@"I'm the original method");
}
-(void) newMethod {
    [self newMethod];
    NSLog(@"I'm the new class method");
}
@end
