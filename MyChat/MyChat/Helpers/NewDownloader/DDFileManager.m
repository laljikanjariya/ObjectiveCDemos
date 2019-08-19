//
//  DDFileManager.m
//  MyChat
//
//  Created by Siya9 on 29/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "DDFileManager.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@implementation DDFileManager 

+ (instancetype)sharedInstance
{
    static DDFileManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DDFileManager alloc] init];
        sharedInstance.arrDownloadList = [[NSMutableArray alloc]init];

        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.BGTransferDemo"];
        sessionConfiguration.HTTPMaximumConnectionsPerHost = 5;
        
        sharedInstance.session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                     delegate:sharedInstance
                                                delegateQueue:nil];
        
        [DDFileManager addDefaultFolders];
    });
    return sharedInstance;
}
+(void)addDefaultFolders{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSString * profileImages = [NSString stringWithFormat:@"%@/Documents/MyChatMedia/ProfileImages",NSHomeDirectory()];
    if (![fileManager fileExistsAtPath:profileImages isDirectory:nil]) {
        [fileManager createDirectoryAtPath:profileImages withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
    
    NSString * messageImages = [NSString stringWithFormat:@"%@/Documents/MyChatMedia/MessageImages",NSHomeDirectory()];
    if (![fileManager fileExistsAtPath:messageImages isDirectory:nil]) {
        [fileManager createDirectoryAtPath:messageImages withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
    
    NSString * messageVideo = [NSString stringWithFormat:@"%@/Documents/MyChatMedia/MessageVideo",NSHomeDirectory()];
    if (![fileManager fileExistsAtPath:messageVideo isDirectory:nil]) {
        [fileManager createDirectoryAtPath:messageVideo withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
    
    NSString * messageAudio = [NSString stringWithFormat:@"%@/Documents/MyChatMedia/MessageAudio",NSHomeDirectory()];
    if (![fileManager fileExistsAtPath:messageAudio isDirectory:nil]) {
        [fileManager createDirectoryAtPath:messageAudio withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
}
#pragma mark - Add to Download -

+ (DDFileInfo *)addToDownloadUserImageWithUrl:(NSString *)strUrl{
    return [DDFileManager addFileWithUrl:strUrl storePath:[NSString stringWithFormat:@"%@/Documents/MyChatMedia/ProfileImages/%@",NSHomeDirectory(),strUrl.lastPathComponent]];
}
+ (DDFileInfo *)addToDownloadUserMessageImageWithUrl:(NSString *)strUrl {
    return nil;
}
+(BOOL)isAddedIntoDownloadList:(NSString *)strUrl {
    return FALSE;
}

+(DDFileInfo *)addFileWithUrl:(NSString *)strUrl storePath:(NSString *)storePath{
    if ([NSURL URLWithString:strUrl] == nil) {
        return nil;
    }
    DDFileManager *sharedInstance = [DDFileManager sharedInstance];
    if (![DDFileManager isAddedIntoDownloadList:strUrl]) {
        DDFileInfo * fileInfo = [[DDFileInfo alloc]init];
        fileInfo.URL = [NSURL URLWithString:strUrl];
        fileInfo.strName = [fileInfo.URL lastPathComponent];
        fileInfo.strStoreTO = storePath;
        fileInfo.taskIdentifier = -1;
        [sharedInstance.arrDownloadList addObject:fileInfo];
        return fileInfo;
    }
    else{
//        return [DDFileManager getAddedIntoDownloadList:strUrl];
    }
    return nil;
}

#pragma mark - session manager -
+(void)startDownloadForFile:(DDFileInfo *)objFile{
    [[DDFileManager sharedInstance] startOrRusumeDownloadingSingleFile:objFile];
}
+(void)pushDownloadForFile:(DDFileInfo *)objFile{
    [[DDFileManager sharedInstance] pushDownloadingSingleFile:objFile];
}
- (void)startOrRusumeDownloadingSingleFile:(DDFileInfo *) objFile {
    
    if (!objFile.isDownloading) {
        // This is the case where a download task should be started.
        
        // Create a new task, but check whether it should be created using a URL or resume data.
        if (objFile.taskIdentifier == -1 || objFile.taskResumeData == nil) {
            objFile.downloadTask = [self.session downloadTaskWithURL:objFile.URL];
            objFile.taskIdentifier = objFile.downloadTask.taskIdentifier;
            [objFile.downloadTask resume];
        }
        else{
            // The resume of a download task will be done here.
            objFile.downloadTask = [self.session downloadTaskWithResumeData:objFile.taskResumeData];
            [objFile.downloadTask resume];
            
            // Keep the new download task identifier.
            objFile.taskIdentifier = objFile.downloadTask.taskIdentifier;
        }
    }
    objFile.isDownloading = TRUE;
}
- (void)pushDownloadingSingleFile:(DDFileInfo *) objFile {

    objFile.isDownloading = FALSE;
    [objFile.downloadTask cancelByProducingResumeData:^(NSData *resumeData) {
        if (resumeData != nil) {
            objFile.taskResumeData = [[NSData alloc] initWithData:resumeData];
        }
    }];
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    if (totalBytesExpectedToWrite == NSURLSessionTransferSizeUnknown) {
        NSLog(@"Unknown transfer size");
    }
    else{
        // Locate the FileDownloadInfo object among all based on the taskIdentifier property of the task.

        DDFileInfo *fdi = [self getFileInfoFromTaskId:downloadTask.taskIdentifier];
        if (fdi.progressHandler) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                // Calculate the progress.
                fdi.downloadProgress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
                fdi.progressHandler(fdi.downloadProgress);
            }];
        }
    }
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)downloadURL {
    DDFileInfo *fdi = [self getFileInfoFromTaskId:downloadTask.taskIdentifier];
    [self moveFileFrom:downloadURL.absoluteString toDestination:fdi.strStoreTO isReplace:TRUE];
}
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (error != nil) {
        NSLog(@"Download completed with error: %@", [error localizedDescription]);
    }
    DDFileInfo *fdi = [self getFileInfoFromTaskId:task.taskIdentifier];
    [fdi sendComplitationNotificationWithError:error];
}

-(void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    // Check if all download tasks have been finished.
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
                    localNotification.alertTitle = @"MyChat";
                    localNotification.alertBody = @"All files have been downloaded!";

                    [UIApplication sharedApplication].applicationIconBadgeNumber = 2;
                    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
                }];
            }
        }
    }];
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

