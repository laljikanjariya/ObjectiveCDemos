//
//  PopupSuperVC.m
//  RapidRMS
//
//  Created by Siya9 on 08/06/16.
//  Copyright © 2016 Siya Infotech. All rights reserved.
//

#import "PopupSuperVC.h"
#import "AppDelegate.h"

@interface PopupSuperVC ()<UIGestureRecognizerDelegate,UIPopoverPresentationControllerDelegate> {
    UIViewController * heplerVCiPhone;
    UIColor * bgColor;
    UIView * sourceInputView;
    UIImageView *imgTempBGPopup;
}

@end

@implementation PopupSuperVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    imgTempBGPopup = [[UIImageView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGRect)getCenterFrameView:(UIView *)bgView{
    
    CGRect frame = self.view.bounds;
    frame.origin.x = (bgView.bounds.size.width - frame.size.width)/2;
    frame.origin.y = (bgView.bounds.size.height - frame.size.height)/2;
    
    //    frame.origin.y = frame.origin.y - 50;
    return frame;
}

-(void)presentViewControllerForViewController:(UIViewController *)viewConteroler{
    
        self.modalPresentationStyle = UIModalPresentationPopover;
        
        CGRect frame = self.view.frame;
        self.preferredContentSize = frame.size;
        [viewConteroler presentViewController:self animated:YES completion:nil];
        
        UIPopoverPresentationController * popup =self.popoverPresentationController;
        
        popup.permittedArrowDirections = (UIPopoverArrowDirection)NULL;
        popup.sourceView = self.view;
        popup.delegate = self;
        
        popup.sourceRect = [self getCenterFrameView:viewConteroler.view];
        [self addTempViewAndSetBackgroundColor:nil];
}

-(void)presentViewControllerForViewController:(UIViewController *)viewConteroler forSourceView:(UIView *)view{
    
    self.modalPresentationStyle = UIModalPresentationPopover;
    
    CGRect frame = self.view.frame;
    frame.size.width = 150;
    frame.size.height = 200;
    
    self.preferredContentSize = frame.size;
    [viewConteroler presentViewController:self animated:YES completion:nil];
    
    UIPopoverPresentationController * popup =self.popoverPresentationController;
    
    popup.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popup.sourceView = view;
     [self addTempViewAndSetBackgroundColor:view];
    popup.delegate = self;
    
    popup.backgroundColor = [UIColor colorWithRed:0.086 green:0.075 blue:0.141 alpha:1.000];
}

-(void)presentViewControllerForviewConteroller:(UIViewController *) objView sourceView:(UIView *)sourceView ArrowDirection:(UIPopoverArrowDirection)arrowDirection {
    
    [self presentViewControllerForviewConteroller:objView sourceView:sourceView ArrowDirection:arrowDirection InputViews:nil];
}
-(void)presentViewControllerForviewConteroller:(UIViewController *) objView sourceView:(UIView *)sourceView ArrowDirection:(UIPopoverArrowDirection)arrowDirection InputViews:(NSArray<UIView *> *)passthroughViews {
    
        [self iPadBasicPVCSetting:objView];
        UIPopoverPresentationController * popup =self.popoverPresentationController;
        popup.delegate = self;
        [self iPadColorPVCSetting:popup];
        if (sourceView) {
            [self iPadSourceViewPVCSetting:popup sourceView:sourceView ArrowDirection:arrowDirection];
        }
        else{
            [self iPadAtPositionPVCSetting:popup atPostion:[self getCenterFrameView:objView.view]];
        }
        popup.canOverlapSourceViewRect = TRUE;
        popup.passthroughViews = passthroughViews;
        [self iPadBackgroundViewClassPVCSetting:popup];
        [self addTempViewAndSetBackgroundColor:sourceView];
}
- (void)popoverPresentationController:(UIPopoverPresentationController *)popoverPresentationController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView  * __nonnull * __nonnull)view {
    NSLog(@"%@",NSStringFromClass([self class]));
}
-(void)addTempViewAndSetBackgroundColor:(UIView *)sourceView{
    [self removeTemp];
    [imgTempBGPopup setBackgroundColor:[UIColor grayColor]];
    [imgTempBGPopup setAlpha:0.75];
    [imgTempBGPopup setFrame:[UIApplication sharedApplication].delegate.window.rootViewController.view.frame];
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:imgTempBGPopup];
    
    if (sourceView) {
     [[UIApplication sharedApplication].delegate.window.rootViewController.view bringSubviewToFront:sourceView];
    }
}

-(void)removeTemp{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:2.0];
    [imgTempBGPopup removeFromSuperview];
    [UIView commitAnimations];
}

