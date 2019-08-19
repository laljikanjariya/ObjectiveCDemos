//
//  ViewController.m
//  PopupBackGroundColor
//
//  Created by Siya9 on 03/11/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "ViewController.h"
#import "PopupVCViewController.h"
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

-(IBAction)popUP:(id)sender{
    PopupVCViewController * obPopupVCViewController =
    [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"PopupVCViewController_sid"];

    [obPopupVCViewController presentViewControllerForViewController:self];
}
@end
