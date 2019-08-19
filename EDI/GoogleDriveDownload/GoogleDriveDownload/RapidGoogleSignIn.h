//
//  RapidGoogleSignIn.h
//  GoogleDriveDownload
//
//  Created by Siya-ios5 on 9/29/17.
//  Copyright © 2017 Siya-ios5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GTLRDrive.h>
#import <Google/SignIn.h>
#import "GTMSessionFetcher.h"
#import "GoogleDriveFile.h"

typedef  void(^SinginResponce)(bool isSignIn, GIDGoogleUser * user, NSError * error);
typedef void (^GoogleDriveFilesRespoce)(NSError *error, NSMutableArray <GoogleDriveFile *>*files);

@interface RapidGoogleSignIn : NSObject

@property (nonatomic, strong) GTLRDriveService *service;

- (void)signIn:(SinginResponce)responce withUIDelegate:(id)uiDelegate;
- (void)googleDriveFiles:(GoogleDriveFilesRespoce)responce;
@end
