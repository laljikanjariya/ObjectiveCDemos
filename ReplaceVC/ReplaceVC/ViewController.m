//
//  ViewController.m
//  ReplaceVC
//
//  Created by Lalji on 21/02/18.
//  Copyright © 2018 Lalji. All rights reserved.
//

#import "ViewController.h"
#import "PresentedVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)presentVC:(id)sender {
    PresentedVC * objPresentedVC =
    [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"PresentedVC_sid"];
    objPresentedVC.numTest = @(1);
    objPresentedVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    [self presentViewController:objPresentedVC animated:TRUE completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
