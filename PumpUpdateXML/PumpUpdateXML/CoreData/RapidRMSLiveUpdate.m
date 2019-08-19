//
//  RapidRMSLiveUpdate.m
//  PumpUpdateXML
//
//  Created by Siya9 on 10/02/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "RapidRMSLiveUpdate.h"
#import "PumpDBManager.h"
#import "UpdatePumpManager.h"
#import "RapidRMSPumpCart.h"

static RapidRMSLiveUpdate * SharedRapidRMSLiveUpdate = nil;

@interface RapidRMSLiveUpdate ()
@property (nonatomic, strong) NSURLSession *session;
@property (atomic, strong) NSNumber * updatePending;
@end

@implementation RapidRMSLiveUpdate

+ (RapidRMSLiveUpdate *)sharedPumpSnycManager {
    @synchronized(self) {
        if (!SharedRapidRMSLiveUpdate) {
            SharedRapidRMSLiveUpdate = [[RapidRMSLiveUpdate alloc] init];
            NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
            SharedRapidRMSLiveUpdate.session = [NSURLSession sessionWithConfiguration:sessionConfig];
        }
    }
    return SharedRapidRMSLiveUpdate;
}
+(void)addLiveUpdate{
    if ([RapidRMSLiveUpdate sharedPumpSnycManager].updatePending.integerValue > 2) {
        return;
    }
    if ([RapidRMSLiveUpdate sharedPumpSnycManager].updatePending.integerValue == 0) {
        [[RapidRMSLiveUpdate sharedPumpSnycManager] callForLiveUpdate];
    }
    int count = [RapidRMSLiveUpdate sharedPumpSnycManager].updatePending.intValue;
    count++;
    [RapidRMSLiveUpdate sharedPumpSnycManager].updatePending = @(count);
}
+(void)getLiveUpdateFromRapidServer{
    [[RapidRMSLiveUpdate sharedPumpSnycManager] callForLiveUpdate];
}
-(void)callForLiveUpdate{
    NSMutableDictionary *itemparam = [[NSMutableDictionary alloc]init];
    [itemparam setValue:@(1) forKey:@"BranchId"];
    NSString *strDate = [RapidRMSLiveUpdate ludForTimeInterval:0];
    [itemparam setValue:strDate forKey:@"datetime"];
    
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:itemparam options:NSJSONWritingPrettyPrinted error:nil];
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString * serviceUrl = [NSString stringWithFormat:@"%@UpdatedItemRetailRestlist",[userDefault valueForKey:@"RapidRMSServerURL"]];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[serviceUrl stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
    
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)requestData.length] forHTTPHeaderField:@"Content-Length"];
    [request addValue:[userDefault valueForKey:@"RapidRMSDB"] forHTTPHeaderField:@"DBName-Header"];
    request.HTTPBody = requestData;
    
    [[self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        int count = self.updatePending.intValue;
        count--;
        self.updatePending = @(count);
        NSDictionary * dictResponce = [self responseDictionaryFromData:data];
        NSData *jsonData = [dictResponce[@"Data"] dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableArray *responseData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
        NSDictionary * dictResponseData =[responseData firstObject];
        NSArray * arrPumpCarts = dictResponseData[@"PumpCartObjectArray"];
        NSManagedObjectContext * moc = [UpdatePumpManager privateConextFromParentContext:[PumpDBManager sharedPumpDBManager].managedObjectContext];
        for (NSDictionary * dictPumpCart in arrPumpCarts) {
            RapidRMSPumpCart * objRapidRMSPumpCart = (RapidRMSPumpCart *)[[UpdatePumpManager fetchEntityWithName:@"RapidRMSPumpCart" key:@"cartId" value:dictPumpCart[@"CartId"] shouldCreate:TRUE moc:moc] firstObject];
            [objRapidRMSPumpCart updateCartDictDictionaryFromLive:dictPumpCart];
        }
        if (moc.hasChanges) {
            [UpdatePumpManager saveContext:moc];
        }
        [RapidRMSLiveUpdate insertItemUpdateDate:dictResponseData[@"utcdatetimeVal"]];
    }] resume];
}
- (NSDictionary *)responseDictionaryFromData:(NSData *)data
{
    NSMutableDictionary *dicResponse;
    if (data) {
        dicResponse = [self convertResponsetoDictionaryFromData:data];
    }
    NSString *actionNameResult = [NSString stringWithFormat:@"%@Result",@"UpdatedItemRetailRestlist"];
    NSDictionary *responseDictionary = [dicResponse valueForKey:actionNameResult];
    data = nil;
    return responseDictionary;
}
-(NSMutableDictionary *)convertResponsetoDictionaryFromData:(NSData *)data {
    NSMutableDictionary *dicResponse;
    NSString *actionNameResult = [NSString stringWithFormat:@"%@Result",@"UpdatedItemRetailRestlist"];
    dicResponse = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves) error:nil];
    if (dicResponse && [[dicResponse[actionNameResult] valueForKey:@"IsError"] integerValue] == -786) {
        dicResponse = nil;
    }
    return dicResponse;
}
+ (NSString *)ludForTimeInterval:(NSTimeInterval)timeInterVal
{
    NSString *strDate;
    NSDate *configDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"LiveUpdateDate"];
    if (configDate == nil) {
        configDate = [NSDate dateWithTimeIntervalSince1970:0];
        configDate = [configDate dateByAddingTimeInterval:-3600];
    }
    NSDate *minusOneHr = [configDate dateByAddingTimeInterval:-timeInterVal];
    strDate = [RapidRMSLiveUpdate ludTextFromDate:minusOneHr];
    return strDate;
}

+ (NSString *)ludTextFromDate:(NSDate *)date {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM/dd/yyyy HH:mm:ss";
    NSString* strDate = [formatter stringFromDate:date];
    return strDate;
}
+(void)insertItemUpdateDate:(NSString *)strDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"MM/dd/yyyy HH:mm:ss";
    NSDate *date = [formatter dateFromString:strDate];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"LiveUpdateDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
