//
//  SessionManager.m
//  MyChat
//
//  Created by Siya9 on 19/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "SessionManager.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface SessionManager ()<NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, weak) FileInfo * fileInfo;

@end
@implementation SessionManager
+(instancetype)downloadDataFrom:(FileInfo *)objFile withQueuw:(NSOperationQueue *) objQueue{
    SessionManager * newSession = [[SessionManager alloc]init];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    newSession.session  = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:newSession delegateQueue:objQueue];
    NSURLRequest * req = [[NSURLRequest alloc]initWithURL:objFile.URL];

    objFile.downloadTask = [newSession.session downloadTaskWithRequest:req];
    [objFile.downloadTask resume];
    objFile.isDownloading = TRUE;
    objFile.taskIdentifier = objFile.downloadTask.taskIdentifier;
    newSession.fileInfo = objFile;
    return newSession;
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    double progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;

    if (self.fileInfo.progressHandler != nil && [downloadTask.currentRequest.URL isEqual:self.fileInfo.URL]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.fileInfo.progressHandler(progress);
        });
    }
    else{
//        NSLog(@"DownloadTask:nill");
    }
    
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)downloadURL {
    [self moveFileFrom:downloadURL.absoluteString toDestination:self.fileInfo.strStoreTO isReplace:TRUE];
}

-(void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    //     Check if all download tasks have been finished.
    [self.session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        if ([downloadTasks count] == 0) {
            if (appDelegate.backgroundTransferCompletionHandler != nil) {
                // Copy locally the completion handler.
                void(^completionHandler)() = appDelegate.backgroundTransferCompletionHandler;
                
                // Make nil the backgroundTransferCompletionHandler.
                appDelegate.backgroundTransferCompletionHandler = nil;
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    // Call the completion handler to tell the system that there are no other background transfers.
                    completionHandler();
                    
                    // Show a local notification when all downloads are over.
                    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
                    localNotification.alertBody = @"All files have been downloaded!";
                    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
                }];
            }
        }
    }];
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (error != nil) {
        NSLog(@"Download completed with error: %@", [error localizedDescription]);
    }
    self.sessionCompletionHandler(self.fileInfo,self.session,error);
}


-(void)moveFileFrom:(NSString *)strFrom toDestination:(NSString *)strTo isReplace:(BOOL)isReplace{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (isReplace && [fileManager fileExistsAtPath:strTo]) {
        [fileManager removeItemAtPath:strTo error:nil];
    }
    NSData * fileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:strFrom]];
    if ([strTo.pathExtension.lowercaseString isEqualToString:@"jpg"] || [strTo.pathExtension.lowercaseString isEqualToString:@"jpeg"] || [strTo.pathExtension.lowercaseString isEqualToString:@"png"]) {
        UIImage * imaData = [UIImage imageWithData:fileData];
        fileData = nil;
        
        float oldWidth = imaData.size.width;
        float scaleFactor = 640 / oldWidth;
        
        float newHeight = imaData.size.height * scaleFactor;
        float newWidth = oldWidth * scaleFactor;
        
        
        UIGraphicsBeginImageContext( CGSizeMake(newWidth, newHeight) );
        [imaData drawInRect:CGRectMake(0,0,newWidth,newHeight)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        fileData = UIImagePNGRepresentation(newImage);
    }
    [fileData writeToFile:strTo atomically:TRUE];
    if ([strTo.pathExtension.lowercaseString isEqualToString:@"mp4"]) {
        [self thumbnailFromVideoAtURL:strTo];
    }
}
- (void)thumbnailFromVideoAtURL:(NSString *)contentURL {
    UIImage *theImage = nil;
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:contentURL] options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 60);
    CGImageRef imgRef = [generator copyCGImageAtTime:time actualTime:NULL error:&err];
    
    theImage = [[UIImage alloc] initWithCGImage:imgRef];
    
    NSData * fileData = UIImagePNGRepresentation(theImage);
    NSString * newPath = [contentURL copy];
    newPath = [newPath stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@",newPath.pathExtension] withString:@".jpg"];
    [fileData writeToFile:newPath atomically:TRUE];
}

@end
