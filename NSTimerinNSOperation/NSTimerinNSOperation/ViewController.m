//
//  ViewController.m
//  NSTimerinNSOperation
//
//  Created by Lalji on 24/04/18.
//  Copyright © 2018 Lalji. All rights reserved.
//

#import "ViewController.h"
#import "TimerinOperation.h"

@interface ViewController ()

@property (nonatomic, strong) NSOperationQueue * pumpOperation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pumpOperation = [NSOperationQueue new];
    self.pumpOperation.name = @"PumpOperationsQueue";
    self.pumpOperation.maxConcurrentOperationCount = 1;
    self.pumpOperation.qualityOfService = NSQualityOfServiceBackground;
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(updateOpretionQueue) userInfo:nil repeats:TRUE];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewDidDisappear start");
    TimerinOperation * timerinOperation = [[TimerinOperation alloc]initWithBlock:^{
            NSLog(@"TimerinOperation.h");
    }];
    [self.pumpOperation addOperation:timerinOperation];
//    [[NSOperationQueue mainQueue] addOperation:timerinOperation];
    NSLog(@"viewDidDisappear end");
}
-(void)updateOpretionQueue{
    NSLog(@"%@",self.pumpOperation.operations.firstObject.debugDescription);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
