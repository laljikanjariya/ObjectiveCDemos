//
//  DataDownloader.h
//  MyChat
//
//  Created by Siya9 on 17/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SessionManager.h"
@class FileInfo;

@interface DataDownloader : NSObject

@property (atomic, strong) NSMutableArray * arrDownloadList;

+ (instancetype)sharedInstance;

+ (FileInfo *)addToDownloadUserImageWithUrl:(NSString *)strUrl;
+ (FileInfo *)addToDownloadUserMessageImageWithUrl:(NSString *)strUrl;

+(BOOL)isAddedIntoDownloadList:(NSString *)strUrl;
+(FileInfo *)getAddedIntoDownloadList:(NSString *)strUrl;

-(void)startDownloaderIfNeeded;

@end

typedef void (^CompletionHandler)(id response, NSError *error);
typedef void (^ProgressHandler)(float fltProgress);
@interface FileInfo : NSObject

@property (nonatomic, strong) NSString * strName;
@property (nonatomic, strong) NSURL * URL;
@property (nonatomic, strong) NSString * strStoreTO;
@property (nonatomic, strong) NSArray<id> * responce;
@property (nonatomic, strong) NSArray<CompletionHandler> * completionHandler;
@property (nonatomic, strong) ProgressHandler progressHandler;

@property (nonatomic, weak) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic) unsigned long taskIdentifier;
@property (nonatomic) double downloadProgress;
@property (nonatomic) BOOL isDownloading;

-(void)addNewResponce:(id)responce withComplication:(CompletionHandler)completionHandler;
-(void)sendComplitationNotificationWithError:(NSError *)error;
@end
