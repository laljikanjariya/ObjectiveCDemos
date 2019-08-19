//
//  ViewController.m
//  ConditionLockDemo
//
//  Created by Lalji on 03/07/18.
//  Copyright © 2018 Lalji. All rights reserved.
//

#import "ViewController.h"

#define IDLE 0
#define START 1
#define TASK_1_FINISHED 2
#define TASK_2_FINISHED 3
#define CLEANUP_FINISHED 4

#define SHARED_DATA_LENGTH 1024 * 1024 * 1024


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad start");
    NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:START];
    char *shared_data = calloc(SHARED_DATA_LENGTH, sizeof(char));
    
    [NSThread detachNewThreadWithBlock:^{
        NSLog(@"[Thread-1]: Task 1 Created...");
        [lock lockWhenCondition:START];
        
        NSLog(@"[Thread-1]: Task 1 started...");
        for (size_t i = 0; i < SHARED_DATA_LENGTH; i++) {
            shared_data[i] = 0x00;
        }
        [lock unlockWithCondition:TASK_1_FINISHED];
    }];
    
    [NSThread detachNewThreadWithBlock:^{
        NSLog(@"[Thread-2]: Task 2 Created...");
        [lock lockWhenCondition:TASK_1_FINISHED];
        NSLog(@"[Thread-2]: Task 2 started...");
        for (size_t i = 0; i < SHARED_DATA_LENGTH; i++) {
            char c = shared_data[i];
            shared_data[i] = ~c;
        }
        [lock unlockWithCondition:TASK_2_FINISHED];
    }];
    
    [NSThread detachNewThreadWithBlock:^{
        NSLog(@"[Thread-3]: Task 3 Created...");
        [lock lockWhenCondition:TASK_2_FINISHED];
        
        NSLog(@"[Thread-3]: Cleaning up...");
        free(shared_data);
        [lock unlockWithCondition:CLEANUP_FINISHED];
    }];
    
    NSLog(@"[Thread-main]: Threads set up. Waiting for 2 task to finish");
//    [lock unlockWithCondition:START];
    [lock lockWhenCondition:CLEANUP_FINISHED];
    
    
    NSLog(@"[Thread-main]: Completed");
    
    
    NSLog(@"viewDidLoad end");
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Output -

//ConditionLockDemo[18545:94211] viewDidLoad start
//ConditionLockDemo[18545:94211] [Thread-main]: Threads set up. Waiting for 2 task to finish
//ConditionLockDemo[18545:94538] [Thread-1]: Task 1 Created...
//ConditionLockDemo[18545:94539] [Thread-2]: Task 2 Created...
//ConditionLockDemo[18545:94540] [Thread-3]: Task 3 Created...
//ConditionLockDemo[18545:94538] [Thread-1]: Task 1 started...
//ConditionLockDemo[18545:94539] [Thread-2]: Task 2 started...
//ConditionLockDemo[18545:94540] [Thread-3]: Cleaning up...
//ConditionLockDemo[18545:94211] [Thread-main]: Completed
//ConditionLockDemo[18545:94211] viewDidLoad end

@end
