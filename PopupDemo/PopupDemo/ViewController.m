//
//  ViewController.m
//  PopupDemo
//
//  Created by Lalji on 01/03/18.
//  Copyright © 2018 Lalji. All rights reserved.
//

#import "ViewController.h"
#import "PopupAVC.h"
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

-(IBAction)showPopup:(id)sender {
    PopupAVC * objPopupAVC =
    [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"PopupAVC_sid"];
    objPopupAVC.isHideArrow = TRUE;
    [objPopupAVC presentViewControllerForviewConteroller:self sourceView:sender ArrowDirection:UIPopoverArrowDirectionUp];
}
@end