-(DDFileInfo *)getFileInfoFromTaskId:(unsigned long)taskIdentifier{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"self.taskIdentifier == %lu",taskIdentifier];
    return [[[DDFileManager sharedInstance].arrDownloadList filteredArrayUsingPredicate:predicate] firstObject];
}



@end


@implementation DDFileInfo
-(void)addNewResponce:(id)responce withComplication:(CompletionHandler)completionHandler {
    if (responce) {
        if (!self.responce) {
            self.responce = [[NSArray alloc]init];
        }
        if (!self.completionHandler) {
            self.completionHandler = [[NSArray alloc]init];
        }
        if (![self.responce containsObject:responce]) {
            NSMutableArray * arrResponce = self.responce.mutableCopy;
            [arrResponce addObject:responce];
            self.responce = [[NSArray alloc]initWithArray:arrResponce];
            
            NSMutableArray * arrCom = self.completionHandler.mutableCopy;
            [arrCom addObject:completionHandler];
            self.completionHandler = [[NSArray alloc]initWithArray:arrCom];
        }
    }
}

-(void)sendComplitationNotificationWithError:(NSError *)error{
    for (int i = 0; i < self.responce.count; i++) {
        id responce = self.responce[i];
        CompletionHandler completionHandler = self.completionHandler[i];
        completionHandler(responce,error);
    }
    
}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@ isDownloading",self.strName];
}
@end