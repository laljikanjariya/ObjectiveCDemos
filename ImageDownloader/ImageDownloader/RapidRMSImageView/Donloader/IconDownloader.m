/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Helper object for managing the downloading of a particular app's icon.
  It uses NSURLSession/NSURLSessionDataTask to download the app's icon in the background if it does not
  yet exist and works in conjunction with the RootViewController to manage which apps need their icon.
 */

#import "IconDownloader.h"
#import "AppDelegate.h"

#define kAppIconSize 48


@interface IconDownloader ()

@property (nonatomic, strong) NSURLSessionDataTask *sessionTask;

@end


#pragma mark -

@implementation IconDownloader

// -------------------------------------------------------------------------------
//	startDownload
// -------------------------------------------------------------------------------
+(BOOL)startDownloadToFile:(FileInfo *)objFile withCompletionHandler:(completionHandler)completionHandler {
    IconDownloader * downloadr = [[IconDownloader alloc]init];
    downloadr.fileInfo = objFile;
    downloadr.completionHandler = completionHandler;
    
    [downloadr startDownload];
    return TRUE;
}
- (void)startDownload
{
    [self.fileInfo.indView setIndicatorStatus:ACPDownloadStatusRunning];
    [self.fileInfo.indView setProgress:0.1f animated:TRUE];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.fileInfo.imageURLString]];

    // create an session data task to obtain and download the app icon
    _sessionTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // in case we want to know the response status code
        //NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];

        if (error != nil)
        {
            if ([error code] == NSURLErrorAppTransportSecurityRequiresSecureConnection)
            {
                // if you get error NSURLErrorAppTransportSecurityRequiresSecureConnection (-1022),
                // then your Info.plist has not been properly configured to match the target server.
                //
                abort();
            }
        }
                                                       
             
        [self.fileInfo.indView setProgress:1.0f animated:TRUE];
        [data writeToFile:[self.fileInfo.storePath stringByReplacingOccurrencesOfString:Prifix withString:@""] atomically:YES];
                                                       
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
            if (self.completionHandler) {
                self.completionHandler(self.fileInfo);
            }
            
            // Set appIcon and clear temporary data/image
//            UIImage *image = [[UIImage alloc] initWithData:data];
//            
//            if (image.size.width != kAppIconSize || image.size.height != kAppIconSize)
//            {
//                CGSize itemSize = CGSizeMake(kAppIconSize, kAppIconSize);
//                UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0f);
//                CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
//                [image drawInRect:imageRect];
//                self.appRecord.appIcon = UIGraphicsGetImageFromCurrentImageContext();
//                UIGraphicsEndImageContext();
//            }
//            else
//            {
//                self.appRecord.appIcon = image;
//            }
            
            // call our completion handler to tell our client that our icon is ready for display
//            if (self.completionHandler != nil)
//            {
//                self.completionHandler();
//            }
        }];
    }];
    
    [self.sessionTask resume];
}

// -------------------------------------------------------------------------------
//	cancelDownload
// -------------------------------------------------------------------------------
- (void)cancelDownload
{
    [self.sessionTask cancel];
    _sessionTask = nil;
}

@end

