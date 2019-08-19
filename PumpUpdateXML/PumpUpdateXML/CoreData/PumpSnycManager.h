//
//  PumpSnycManager.h
//  PumpUpdateXML
//
//  Created by Siya9 on 08/02/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CompletionHandler)(id response);

@interface PumpSnycManager : NSObject

+(void)startSnycPump;
+(void)stopSnycPump;

+ (PumpSnycManager *)sharedPumpSnycManager;
+ (void)updateRapidOnSiteCart:(NSString *)cart withComplitionHandler:(CompletionHandler)response;
@end
