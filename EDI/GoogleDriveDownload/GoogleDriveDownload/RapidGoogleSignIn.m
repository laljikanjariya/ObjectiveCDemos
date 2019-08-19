//
//  RapidGoogleSignIn.m
//  GoogleDriveDownload
//
//  Created by Siya-ios5 on 9/29/17.
//  Copyright © 2017 Siya-ios5. All rights reserved.
//

#import "RapidGoogleSignIn.h"
#import "GoogleDriveFile.h"
#import "RapidGoogleDriveOperation.h"


@interface RapidGoogleSignIn()<GIDSignInDelegate, GIDSignInUIDelegate> {
    SinginResponce singinResponce;
}

@end

@implementation RapidGoogleSignIn


-(instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [[GTLRDriveService alloc] init];
    }
    return self;
}
- (void)signIn:(SinginResponce)responce withUIDelegate:(id)uiDelegate{
    singinResponce = responce;
    GIDSignIn* signIn = [GIDSignIn sharedInstance];
    signIn.delegate = self;
    signIn.uiDelegate = uiDelegate;
    signIn.scopes = [NSArray arrayWithObjects:kGTLRAuthScopeDriveReadonly, nil];
    [signIn signInSilently];
}
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    if (error != nil) {
        self.service.authorizer = nil;
        singinResponce(FALSE,user,error);
    } else {
        self.service.authorizer = user.authentication.fetcherAuthorizer;
        singinResponce(TRUE,user,error);
    }
}
- (void)googleDriveFiles:(GoogleDriveFilesRespoce)responce{
}

@end
