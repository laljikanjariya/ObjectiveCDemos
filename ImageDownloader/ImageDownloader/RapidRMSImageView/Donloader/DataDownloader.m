//
//  DataDownloader.m
//  ImageDownloader
//
//  Created by Siya9 on 18/11/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "DataDownloader.h"
#import "AppDelegate.h"

@implementation DataDownloader


+(BOOL)startDownloadToFile:(FileInfo *)objFile withCompletionHandler:(completionHandler)completionHandler {
    DataDownloader * downloadr = [[DataDownloader alloc]init];
    downloadr.fileInfo = objFile;
    downloadr.completionHandler = completionHandler;
    downloadr.session = [NSURLSession sharedSession];
    
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.BGTransferDemo"];
    sessionConfiguration.HTTPMaximumConnectionsPerHost = 5;
    
    downloadr.session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                           delegate:downloadr
                                                      delegateQueue:nil];

    
    [downloadr startDownload];
    return TRUE;
}
-(void)startDownload{
    NSURLSessionDownloadTask * ddt = [self.session downloadTaskWithURL:[NSURL URLWithString:self.fileInfo.imageURLString]];
    [ddt resume];
}
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    if (totalBytesExpectedToWrite == NSURLSessionTransferSizeUnknown) {
        NSLog(@"Unknown transfer size");
    }
    else{
        // Locate the FileDownloadInfo object among all based on the taskIdentifier property of the task.
        
//        DDFileInfo *fdi = [self getFileInfoFromTaskId:downloadTask.taskIdentifier];
//        if (fdi.progressHandler) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                // Calculate the progress.
                double downloadProgress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
                [self.fileInfo.indView setIndicatorStatus:ACPDownloadStatusRunning];
                [self.fileInfo.indView setProgress:downloadProgress animated:TRUE];
            }];
//        }
    }
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)downloadURL {
    
//    [self.fileInfo.indView setProgress:1.0f animated:TRUE];
//    [data writeToFile:[self.fileInfo.storePath stringByReplacingOccurrencesOfString:Prifix withString:@""] atomically:YES];
//    
//    [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
//        if (self.completionHandler) {
//            self.completionHandler(self.fileInfo);
//        }
//        
//    DDFileInfo *fdi = [self getFileInfoFromTaskId:downloadTask.taskIdentifier];
    [self moveFileFrom:downloadURL.absoluteString toDestination:self.fileInfo.storePath isReplace:TRUE];
}
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (error != nil) {
        NSLog(@"Download completed with error: %@", [error localizedDescription]);
    }
//    DDFileInfo *fdi = [self getFileInfoFromTaskId:task.taskIdentifier];
//    [fdi sendComplitationNotificationWithError:error];
}

//-(void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session{
//    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//    
//    // Check if all download tasks have been finished.
//    [self.session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
//        if ([downloadTasks count] == 0) {
//            if (appDelegate.backgroundTransferCompletionHandler != nil) {
//                // Copy locally the completion handler.
//                void(^completionHandler)() = appDelegate.backgroundTransferCompletionHandler;
//                
//                // Make nil the backgroundTransferCompletionHandler.
//                appDelegate.backgroundTransferCompletionHandler = nil;
//                
//                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                    // Call the completion handler to tell the system that there are no other background transfers.
//                    completionHandler();
//                    
//                    // Show a local notification when all downloads are over.
//                    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//                    localNotification.alertTitle = @"MyChat";
//                    localNotification.alertBody = @"All files have been downloaded!";
//                    
//                    [UIApplication sharedApplication].applicationIconBadgeNumber = 2;
//                    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
//                }];
//            }
//        }
//    }];
//}

     -(void)moveFileFrom:(NSString *)strFrom toDestination:(NSString *)strTo isReplace:(BOOL)isReplace{
//         NSFileManager * fileManager = [NSFileManager defaultManager];
//         if (isReplace && [fileManager fileExistsAtPath:strTo]) {
//             [fileManager removeItemAtPath:strTo error:nil];
//         }
         NSData * fileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:strFrom]];
         [self.fileInfo.indView setProgress:1.0f animated:TRUE];
         [fileData writeToFile:[self.fileInfo.storePath stringByReplacingOccurrencesOfString:Prifix withString:@""] atomically:YES];
//         if ([strTo.pathExtension.lowercaseString isEqualToString:@"jpg"] || [strTo.pathExtension.lowercaseString isEqualToString:@"jpeg"] || [strTo.pathExtension.lowercaseString isEqualToString:@"png"]) {
//             UIImage * imaData = [UIImage imageWithData:fileData];
//             fileData = nil;
//             
//             float oldWidth = imaData.size.width;
//             float scaleFactor = 640 / oldWidth;
//             
//             float newHeight = imaData.size.height * scaleFactor;
//             float newWidth = oldWidth * scaleFactor;
//             
//             
//             UIGraphicsBeginImageContext( CGSizeMake(newWidth, newHeight) );
//             [imaData drawInRect:CGRectMake(0,0,newWidth,newHeight)];
//             UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//             UIGraphicsEndImageContext();
//             fileData = UIImagePNGRepresentation(newImage);
//         }
//         [fileData writeToFile:strTo atomically:TRUE];
//         if ([strTo.pathExtension.lowercaseString isEqualToString:@"mp4"]) {
//             [self thumbnailFromVideoAtURL:strTo];
//         }
     }
     
@end
