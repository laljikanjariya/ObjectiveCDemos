//
//  UIButton+Customized.m
//  UIButton
//
//  Created by Siya9 on 28/10/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "UIButton+Customized.h"

@implementation UIButton (Customized)
-(void)setTextLeftImageRightWithMargin:(NSNumber *)textLeftImageRightWithMargin {
    self.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    NSString *buttonTitle = self.titleLabel.text;
    CGSize titleSize = [buttonTitle sizeWithAttributes:@{ NSFontAttributeName : self.titleLabel.font }];
    UIImage *buttonImage = self.imageView.image;
    CGSize buttonImageSize = buttonImage.size;
    
    CGFloat spacing = self.bounds.size.width - titleSize.width - buttonImageSize.width - textLeftImageRightWithMargin.floatValue;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, textLeftImageRightWithMargin.floatValue, 0, spacing);
}
@end
