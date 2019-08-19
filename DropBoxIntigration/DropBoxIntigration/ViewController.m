//
//  ViewController.m
//  DropBoxIntigration
//
//  Created by Siya9 on 05/10/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "ViewController.h"
#import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [DBClientsManager authorizeFromController:[UIApplication sharedApplication]
                                   controller:self
                                      openURL:^(NSURL *url) {
                                          [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                                              
                                          }];
                                      }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
