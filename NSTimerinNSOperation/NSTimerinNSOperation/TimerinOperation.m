//
//  TimerinOperation.m
//  NSTimerinNSOperation
//
//  Created by Lalji on 24/04/18.
//  Copyright © 2018 Lalji. All rights reserved.
//

#import "TimerinOperation.h"

@implementation TimerinOperation
@synthesize isExecuting = _executing;
@synthesize isFinished  = _finished;


- (id) initWithBlock:(RapidPetroPosOpretionBlock)posOpretionBlock {
    if ((self = [super init])) {
        _executing = NO;
        _finished  = NO;
        opretionBlock = posOpretionBlock;
    }
    
    return self;
}

- (BOOL) isConcurrent {
    return YES;
}

- (void) finish {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    _executing = NO;
    _finished = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (void) start {
    if ([self isCancelled]) {
        [self willChangeValueForKey:@"isFinished"];
        _finished = YES;
        [self didChangeValueForKey:@"isFinished"];
    } else {
        [self willChangeValueForKey:@"isExecuting"];
        [self performSelectorOnMainThread:@selector(main)
                               withObject:nil
                            waitUntilDone:NO];

        _executing = YES;
        [self didChangeValueForKey:@"isExecuting"];
//        [self performSelector:@selector(startOpreation) withObject:nil];
        [self startOpreation];
    }
}

- (void) timerFired:(NSTimer*)timer {
    if (![self isCancelled]) {
        NSLog(@"Timer Stop");
        [self cancel];
    }
}

- (void) main {
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:FALSE];
//    [self performSelector:@selector(startOpreation) withObject:nil];
}
-(void)startOpreation {
    for (; ; ) {
        opretionBlock();
        sleep(1);
    }
}
- (void) cancel {
    [_timer invalidate];
    _timer = nil;
    [super cancel];
}
@end
