//
//  WebServiceCall.m
//  NetworkManager
//
//  Created by Siya Infotech on 12/09/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import "WebServiceCall.h"


@interface WebServiceCall ()
{
    NSMutableData *responseData;
    NSURLConnection *urlConnection;
}
@property (nonatomic ,strong) id target;
@property (nonatomic) SEL selecter;
@property (nonatomic ,strong) NSString * notificationName;
@end
@implementation WebServiceCall

-(void)requestWithPOSTMethodStringUrl:(NSString *)strUrl requestParameters:(NSDictionary *)dictParameters requestJsonKey:(NSString *)strJSONKey sendResponceWithNotificationName:(NSString *) strNotification {
    
    self.notificationName = strNotification;
    self.target = nil;
    self.selecter = nil;
    
    [self CreateRequestAndCall:strUrl dictParameters:dictParameters strJSONKey:strJSONKey];
}
-(void)requestWithPOSTMethodStringUrl:(NSString *)strUrl requestParameters:(NSDictionary *) dictParameters requestJsonKey:(NSString *)strJSONKey sendResponceTarget:(id) target andSelecter:(SEL)selecter {
    self.target = target;
    self.selecter = selecter;
    self.notificationName = nil;
    
    [self CreateRequestAndCall:strUrl dictParameters:dictParameters strJSONKey:strJSONKey];
    
}
- (void)CreateRequestAndCall:(NSString *)strUrl dictParameters:(NSDictionary *)dictParameters strJSONKey:(NSString *)strJSONKey {
    NSMutableURLRequest *request;
    request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[strUrl stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
    [request setTimeoutInterval:60];
    
    if(dictParameters!=nil)
    {
        if (strJSONKey != nil) {
            dictParameters = @{strJSONKey : dictParameters};
        }
        
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:dictParameters options:NSJSONWritingPrettyPrinted error:nil];
        
        [request setHTTPMethod: @"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
        
        [request setHTTPBody: requestData];
    }
    else
    {
    }
    responseData = [NSMutableData data];
    urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

-(void)sendResponceWith:(id)data{
    if (self.notificationName != nil && ![self.notificationName isEqualToString:@""]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:self.notificationName object:data userInfo:nil];
    }
    else if (self.target !=nil && self.selecter !=nil){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selecter withObject:data];
#pragma clang diagnostic pop
    }
    else{
        NSLog(@"Not Send Responce");
    }
}
#pragma mark - Encode Url -
+ (NSString *)urlEncodeValue:(NSString *)strUrl {
    NSString *result = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"?=&+"]];
    return result;
}

#pragma mark - NSURLConnectionDelegate -
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response {
    
    //    NSLog(@"Did Receive Response %@", response);
    responseData = [[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data {
    //    NSLog(@"Did Receive Data %@", data);
    [responseData appendData:data];
}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error {
    NSLog(@"Did Fail");
    [self sendResponceWith:error];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Did Finish");
    [self sendResponceWith:responseData];
    // Do something with responseData
}
@end
