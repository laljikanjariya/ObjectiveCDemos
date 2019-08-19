//
//  RapidLogOperation.m
//  NSOperationQueueDemo
//
//  Created by Siya Infotech on 1/20/17.
//  Copyright © 2017 Siya Infotech. All rights reserved.
//

#import "RapidLogOperation.h"
@interface RapidLogOperation ()

@property (nonatomic, getter = isFinished, readwrite)  BOOL finished;
@property (nonatomic, getter = isExecuting, readwrite) BOOL executing;

@property (nonatomic, strong) NSString * strAction;
@property (nonatomic, strong) NSDictionary *dictParam;
@property (nonatomic, weak) NSURLSessionTask *task;
@property (nonatomic, copy) void (^dataTaskCompletionHandler)(id response, NSError * _Nullable error);

@end

@implementation RapidLogOperation

@synthesize finished  = _finished;
@synthesize executing = _executing;

- (instancetype)init {
    self = [super init];
    if (self) {
        _finished  = NO;
        _executing = NO;
    }
    return self;
}

- (void)start {
    if ([self isCancelled]) {
        self.finished = YES;
        return;
    }
    
    self.executing = YES;
    
    [self main];
}

- (void)completeOperation {
    self.executing = NO;
    self.finished  = YES;
   // NSLog(@"%@ Stop loading index %@",[NSDate date],[self getUploadingOpretionIndex]);
    self.dataTaskCompletionHandler = nil;
}

#pragma mark - NSOperation methods

- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isExecuting {
    @synchronized(self) {
        return _executing;
    }
}

- (BOOL)isFinished {
    @synchronized(self) {
        return _finished;
    }
}

- (void)setExecuting:(BOOL)executing {
    @synchronized(self) {
        if (_executing != executing) {
            [self willChangeValueForKey:@"isExecuting"];
            _executing = executing;
            [self didChangeValueForKey:@"isExecuting"];
        }
    }
}

- (void)setFinished:(BOOL)finished {
    @synchronized(self) {
        if (_finished != finished) {
            [self willChangeValueForKey:@"isFinished"];
            _finished = finished;
            [self didChangeValueForKey:@"isFinished"];
        }
    }
}

#pragma mark - NSURLSettion -

- (instancetype)initWithRequestPumpData:(NSDictionary *)dictParam dataTaskCompletionHandler:(void (^)(id response, NSError * error))dataTaskCompletionHandler {
    self = [super init];
    if (self) {
        self.dictParam = dictParam;
        self.dataTaskCompletionHandler = dataTaskCompletionHandler;
        self.strAction = @"InsertGasDataLog";

    }
    return self;
}

- (void)main {
    
    NSMutableDictionary * dictPumpcart = [NSMutableDictionary dictionary];
    
    dictPumpcart[@"CartId"] = @"";
    dictPumpcart[@"Amount"] = @(0);
    dictPumpcart[@"Volume"] = @(0);
    dictPumpcart[@"FuelId"] = @(0);
    dictPumpcart[@"PricePerGallon"] = @(0);
    //    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    formatter.dateFormat = @"MM/dd/yyyy hh:mm a";
    //    dictPumpcart[@"TimeStampVal"] = [formatter stringFromDate:self.timeStamp];
    
    
    dictPumpcart[@"isPaid"] = @(0);
    dictPumpcart[@"RowPosition"] = @(0);
    
        dictPumpcart[@"RegInvNum"] = @"0";

    dictPumpcart[@"PumpId"] = @"0";
    dictPumpcart[@"PumpCartStatus"] = @(0);
    dictPumpcart[@"SequenceNumber"] = @"";


    
        NSMutableURLRequest *request = [self createUrlRequest:@"UpdatePumpCart02222017" strURL:@"https://Rapidrms.com/WcfService/Service.svc/" params:dictPumpcart];
        
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *responseDictionary = [self responseDictionaryFromData:data];
            self.dataTaskCompletionHandler(responseDictionary, error);
            [self completeOperation];
        }];
        //NSLog(@"%@ Start loading index %@",[NSDate date],[self getUploadingOpretionIndex]);
        [task resume];
        self.task = task;
}

#pragma mark - Cretae Request -
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
                [full_URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
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
    
    request.HTTPBody = requestData;
}


- (void)cancel {
    [self.task cancel];
    [super cancel];
}

#pragma mark - Convert Response

- (NSDictionary *)responseDictionaryFromData:(NSData *)data
{
    NSMutableDictionary *dicResponse;
    if (data) {
        dicResponse = [self convertResponsetoDictionaryFromData:data];
    }
    NSString *actionNameResult = [NSString stringWithFormat:@"%@Result",self.strAction];
    NSDictionary *responseDictionary = [dicResponse valueForKey:actionNameResult];
    data = nil;
    return responseDictionary;
}

-(NSMutableDictionary *)convertResponsetoDictionaryFromData:(NSData *)data {
    NSMutableDictionary *dicResponse;
    NSString *actionNameResult = [NSString stringWithFormat:@"%@Result",self.strAction];
    dicResponse = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves) error:nil];
    if (dicResponse && [[dicResponse[actionNameResult] valueForKey:@"IsError"] integerValue] == -786) {
        dicResponse = nil;
    }
    return dicResponse;
}

@end
