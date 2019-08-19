//
//  DataDownloader.h
//  ImageDownloader
//
//  Created by Siya9 on 18/11/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RapidImage.h"

@interface DataDownloader : NSObject <NSURLSessionDelegate>
@property (nonatomic, strong) FileInfo * fileInfo;
@property (nonatomic, copy) void (^completionHandler)(FileInfo * objFile);
@property (nonatomic, strong) NSURLSession *session;

+(BOOL)startDownloadToFile:(FileInfo *)objFile withCompletionHandler:(completionHandler)completionHandler;
- (void)startDownload;
- (void)cancelDownload;
@end
