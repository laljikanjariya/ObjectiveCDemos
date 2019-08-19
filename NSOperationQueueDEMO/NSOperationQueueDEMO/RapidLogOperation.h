//
//  RapidLogOperation.h
//  NSOperationQueueDemo
//
//  Created by Siya Infotech on 1/20/17.
//  Copyright © 2017 Siya Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RapidLogOperation : NSOperation


- (instancetype)initWithRequestPumpData:(NSDictionary *)dictParam dataTaskCompletionHandler:(void (^)(id response, NSError * error))dataTaskCompletionHandler;

- (void)completeOperation;

@end
