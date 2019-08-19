//
//  test01.m
//  UIButtonImageText
//
//  Created by Siya9 on 14/05/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "test01.h"

@implementation test01
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 40, 78, 22);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, 78, 40);
}
@end
