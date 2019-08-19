/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Helper object for managing the downloading of a particular app's icon.
  It uses NSURLSession/NSURLSessionDataTask to download the app's icon in the background if it does not
  yet exist and works in conjunction with the RootViewController to manage which apps need their icon.
 */

#import <UIKit/UIKit.h>
#import "RapidImage.h"

@interface IconDownloader : NSObject

@property (nonatomic, strong) FileInfo * fileInfo;
@property (nonatomic, copy) void (^completionHandler)(FileInfo * objFile);

+(BOOL)startDownloadToFile:(FileInfo *)objFile withCompletionHandler:(completionHandler)completionHandler;
- (void)startDownload;
- (void)cancelDownload;

@end
