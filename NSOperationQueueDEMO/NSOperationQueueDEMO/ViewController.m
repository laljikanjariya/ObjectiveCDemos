//
//  ViewController.m
//  NSOperationQueueDEMO
//
//  Created by Siya9 on 04/03/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "ViewController.h"
#import "RapidLogOperation.h"

@interface ViewController ()
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.operationQueue = [NSOperationQueue new];
    self.operationQueue.maxConcurrentOperationCount = 1;
    self.operationQueue.qualityOfService = NSQualityOfServiceBackground;
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
    [self addOprestionInQueue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)changeColor:(UIButton *)sender {
    sender.selected = ! sender.selected;
    if (sender.selected) {
        sender.backgroundColor = [UIColor redColor];
    }
    else{
        sender.backgroundColor = [UIColor greenColor];
    }
}
-(void)addOprestionInQueue{
    
    RapidLogOperation * op = [[RapidLogOperation alloc]initWithRequestPumpData:nil dataTaskCompletionHandler:^(id response, NSError *error) {
        NSString *strData = [[NSString alloc] initWithData:response encoding:NSASCIIStringEncoding];;
        NSLog(@"Data Donloaded length %d ",strData.length);
        [self addOprestionInQueue];
    }];
    [op setQualityOfService:NSQualityOfServiceBackground];
    [self.operationQueue addOperation:op];
}
@end
