//
//  DataDownloader.m
//  MyChat
//
//  Created by Siya9 on 17/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "DataDownloader.h"
#import "AppDelegate.h"

@interface DataDownloader () {

}

@property (nonatomic, strong) NSMutableDictionary * responsesData;
@property (nonatomic, strong) NSOperationQueue * objQueue;

@end

@implementation DataDownloader


+ (instancetype)sharedInstance
{
    static DataDownloader *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataDownloader alloc] init];
        sharedInstance.arrDownloadList = [[NSMutableArray alloc]init];
        sharedInstance.responsesData = [[NSMutableDictionary alloc]init];
        sharedInstance.objQueue = [[NSOperationQueue alloc]init];
        sharedInstance.objQueue.maxConcurrentOperationCount = 1;
        [DataDownloader addDefaultFolders];
    });
    return sharedInstance;
}
+(void)addDefaultFolders{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString * userProfile = [NSString stringWithFormat:@"%@/Documents/Images/userProfiles",NSHomeDirectory()];
    NSString * userMessage = [NSString stringWithFormat:@"%@/Documents/Images/userMessages",NSHomeDirectory()];
    if (![fileManager fileExistsAtPath:userProfile isDirectory:nil]) {
        [fileManager createDirectoryAtPath:userProfile withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
    if (![fileManager fileExistsAtPath:userMessage isDirectory:nil]) {
        [fileManager createDirectoryAtPath:userMessage withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
}

+ (FileInfo *)addToDownloadUserImageWithUrl:(NSString *)strUrl {
    return [DataDownloader addFileWithUrl:strUrl storePath:[NSString stringWithFormat:@"%@/Documents/Images/userProfiles/%@",NSHomeDirectory(),strUrl.lastPathComponent]];
}

+ (FileInfo *)addToDownloadUserMessageImageWithUrl:(NSString *)strUrl {
    return [DataDownloader addFileWithUrl:strUrl storePath:[NSString stringWithFormat:@"%@/Documents/Images/userMessages/%@",NSHomeDirectory(),strUrl.lastPathComponent]];
}
+(FileInfo *)addFileWithUrl:(NSString *)strUrl storePath:(NSString *)storePath{
    if ([NSURL URLWithString:strUrl] == nil) {
        return nil;
    }
    DataDownloader *sharedInstance = [DataDownloader sharedInstance];
    if (![DataDownloader isAddedIntoDownloadList:strUrl]) {
        FileInfo * fileInfo = [[FileInfo alloc]init];
        fileInfo.URL = [NSURL URLWithString:strUrl];
        fileInfo.strName = [fileInfo.URL lastPathComponent];
        fileInfo.strStoreTO = storePath;
        fileInfo.taskIdentifier = -1;
        [sharedInstance.arrDownloadList addObject:fileInfo];
        [sharedInstance startDownloaderIfNeeded];
        return fileInfo;
    }
    else{
        return [DataDownloader getAddedIntoDownloadList:strUrl];
    }
}
+(BOOL)isAddedIntoDownloadList:(NSString *)strUrl{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"self.URL == %@",[NSURL URLWithString:strUrl]];
    if ([[DataDownloader sharedInstance].arrDownloadList filteredArrayUsingPredicate:predicate].count == 0) {
        return FALSE;
    }
    return TRUE;
}
+(FileInfo *)getAddedIntoDownloadList:(NSString *)strUrl{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"self.URL == %@",[NSURL URLWithString:strUrl]];
    return (FileInfo *)[[[DataDownloader sharedInstance].arrDownloadList filteredArrayUsingPredicate:predicate] firstObject];
}
#pragma mark - Observer -
-(void)startDownloaderIfNeeded{
    [self startFileDownLoad];
}

-(BOOL)hasNextFileForDownLoad{
    return (self.arrDownloadList.count > 0)?TRUE:false;
}

-(void)preparNextFileDownLoad{

    if ([self hasNextFileForDownLoad]) {
        [self startFileDownLoad];
    }
}

-(void)startFileDownLoad{
    
    FileInfo * fileDonloading = [self getFileInfoWhichIsNotDownload];
    if (fileDonloading) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
        SessionManager * sessionManager= [SessionManager downloadDataFrom:fileDonloading withQueuw:self.objQueue];
        sessionManager.sessionCompletionHandler = ^(FileInfo * fileInfo, NSURLSession *session, NSError *error){
            NSLog(@"Downloaded file is %@",fileInfo.strName);
            [self.arrDownloadList removeObject:fileInfo];
            [fileInfo sendComplitationNotificationWithError:error];
        };
    }
}

#pragma mark - file manager -

-(FileInfo *)getFileInfoFromTaskId:(unsigned long)taskIdentifier{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"self.taskIdentifier == %lu",taskIdentifier];
    return [[[DataDownloader sharedInstance].arrDownloadList filteredArrayUsingPredicate:predicate] firstObject];
}

-(FileInfo *)getFileInfoWhichIsNotDownload{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"self.isDownloading != 1"];
    return [[self.arrDownloadList filteredArrayUsingPredicate:predicate] firstObject];
}



@end


@implementation FileInfo
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
    return [NSString stringWithFormat:@"%@ isDownloading %d",self.strName];
}
@end
