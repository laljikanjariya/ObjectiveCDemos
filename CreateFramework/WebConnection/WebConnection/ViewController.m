//
//  ViewController.m
//  WebConnection
//
//  Created by Siya Infotech on 14/09/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import "ViewController.h"
#import "ServiceCallManager.h"
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
-(void)responce:(id)data {
    NSString * strdata=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self showAletr:strdata];
}
- (void)responceNotification:(NSNotification *)notification{
    NSString * strdata=[[NSString alloc] initWithData:notification.object encoding:NSUTF8StringEncoding];
    [self showAletr:strdata];
    [[NSNotificationCenter defaultCenter] removeObserver:@"TestNotification"];
}
-(void)showAletr:(NSString *)strMessage{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Responce" message:strMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
-(IBAction)CallWithNotificarion:(id)sender{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(responceNotification:) name:@"TestNotification" object:nil];
    [[WebServiceCall alloc] requestWithPOSTMethodStringUrl:@"http://www.google.com" requestParameters:nil requestJsonKey:@"" sendResponceWithNotificationName:@"TestNotification"];
}
-(IBAction)CallWithSelecter:(id)sender{
    [[WebServiceCall alloc] requestWithPOSTMethodStringUrl:@"http://www.google.com" requestParameters:nil requestJsonKey:@"" sendResponceTarget:self andSelecter:@selector(responce:)];
}
@end
