//
//  UIButton+UIButtonImage.m
//  UIButtonImageText
//
//  Created by Siya9 on 14/05/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "UIButton+UIButtonImage.h"

@implementation UIButton (UIButtonImage)


- (NSString *)fontName {
    return self.titleLabel.font.fontName;
}

- (void)setFontName:(NSString *)fontName {
    self.titleLabel.font = [UIFont fontWithName:fontName size:self.titleLabel.font.pointSize];
}

- (NSNumber *)imageHeightPre{
    return @(self.titleEdgeInsets.top);
}
- (void)setImageHeightPre:(NSNumber *)numPer {

    
    self.imageEdgeInsets = UIEdgeInsetsMake(5, 0,0,0);
    if (self.titleLabel.text.length >10) {
        self.titleEdgeInsets = UIEdgeInsetsMake(0,0,0,0);
    }
    else {
        self.titleEdgeInsets = UIEdgeInsetsMake(-5,0,0,0);
    }
    
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
//    self.titleLabel.backgroundColor = [UIColor redColor];
//    self.imageView.backgroundColor = [UIColor colorWithRed:0.000 green:0.762 blue:0.000 alpha:1.000];
}
@end
