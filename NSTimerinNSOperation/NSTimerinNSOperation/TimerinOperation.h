//
//  TimerinOperation.h
//  NSTimerinNSOperation
//
//  Created by Lalji on 24/04/18.
//  Copyright © 2018 Lalji. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^RapidPetroPosOpretionBlock)(void);

@interface TimerinOperation : NSOperation
{
@private
    NSTimer* _timer;
    RapidPetroPosOpretionBlock opretionBlock;
}

@property (nonatomic, readonly) BOOL isExecuting;
@property (nonatomic, readonly) BOOL isFinished;



- (id) initWithBlock:(RapidPetroPosOpretionBlock)posOpretionBlock;
@end
