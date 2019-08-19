//
//  PopupSuperVC.m
//  RapidRMS
//
//  Created by Siya9 on 08/06/16.
//  Copyright © 2016 Siya Infotech. All rights reserved.
//

#import "PopupSuperVC.h"

@interface PopupSuperVC ()<UIGestureRecognizerDelegate,UIPopoverPresentationControllerDelegate>

@end

@implementation PopupSuperVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIViewController * testVC = [[UIViewController alloc]init];
        testVC.modalPresentationStyle = UIModalPresentationCustom;
        [viewConteroler presentViewController:testVC animated:YES completion:nil];
        testVC.view.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.200];
        CGRect frame = self.view.frame;
        self.view.frame = frame;
        [testVC.view addSubview:self.view];
        [testVC addChildViewController:self];
        self.view.center = testVC.view.center;
        [self setGestureRecognizer:testVC];
    }
    else{
        self.modalPresentationStyle = UIModalPresentationPopover;
        
        CGRect frame = self.view.frame;
        self.preferredContentSize = frame.size;
        [viewConteroler presentViewController:self animated:YES completion:nil];
        
        UIPopoverPresentationController * popup =self.popoverPresentationController;
        
        popup.permittedArrowDirections = (UIPopoverArrowDirection)NULL;
        popup.sourceView = self.view;
        popup.delegate = self;
        
        popup.sourceRect = [self getCenterFrameView:viewConteroler.view];
    }
    self.view.layer.borderColor = [UIColor whiteColor].CGColor;
    self.view.layer.borderWidth = 1.0f;
    self.view.layer.cornerRadius = 10.0f;
    self.view.clipsToBounds = TRUE;
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
    
    popup.delegate = self;
    
    popup.backgroundColor = [UIColor colorWithRed:0.086 green:0.075 blue:0.141 alpha:1.000];
    self.view.layer.borderColor = [UIColor whiteColor].CGColor;
    self.view.layer.borderWidth = 1.0f;
    self.view.layer.cornerRadius = 10.0f;
    self.view.clipsToBounds = TRUE;
}

-(void)presentViewControllerForviewConteroller:(UIViewController *) objView sourceView:(UIView *)sourceView ArrowDirection:(UIPopoverArrowDirection)arrowDirection {
    
    [self presentViewControllerForviewConteroller:objView sourceView:sourceView ArrowDirection:arrowDirection InputViews:nil];
}
-(void)presentViewControllerForviewConteroller:(UIViewController *) objView sourceView:(UIView *)sourceView ArrowDirection:(UIPopoverArrowDirection)arrowDirection InputViews:(NSArray<UIView *> *)passthroughViews {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIViewController * presentedHelperVC = [[UIViewController alloc]init];
        presentedHelperVC.modalPresentationStyle = UIModalPresentationCustom;
        [objView presentViewController:presentedHelperVC animated:YES completion:nil];
        presentedHelperVC.view.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.200];
        CGRect frame = self.view.frame;
        self.view.frame = frame;
        [presentedHelperVC.view addSubview:self.view];
        [presentedHelperVC addChildViewController:self];
        self.view.center = presentedHelperVC.view.center;
        [self setGestureRecognizer:presentedHelperVC];
    }
    else{
        if (CGSizeEqualToSize(CGSizeZero, self.sizePreferredContentSize)) {
            self.sizePreferredContentSize = self.view.frame.size;
        }
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.preferredContentSize = self.sizePreferredContentSize;
        [objView presentViewController:self animated:YES completion:nil];
        
        UIPopoverPresentationController * popup =self.popoverPresentationController;
        popup.delegate = self;
        if (self.colorArrowDirection) {
            popup.backgroundColor = self.colorArrowDirection;
        }
        else{
            popup.backgroundColor = [UIColor colorWithRed:0.086 green:0.075 blue:0.141 alpha:1.000];
        }
        if (sourceView) {
            popup.permittedArrowDirections = arrowDirection;
            popup.sourceView = sourceView;
            popup.sourceRect = sourceView.bounds;
        }
        else{
            popup.permittedArrowDirections = (UIPopoverArrowDirection)NULL;
            popup.sourceView = self.view;
            popup.delegate = self;
            popup.sourceRect = [self getCenterFrameView:objView.view];
        }
        popup.passthroughViews = passthroughViews;
        if (self.isHideArrow) {
            popup.popoverBackgroundViewClass = [CustomPopoverBackgroundView class];
        }
        else {
            popup.popoverBackgroundViewClass = nil;
        }
    }
    if (!self.isHideBorder) {
        if (!self.colorBorder) {
            self.colorBorder = [UIColor whiteColor];
        }
        self.view.layer.borderColor = self.colorBorder.CGColor;
        self.view.layer.borderWidth = 1.0f;
    }
    self.view.layer.cornerRadius = 10.0f;
    self.view.clipsToBounds = TRUE;
}

#pragma mark - Iphone -

-(void)setGestureRecognizer:(UIViewController *)objView{
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePopupIphoneView)];
    [tapRecognizer setNumberOfTapsRequired:1];
    [tapRecognizer setDelegate:self];
    
    [objView.view addGestureRecognizer:tapRecognizer];
    
}

-(void)hidePopupIphoneView{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
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