-(void)presentViewControllerForviewConteroller:(UIViewController *) objView sourceView:(UIView *)sourceView InputViews:(NSArray<UIView *> *)passthroughViews atPostion:(CGRect)sourceRect{
    
    [self iPadBasicPVCSetting:objView];
    UIPopoverPresentationController * popup =self.popoverPresentationController;
    popup.delegate = self;
    [self iPadColorPVCSetting:popup];
    
    [self iPadAtPositionPVCSetting:popup atPostion:sourceRect];
    
    popup.passthroughViews = passthroughViews;
    [self iPadBackgroundViewClassPVCSetting:popup];
    sourceInputView = sourceView;
    bgColor = sourceView.backgroundColor;
    sourceInputView.backgroundColor = [UIColor yellowColor];
}

-(void)presentVCForRightSide:(UIViewController *)objView WithInputView:(UIView *)sourceView {
    CGRect sourceRect;
    
        if (CGSizeEqualToSize(CGSizeZero, self.sizePreferredContentSize)) {
            self.sizePreferredContentSize = self.view.frame.size;
        }
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
        sourceRect.origin.x = screenRect.size.width - self.sizePreferredContentSize.width - 20;
        sourceRect.origin.y = (screenRect.size.height - self.sizePreferredContentSize.height)/2;
        
        sourceRect.size = self.sizePreferredContentSize;
        [self presentViewControllerForviewConteroller:objView sourceView:sourceView InputViews:nil atPostion:sourceRect];
}

-(void)iPhonePVCSetting:(UIViewController *) objView{
    heplerVCiPhone = [[UIViewController alloc]init];
    heplerVCiPhone.modalPresentationStyle = UIModalPresentationCustom;
    heplerVCiPhone.view.alpha = 0.0f;
    
    heplerVCiPhone.view.backgroundColor = [UIColor colorWithRed:0.086 green:0.075 blue:0.141 alpha:0.200];
    CGRect frame = self.view.frame;
    self.view.frame = frame;
//    self.view.layer.cornerRadius = 9.0f;
    [self.view.layer setShadowColor:[UIColor colorWithRed:0.086 green:0.075 blue:0.141 alpha:1.000].CGColor];
    [self.view.layer setShadowOpacity:1.0f];
//    [self.view.layer setShadowRadius:9.0];
    [self.view.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    
    [heplerVCiPhone.view addSubview:self.view];
    [heplerVCiPhone addChildViewController:self];
    if (self.isKeybordShow) {
        CGPoint point = heplerVCiPhone.view.center;
        point.y = (heplerVCiPhone.view.bounds.size.height - 216)/2;
        self.view.center = point;
    }
    else{
        self.view.center = heplerVCiPhone.view.center;
    }        [self setGestureRecognizer:heplerVCiPhone];
    [objView presentViewController:heplerVCiPhone animated:false completion:^{
        [UIView animateWithDuration:0.1 animations:^{
            heplerVCiPhone.view.alpha = 1.0f;
        }];
    }];
    
    heplerVCiPhone.popoverPresentationController.delegate = self;
}

-(void)iPadBasicPVCSetting:(UIViewController *) objView {
    if (CGSizeEqualToSize(CGSizeZero, self.sizePreferredContentSize)) {
        self.sizePreferredContentSize = self.view.frame.size;
    }
    self.modalPresentationStyle = UIModalPresentationPopover;
    self.preferredContentSize = self.sizePreferredContentSize;
    [objView presentViewController:self animated:YES completion:nil];
}
-(void)iPadColorPVCSetting:(UIPopoverPresentationController *)popup {
    if (self.colorArrowDirection) {
        popup.backgroundColor = self.colorArrowDirection;
    }
    else{
        popup.backgroundColor = [UIColor colorWithRed:0.086 green:0.075 blue:0.141 alpha:1.000];
    }
}

-(void)iPadSourceViewPVCSetting:(UIPopoverPresentationController *)popup sourceView:(UIView *)sourceView ArrowDirection:(UIPopoverArrowDirection)arrowDirection {
    popup.permittedArrowDirections = arrowDirection;
    popup.sourceView = sourceView;
    popup.sourceRect = sourceView.bounds;
}

-(void)iPadAtPositionPVCSetting:(UIPopoverPresentationController *)popup  atPostion:(CGRect)sourceRect{
    popup.permittedArrowDirections = (UIPopoverArrowDirection)NULL;
    popup.sourceView = self.view;
    popup.sourceRect = sourceRect;
}

-(void)iPadBackgroundViewClassPVCSetting:(UIPopoverPresentationController *)popup {
    if (self.isHideArrow) {
        popup.popoverBackgroundViewClass = [CustomPopoverBackgroundView class];
    }
    else {
        popup.popoverBackgroundViewClass = nil;
    }
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    
        [self removeTemp];
        sourceInputView.backgroundColor = bgColor;
        return TRUE;
}
- (void)popoverPresentationControllerShouldDismissPopover {
    sourceInputView.backgroundColor = bgColor;
    
        [self removeTemp];
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark - Iphone -

-(void)setGestureRecognizer:(UIViewController *)objView{
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePopupIphoneView)];
    [tapRecognizer setNumberOfTapsRequired:1];
    [tapRecognizer setDelegate:self];
    
    [objView.view addGestureRecognizer:tapRecognizer];
    
}

