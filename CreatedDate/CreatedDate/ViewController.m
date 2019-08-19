//
//  ViewController.m
//  CreatedDate
//
//  Created by Siya9 on 10/03/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}

+(NSDate *)getLocalAsUTCPumpCartCreatedDate{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    formatter.dateFormat = @"MM/dd/yyyy hh:mm a";
    NSString * strDate = [formatter stringFromDate:[NSDate date]];
    
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [formatter dateFromString:strDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
