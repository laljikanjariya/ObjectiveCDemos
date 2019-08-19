//
//  ViewController.m
//  FaceBookSDKTest
//
//  Created by Siya9 on 07/07/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "FBCommentVC.h"
#import "FBLoginVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showFacebookProfile:(id)sender{
     FBLoginVC* asd = [FBLoginVC getViewFromStoryBoard];
    asd.isHideArrow = TRUE;
    [asd presentViewControllerForviewConteroller:self sourceView:sender ArrowDirection:UIPopoverArrowDirectionUp];
    asd.FBLoginVCPostblock =^(UIViewController * popUpVC){
        [self dismissViewControllerAnimated:YES completion:^{
            FBCommentVC * asd = [FBCommentVC getViewFromStoryBoard];
            asd.colorArrowDirection = [UIColor redColor];
            [asd presentViewControllerForviewConteroller:self sourceView:sender ArrowDirection:UIPopoverArrowDirectionUp];
        }];
    };
}
@end
