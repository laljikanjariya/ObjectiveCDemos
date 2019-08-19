//
//  DDFileManager.h
//  MyChat
//
//  Created by Siya9 on 29/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, DDFileType) {
    DDFileTypeUserImage,
    DDFileTypeMessageImage,
    DDFileTypeMessageAudio,
    DDFileTypeMessageVideo,
};

typedef void (^CompletionHandler)(id response, NSError *error);
typedef void (^ProgressHandler)(float fltProgress);
@class DDFileInfo;

@interface DDFileManager : NSObject <NSURLSessionDelegate>


+ (instancetype)sharedInstance;

@property (atomic, strong) NSMutableArray * arrDownloadList;
@property (nonatomic, strong) NSURLSession *session;


+ (DDFileInfo *)addToDownloadUserImageWithUrl:(NSString *)strUrl;
+ (DDFileInfo *)addToDownloadUserMessageImageWithUrl:(NSString *)strUrl;
+(BOOL)isAddedIntoDownloadList:(NSString *)strUrl;
+(void)startDownloadForFile:(DDFileInfo *)objFile;
+(void)pushDownloadForFile:(DDFileInfo *)objFile;
@end



@interface DDFileInfo : NSObject

@property (nonatomic, strong) NSString * strName;
@property (nonatomic, assign) DDFileType * fileType;
@property (nonatomic, strong) NSURL * URL;
@property (nonatomic, strong) NSString * strStoreTO;
@property (nonatomic, strong) NSArray<id> * responce;
@property (nonatomic, strong) NSArray<CompletionHandler> * completionHandler;
@property (nonatomic, strong) ProgressHandler progressHandler;

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSData *taskResumeData;
@property (nonatomic) double downloadProgress;
@property (nonatomic) BOOL isDownloading;
@property (nonatomic) BOOL downloadComplete;
@property (nonatomic) unsigned long taskIdentifier;

-(void)addNewResponce:(id)responce withComplication:(CompletionHandler)completionHandler;
-(void)sendComplitationNotificationWithError:(NSError *)error;
@end
