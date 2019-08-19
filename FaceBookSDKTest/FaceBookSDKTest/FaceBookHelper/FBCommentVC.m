//
//  FBCommentVC.m
//  FaceBookSDKTest
//
//  Created by Siya9 on 07/07/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "FBCommentVC.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface FBCommentVC ()

@end

@implementation FBCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
//    content.contentURL = [NSURL
//                          URLWithString:@"https://www.facebook.com/FacebookDevelopers"];
//    FBSDKShareButton *shareButton = [[FBSDKShareButton alloc] init];
//    shareButton.shareContent = content;
//    shareButton.center = self.view.center;
//    [self.view addSubview:shareButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)postIntoFaceBook:(id)sender {

}



+(instancetype)getViewFromStoryBoard{
    return (FBCommentVC *)[[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"FBCommentVC_sid"];
}
@end
