//
//  ViewController.m
//  NetService
//
//  Created by Siya9 on 06/12/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSNetServiceDelegate,NSNetServiceBrowserDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.objNetService = [[NSNetService alloc] initWithDomain:@"local" type:@"_rapid_cust_Disp._tcp" name:@"LALJI" port:5030];
    if (self.objNetService) {
        [self.objNetService scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:@"PrivateMyMacServiceMode"];
        
        [self.objNetService setDelegate:self];
        [self.objNetService publish];
        [self.objNetService startMonitoring];
        NSLog(@"SUCCESS!");
        
        self.objNetServiceB = [[NSNetServiceBrowser alloc] init];
        self.objNetServiceB.delegate = self;
        [self.objNetServiceB searchForServicesOfType:@"_rapid_cust_Disp._tcp." inDomain:@"local"];

    } else {
        NSLog(@"FAIL!");
    }
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing {
    if (![aNetService.name isEqualToString:@"LALJI"]) {
        self.objNetService = aNetService;
        self.objNetService.delegate = self;
        [self.objNetService resolveWithTimeout:30];
    }
    NSLog(@"moreComing: %d", moreComing);
//    self.connectedService = aNetService;
//    if (!moreComing) {
//        self.connectedService.delegate = self;
//        [self.connectedService resolveWithTimeout:30];
//    }
}

- (void)netServiceDidResolveAddress:(NSNetService *)netService
{
    
    for (NSData *addressData in [netService addresses]) {
        NSString *address = [[NSString alloc] initWithData:addressData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", address);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
