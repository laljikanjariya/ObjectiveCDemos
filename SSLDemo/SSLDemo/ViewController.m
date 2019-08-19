//
//  ViewController.m
//  SSLDemo
//
//  Created by Siya9 on 23/09/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "ViewController.h"
#import "RapidWebServiceConnection.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)SendSSLREQ:(id)sender {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict[@"MacAddress"] = @"838F1C10-247B-4AC4-AB9D-5B87A9B3D4B9";
    dict[@"dType"] = @"IOS-RCRIpad";
    dict[@"dVersion"] = [UIDevice currentDevice].systemVersion;
    NSString *appVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    if ([appVersion isKindOfClass:[NSString class]])
    {
        dict[@"appVersion"] = appVersion;
    }
    else
    {
        dict[@"appVersion"] = @"";
    }
    NSString *buildVersion = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleVersionKey];
    if ([buildVersion isKindOfClass:[NSString class]])
    {
        dict[@"buildVersion"] = buildVersion;
    }
    else
    {
        dict[@"buildVersion"] = @"";
    }
    // Pass system date and time while configuration
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM/dd/yyyy hh:mm a";
    NSString *currentDateTime = [formatter stringFromDate:date];
    dict[@"LocalDate"] = currentDateTime;
    NSLog(@"DeviceConfigration03192015 Param = %@",dict);
    
//    NSString *serverUrl = [NSString stringWithFormat:@"https://rapidrmseast-rapidrmsmodulewise.azurewebsites.net/WcfService/Service.svc/"];
    
//    NSString *serverUrl = [NSString stringWithFormat:@"https://rapidrmswebsite.trafficmanager.net/WcfService/Service.svc/"];
    
//    NSString *serverUrl = [NSString stringWithFormat:@"https://rapidrmseast-rapidrmsmodulewise.azurewebsites.net/WcfService/Service.svc/"];
    
    NSString *serverUrl = [NSString stringWithFormat:@"https://192.168.1.100:10009/?AkEwMBwxLjMyA0A="];
    
    //#if 1
    AsyncCompletionHandler completionHandler = ^(id response, NSError *error) {
        NSLog(@"RES = \n%@ \n\n\nERROR = \n%@",response,error);
    };
    
    RapidWebServiceConnection *regConfiguration = [[RapidWebServiceConnection alloc] initWithAsyncRequest:serverUrl actionName:nil params:nil asyncCompletionHandler:completionHandler];
    //#else
    //    CompletionHandler completionHandler = ^(id response, NSError *error) {
    //        [self regConfigrationResponse:response error:error];
    //    };
    //
    //    self.regConfiguration = [[RapidWebServiceConnection alloc] initWithRequest:serverUrl actionName:@"DeviceConfigration03192015" params:dict completionHandler:completionHandler];
    //#endif
}
@end