-(void)hidePopupIphoneView{
    [self popoverPresentationControllerShouldDismissPopover];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([touch.view isDescendantOfView:self.view]) {
        return NO; // ignore the touch
    }
    return YES; // handle the touch
}

@end

#define CONTENT_INSET 10.0
#define CAP_INSET 25.0
#define ARROW_BASE 25.0
#define ARROW_HEIGHT -3.0f

@implementation CustomPopoverBackgroundView


-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _borderImageView = [[UIImageView alloc] initWithImage:nil];
        _arrowView = [[UIImageView alloc] initWithImage:nil];
        
        self.layer.shadowColor = [[UIColor clearColor] CGColor];
        [self addSubview:_borderImageView];
        [self addSubview:_arrowView];
    }
    return self;
}
- (CGFloat) arrowOffset {
    return _arrowOffset;
}

- (void) setArrowOffset:(CGFloat)arrowOffset {
    _arrowOffset = arrowOffset;
}

- (UIPopoverArrowDirection)arrowDirection {
    return _arrowDirection;
}

- (void)setArrowDirection:(UIPopoverArrowDirection)arrowDirection {
    _arrowDirection = arrowDirection;
}

+ (BOOL)wantsDefaultContentAppearance{
    return NO;
}

+(UIEdgeInsets)contentViewInsets{
    return UIEdgeInsetsMake(CONTENT_INSET, CONTENT_INSET, CONTENT_INSET, CONTENT_INSET);
}

+(CGFloat)arrowHeight{
    return ARROW_HEIGHT;
}

+(CGFloat)arrowBase{
    return ARROW_BASE;
}
-  (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat _height = self.frame.size.height;
    CGFloat _width = self.frame.size.width;
    CGFloat _left = 0.0;
    CGFloat _top = 0.0;
    CGFloat _coordinate = 0.0;
    CGAffineTransform _rotation = CGAffineTransformIdentity;
    
    switch (self.arrowDirection) {
        case UIPopoverArrowDirectionUp:
            _top += ARROW_HEIGHT;
            _height -= ARROW_HEIGHT;
            _coordinate = ((self.frame.size.width / 2) + self.arrowOffset) - (ARROW_BASE/2);
            _arrowView.frame = CGRectMake(_coordinate, 0, ARROW_BASE, ARROW_HEIGHT);
            break;
            
            
        case UIPopoverArrowDirectionDown:
            _height -= ARROW_HEIGHT;
            _coordinate = ((self.frame.size.width / 2) + self.arrowOffset) - (ARROW_BASE/2);
            _arrowView.frame = CGRectMake(_coordinate, _height, ARROW_BASE, ARROW_HEIGHT);
            _rotation = CGAffineTransformMakeRotation( M_PI );
            break;
            
        case UIPopoverArrowDirectionLeft:
            _left += ARROW_BASE;
            _width -= ARROW_BASE;
            _coordinate = ((self.frame.size.height / 2) + self.arrowOffset) - (ARROW_HEIGHT/2);
            _arrowView.frame = CGRectMake(0, _coordinate, ARROW_BASE, ARROW_HEIGHT);
            _rotation = CGAffineTransformMakeRotation( -M_PI_2 );
            break;
            
        case UIPopoverArrowDirectionRight:
            _width -= ARROW_BASE;
            _coordinate = ((self.frame.size.height / 2) + self.arrowOffset)- (ARROW_HEIGHT/2);
            _arrowView.frame = CGRectMake(_width, _coordinate, ARROW_BASE, ARROW_HEIGHT);
            _rotation = CGAffineTransformMakeRotation( M_PI_2 );
            
            break;
        default:
            break;
    }
    
    _borderImageView.frame =  CGRectMake(_left, _top, _width, _height);
    [_arrowView setTransform:_rotation];
}
@end
