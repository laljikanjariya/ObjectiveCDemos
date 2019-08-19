//
//  DDDownloadV.m
//  MyChat
//
//  Created by Siya9 on 30/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "DDDownloadV.h"

@implementation DDDownloadV


-(void)loadImageFrom:(DDFileInfo *) objFile{
    
}


#pragma mark - Create Sub View -
-(UIImageView *)imgView{
    if (!_imgView) {
        [self addTrailing:0 Leading:0 Top:0 Bottom:0 forView:_imgView inSupperView:self];
    }
    return _imgView;
}

-(RMDownloadIndicator *)rmIndicator{
    if (!_rmIndicator) {
        [self addWidth:40 andHeight:40 for:_rmIndicator];
        [self addCenter:_rmIndicator inSupperView:self];
    }
    return _rmIndicator;
}
-(UIButton *)btnAction{
    if (!_btnAction) {
        [self addWidth:40 andHeight:40 for:_btnAction];
        [self addCenter:_btnAction inSupperView:self];
    }
    return _btnAction;
}

#pragma mark - Add Autolayout -

-(void)addTrailing:(float)fltTrailing Leading:(float)fltLeading Top:(float)fltTop Bottom:(float)fltBottom forView:(UIView *)subView inSupperView:(UIView *)parent{
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Trailing
    NSLayoutConstraint *trailing =[NSLayoutConstraint
                                   constraintWithItem:subView
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:parent
                                   attribute:NSLayoutAttributeTrailing
                                   multiplier:1.0f
                                   constant:fltTrailing];
    
    //Leading
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:subView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:parent
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:fltLeading];
    
    //Top
    NSLayoutConstraint *top =[NSLayoutConstraint
                                 constraintWithItem:subView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:parent
                                 attribute:NSLayoutAttributeBottom
                                 multiplier:1.0f
                                 constant:fltTop];
    
    //Bottom
    NSLayoutConstraint *bottom =[NSLayoutConstraint
                                 constraintWithItem:subView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:parent
                                 attribute:NSLayoutAttributeBottom
                                 multiplier:1.0f
                                 constant:fltBottom];
    [parent addConstraints:@[trailing,leading,top,bottom]];
}

-(void)addCenter:(UIView *)subView inSupperView:(UIView *)parent{
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *xCenterConstraint = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];

    NSLayoutConstraint *yCenterConstraint = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    [parent addConstraints:@[xCenterConstraint,yCenterConstraint]];
}

-(void)addWidth:(float)fltWidth andHeight:(float)fltHeight for:(UIView *)objView{
    objView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *width = [NSLayoutConstraint
                                  constraintWithItem:objView
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:0
                                  constant:fltWidth];

    NSLayoutConstraint *height = [NSLayoutConstraint
                                  constraintWithItem:objView
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:0
                                  constant:fltHeight];
    [objView addConstraints:@[width,height]];
}
@end
