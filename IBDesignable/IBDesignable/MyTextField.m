//
//  MyTextField.m
//  IBDesignable
//
//  Created by Siya9 on 16/11/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "MyTextField.h"
IB_DESIGNABLE
@implementation MyTextField

@synthesize lpadding,rpadding;

-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, lpadding, 0);
}
- (CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    CGRect originalRect = [super clearButtonRectForBounds:bounds];
    return CGRectOffset(originalRect, 8 - rpadding, 0);
//    return CGRectMake(bounds.size.width - padding, bounds.origin.y, bounds.size.width, bounds.size.height);
}
-(CGRect)editingRectForBounds:(CGRect)bounds{
    return [self textRectForBounds:bounds];
}
-(void)setColor:(UIColor *)color{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 5;
}
@end
