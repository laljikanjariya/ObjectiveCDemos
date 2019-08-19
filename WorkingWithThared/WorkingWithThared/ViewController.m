//
//  ViewController.m
//  WorkingWithThared
//
//  Created by siya-IOS5 on 11/20/15.
//  Copyright (c) 2015 siya-IOS5. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (atomic) BOOL isPenddingData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.isPenddingData = FALSE;
    NSThread * thredA = [[NSThread alloc]initWithTarget:self selector:@selector(workAthred) object:nil];
    NSThread * thredB = [[NSThread alloc]initWithTarget:self selector:@selector(workBthred) object:nil];
    [thredA start];
    [thredB start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)workAthred{
    for (; true; ) {
        if (!self.isPenddingData) {
            NSLog(@"Thared A Put");
            [NSThread sleepForTimeInterval:0.5];
            self.isPenddingData = TRUE;
        }
    }
}
-(void)workBthred{
    for (; true; ) {
        if (self.isPenddingData) {
            NSLog(@"Thared B get");
            [NSThread sleepForTimeInterval:0.5];
            self.isPenddingData = FALSE;
        }
    }
}
@end
