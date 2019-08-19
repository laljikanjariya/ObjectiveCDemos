//
//  RMSSessionManager.h
//  NetworkManager
//
//  Created by Siya9 on 27/09/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CompletionHandler)(id response, NSError *error);
typedef void (^AsyncCompletionHandler)(id response, NSError *error);
typedef void (^ProgressHandler)(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite);

@interface RMSSessionManager : NSObject <NSURLSessionDelegate>


+ (instancetype)initWithRequest:(NSString*)strURL actionName:(NSString *)aName params:(NSDictionary*)params completionHandler:(CompletionHandler)completionHandler;

+ (instancetype)initWithAsyncRequest:(NSString*)strURL actionName:(NSString *)aName params:(NSDictionary*)params asyncCompletionHandler:(AsyncCompletionHandler)asyncCompletionHandler;

+ (instancetype)initWithAsyncRequest:(NSString*)strURL actionName:(NSString *)aName params:(NSDictionary*)params asyncCompletionHandler:(AsyncCompletionHandler)asyncCompletionHandler progressHandler:(ProgressHandler)progressHandler;

@end
