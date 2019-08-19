//
//  ViewController.m
//  NSLockExample
//
//  Created by Siya9 on 10/04/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logAOperation = [NSOperationQueue new];
    self.logAOperation.name = @"logAOperation";
    self.logAOperation.maxConcurrentOperationCount = 1;
    self.logAOperation.qualityOfService = NSQualityOfServiceUserInitiated;
    
    self.logBOperation = [NSOperationQueue new];
    self.logBOperation.name = @"logBOperation";
    self.logBOperation.maxConcurrentOperationCount = 1;
    self.logBOperation.qualityOfService = NSQualityOfServiceBackground;
    
    self.logCOperation = [NSOperationQueue new];
    self.logCOperation.name = @"logCOperation";
    self.logCOperation.maxConcurrentOperationCount = 1;
    self.logCOperation.qualityOfService = NSQualityOfServiceBackground;
    
    self.logDOperation = [NSOperationQueue new];
    self.logDOperation.name = @"logDOperation";
    self.logDOperation.maxConcurrentOperationCount = 1;
    self.logDOperation.qualityOfService = NSQualityOfServiceBackground;
    
    
    self.logMessageLock = [[NSLock alloc]init];
    [self logMessage:@"Start Application"];
    [self logAMessage];
    [self logBMessage];
    [self logCMessage];
    [self logDMessage];
}


-(void)logAMessage{
    [self.logAOperation addOperationWithBlock:^{
        [self logMessage:@"A"];
        sleep(1);
        [self logAMessage];
    }];
}
-(void)logBMessage{
    [self.logBOperation addOperationWithBlock:^{
        for (int i = 0; i<5000; i++) {
            [self logMessage:[NSString stringWithFormat:@"B %d",i]];
        }
    }];
}
-(void)logCMessage{
    [self.logCOperation addOperationWithBlock:^{
        for (int i = 0; i<5000; i++) {
            [self logMessage:[NSString stringWithFormat:@"C %d",i]];
        }
    }];
}

-(void)logDMessage{
    [self.logDOperation addOperationWithBlock:^{
        for (int i = 0; i<5000; i++) {
            [self logMessage:[NSString stringWithFormat:@"D %d",i]];
        }
    }];
}
-(void)logMessage:(NSString *)strLog{
    NSLog(@"%@", [NSString stringWithFormat:@"IN %@",strLog]);
    [self.logMessageLock lock];
    NSLog(@"%@", [NSString stringWithFormat:@"OUT %@",strLog]);
    sleep(2);
    [self.logMessageLock unlock];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
