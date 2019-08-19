//
//  RMSSessionManager.m
//  NetworkManager
//
//  Created by Siya9 on 27/09/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "RMSSessionManager.h"
#import <AFNetworking/AFNetworking.h>
@interface RMSSessionManager ()

@property (readwrite, nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;
@property (readwrite, nonatomic, strong) NSOperationQueue *operationQueue;
@property (readwrite, nonatomic, strong) NSURLSession *session;
@end

@implementation RMSSessionManager

#pragma mark - Class Allocation Function -
+ (instancetype)initWithRequest:(NSString*)strURL actionName:(NSString *)aName params:(NSDictionary*)params completionHandler:(CompletionHandler)completionHandler{
    RMSSessionManager * objRMSSessionManager = [[RMSSessionManager alloc]init];
    
    objRMSSessionManager.operationQueue = [[NSOperationQueue alloc] init];
    objRMSSessionManager.operationQueue.maxConcurrentOperationCount = 1;

    
    objRMSSessionManager.session = [NSURLSession sessionWithConfiguration:objRMSSessionManager.sessionConfiguration delegate:objRMSSessionManager delegateQueue:objRMSSessionManager.operationQueue];

    return objRMSSessionManager;
}

+ (instancetype)initWithAsyncRequest:(NSString*)strURL actionName:(NSString *)aName params:(NSDictionary*)params asyncCompletionHandler:(AsyncCompletionHandler)asyncCompletionHandler{
    return nil;
}
//background
+ (instancetype)initWithAsyncRequest:(NSString*)strURL actionName:(NSString *)aName params:(NSDictionary*)params asyncCompletionHandler:(AsyncCompletionHandler)asyncCompletionHandler progressHandler:(ProgressHandler)progressHandler{
    return nil;
}


#pragma mark - Create URLRequest -

- (NSMutableURLRequest *)createUrlRequest:(NSString *)aName strURL:(NSString *)strURL params:(NSDictionary *)params
{
    NSMutableURLRequest *request;
    NSString *full_URL;
    full_URL = [self createURL:strURL aName:aName];
    request = [self requestWithUrl:full_URL];
    if(params!=nil)
    {
        [self configureRequest:request params:params];
    }
    return request;
}

- (NSString *)createURL:(NSString *)strURL aName:(NSString *)aName
{
    NSString *full_URL = @"";
    if (aName != nil) {
        full_URL = [NSString stringWithFormat:@"%@%@",strURL,aName];
        
    } else {
        full_URL = [NSString stringWithFormat:@"%@",strURL];
    }
    return full_URL;
}

- (NSMutableURLRequest *)requestWithUrl:(NSString *)full_URL
{
    NSMutableURLRequest *request;
    request = [[NSMutableURLRequest alloc] initWithURL:
               [NSURL URLWithString:
                [full_URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]]];
    return request;
}

- (void)configureRequest:(NSMutableURLRequest *)request params:(NSDictionary *)params
{
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)requestData.length] forHTTPHeaderField:@"Content-Length"];
    [request addValue:@"RapidRMS10015" forHTTPHeaderField:@"DBName-Header"];
    
//    if (![(self.rmsDbController.globalDict)[@"DBName"] isEqualToString:@""])
//    {
//        [request addValue:(self.rmsDbController.globalDict)[@"DBName"] forHTTPHeaderField:@"DBName-Header"];
//    }
    request.HTTPBody = requestData;
}
@end
