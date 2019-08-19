//
//  ViewController.m
//  AlertTextInput
//
//  Created by Lalji on 03/05/18.
//  Copyright © 2018 Lalji. All rights reserved.
//

#import "ViewController.h"

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
-(void)viewDidAppear:(BOOL)animated {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Please Enter Terminal ID" message:@"This parameter refers to Fusion EPSs POPIDs for outdoor terminals." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Terminal ID";
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alertController addAction:cancel];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *password = alertController.textFields.firstObject;
        if (![password.text isEqualToString:@""]) {
            NSLog(@"Done");
        }
        else{
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
