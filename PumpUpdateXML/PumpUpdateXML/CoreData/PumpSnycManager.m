//
//  PumpSnycManager.m
//  PumpUpdateXML
//
//  Created by Siya9 on 08/02/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "PumpSnycManager.h"
#import "XMLtoObject.h"
#import "UpdatePumpManager.h"
#import "PumpDBManager.h"
#import "FuelPump.h"
#import "RapidOnSitePumpCart.h"

static PumpSnycManager * g_SharedPumpSnycManager = nil;

@interface PumpSnycManager ()

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSOperationQueue *operationQueueOnSiteCart;

@end

@implementation PumpSnycManager

+ (PumpSnycManager *)sharedPumpSnycManager {
    @synchronized(self) {
        if (!g_SharedPumpSnycManager) {
            g_SharedPumpSnycManager = [[PumpSnycManager alloc] init];
            g_SharedPumpSnycManager.operationQueue = [NSOperationQueue new];
            g_SharedPumpSnycManager.operationQueue.maxConcurrentOperationCount = 1;
            g_SharedPumpSnycManager.operationQueue.qualityOfService = NSQualityOfServiceBackground;
            
            g_SharedPumpSnycManager.operationQueueOnSiteCart = [NSOperationQueue new];
            g_SharedPumpSnycManager.operationQueueOnSiteCart.maxConcurrentOperationCount = 1;
            g_SharedPumpSnycManager.operationQueueOnSiteCart.qualityOfService = NSQualityOfServiceBackground;
        }
    }
    return g_SharedPumpSnycManager;
}
+(void)startSnycPump{
    [[PumpSnycManager sharedPumpSnycManager] addRequestInQueue];
}
+(void)stopSnycPump{
    [[PumpSnycManager sharedPumpSnycManager].operationQueue cancelAllOperations];
}


-(void)addRequestInQueue{
    [self.operationQueue addOperationWithBlock:^{
        NSString * strPath = [[NSUserDefaults standardUserDefaults] objectForKey:@"OnSiteServerURL"];
        NSString * request = [NSString stringWithFormat:@"%@/AdHoc?RapidOnSite_Pump_AdHoc",strPath];
        NSDictionary * dictPumps = [XMLtoObject parseXMLtoObjectfromURL:request];
        NSArray * arrPumps = [dictPumps valueForKeyPath:@"Shofar.RapidOnSite_Pump"];
        NSManagedObjectContext * moc = [UpdatePumpManager privateConextFromParentContext:[PumpDBManager sharedPumpDBManager].managedObjectContext];
        for (NSDictionary * dictPumps in arrPumps) {
//            NSLog(@"%@",dictPumps);
            FuelPump * objPump = (FuelPump *)[UpdatePumpManager fetchEntityWithName:@"FuelPump" key:@"pumpIndex" value:dictPumps[@"Key"] shouldCreate:TRUE moc:moc].firstObject;
            [objPump updateFuelPumpFromSnyc:dictPumps];
        }
        [UpdatePumpManager saveContext:moc];
        [self addRequestInQueue];
    }];
}
+(void)updateRapidOnSiteCart:(NSString *)cart withComplitionHandler:(CompletionHandler)response {
    [[PumpSnycManager sharedPumpSnycManager].operationQueueOnSiteCart addOperationWithBlock:^{
        NSString * strPath = [[NSUserDefaults standardUserDefaults] objectForKey:@"OnSiteServerURL"];
        NSString * request = [NSString stringWithFormat:@"%@%@.Branch,XML",strPath,cart];
        NSDictionary * dictPumps = [XMLtoObject parseXMLtoObjectfromURL:request];
        
        NSManagedObjectContext * moc = [UpdatePumpManager privateConextFromParentContext:[PumpDBManager sharedPumpDBManager].managedObjectContext];
        
        RapidOnSitePumpCart * objPump = (RapidOnSitePumpCart *)[UpdatePumpManager fetchEntityWithName:@"RapidOnSitePumpCart" key:@"cartId" value:cart shouldCreate:TRUE moc:moc].firstObject;
        
        NSDictionary * dictPump = [dictPumps valueForKeyPath:@"Shofar.RapidOnSite_Pump"];
        NSDictionary * dictCart = [dictPumps valueForKeyPath:@"Shofar.Cart"];
        
        objPump.amount = @([dictPump[@"Amount"] floatValue]);
        objPump.amountLimit = @([dictPump[@"Amount_Limit"] floatValue]);
        objPump.cartId = cart;
        objPump.cartStatus = dictCart[@"State"];
        objPump.fuelIndex = @([dictPump[@"Fuel"] integerValue]);
        objPump.price = @([dictPump[@"Price"] floatValue]);
        objPump.pumpIndex = @([dictPump[@"Key"] integerValue]);
        objPump.volume = @([dictPump[@"Volume"] floatValue]);
        objPump.volumeLimit = @([dictPump[@"Volume_Limit"] floatValue]);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
        NSString * strUpdated = [dictPumps valueForKeyPath:@"Shofar.Updated"];
//        strUpdated = [[strUpdated componentsSeparatedByString:@"."] firstObject];
        NSLog(@"%@",[formatter dateFromString:strUpdated]);
        objPump.timeStamp = [formatter dateFromString:strUpdated];

        
//        Updated="2017-01-31T02:03:23.002-05:00"
        
//        objPump.timeStamp = [NSDate date];
        [UpdatePumpManager saveContext:moc];
        response([[PumpDBManager sharedPumpDBManager].managedObjectContext objectWithID:objPump.objectID]);
    }];
}
@end
