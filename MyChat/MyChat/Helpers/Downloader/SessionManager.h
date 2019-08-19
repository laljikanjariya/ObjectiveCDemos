//
//  SessionManager.h
//  MyChat
//
//  Created by Siya9 on 19/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FileInfo;

typedef void (^SessionCompletionHandler)(FileInfo * fileInfo, NSURLSession *session, NSError *error);

@interface SessionManager : NSObject
@property (nonatomic, strong) SessionCompletionHandler sessionCompletionHandler;
+(instancetype)downloadDataFrom:(FileInfo *)objFile withQueuw:(NSOperationQueue *) objQueue;
@end
