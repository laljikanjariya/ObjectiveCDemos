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

        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.RapidRMS.Downloader"];
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
//+ (DDFileInfo *)addToDownloadUserMessageImageWithUrl:(NSString *)strUrl {
//    return nil;
//}
+(BOOL)isAddedIntoDownloadList:(NSString *)strUrl {
    DDFileInfo * objFile = [DDFileManager getAddedIntoDownloadList:strUrl];
    if (objFile) {
        return TRUE;
    }
    else{
        return FALSE;
    }
}
+(DDFileInfo *)getAddedIntoDownloadList:(NSString *)strUrl {
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"self.URL == %@",[NSURL URLWithString:strUrl]];
    return [[[DDFileManager sharedInstance].arrDownloadList filteredArrayUsingPredicate:predicate] firstObject];
}
+(DDFileInfo *)addFileWithUrl:(NSString *)strUrl storePath:(NSString *)storePath{
    if ([NSURL URLWithString:strUrl] == nil) {
        return nil;
    }
    DDFileManager *sharedInstance = [DDFileManager sharedInstance];
    if (![DDFileManager isAddedIntoDownloadList:strUrl]) {
        DDFileInfo * fileInfo = [[DDFileInfo alloc]init];
        fileInfo.URL = [NSURL URLWithString:strUrl];
        fileInfo.strStoreTO = storePath;
        fileInfo.taskIdentifier = -1;
        [sharedInstance.arrDownloadList addObject:fileInfo];
        return fileInfo;
    }
    else{
        return [DDFileManager getAddedIntoDownloadList:strUrl];
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
    
    if (!(objFile.fileStatus == DDFileDownloadStatusDownloading)) {
        // This is the case where a download task should be started.
        
        // Create a new task, but check whether it should be created using a URL or resume data.
        if ((objFile.taskIdentifier == -1 || objFile.taskResumeData == nil)) {
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
    objFile.fileStatus = DDFileDownloadStatusDownloading;
}
- (void)pushDownloadingSingleFile:(DDFileInfo *) objFile {

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
                fdi.progressHandler(fdi.responce);
//                NSLog(@"Donloaded %f",fdi.downloadProgress*100);
            }];
        }
    }
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)downloadURL {
    DDFileInfo *fdi = [self getFileInfoFromTaskId:downloadTask.taskIdentifier];
    fdi.fileStatus = DDFileDownloadStatusDownloaded;
    [self moveFileFrom:downloadURL.absoluteString toDestination:fdi.strStoreTO isReplace:TRUE];
    [[NSFileManager defaultManager] removeItemAtPath:fdi.strCatchPath error:nil];
}
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (error != nil) {
        NSLog(@"Download completed with error: %@", [error localizedDescription]);
    }
    DDFileInfo *fdi = [self getFileInfoFromTaskId:task.taskIdentifier];
    if (error.code == -999) {
        fdi.fileStatus = DDFileDownloadStatusPush;
    }
    else{
        fdi.fileStatus = DDFileDownloadStatusError;
    }
    [fdi sendComplitationNotificationWithError:error];
    if (!error) {
        [self.arrDownloadList removeObject:fdi];
    }
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
    [fileData writeToFile:strTo atomically:TRUE];
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

-(NSString *)strFileName{
    return self.URL.lastPathComponent;
}
-(NSString *)strCatchPath{
    return [self.strStoreTO stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@",self.strStoreTO.pathExtension] withString:@".data"];
}
-(void)setTaskResumeData:(NSData *)taskResumeData{
    [taskResumeData writeToFile:self.strCatchPath atomically:TRUE];
}
-(NSData *)taskResumeData{
    return [NSData dataWithContentsOfFile:self.strCatchPath];
}
-(void)sendComplitationNotificationWithError:(NSError *)error{
    self.completionHandler(self.responce,error);
}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@ isDownloading",self.strFileName];
}
@end