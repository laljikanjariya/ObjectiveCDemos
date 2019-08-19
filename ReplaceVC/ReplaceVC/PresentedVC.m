//
//  PresentedVC.m
//  ReplaceVC
//
//  Created by Lalji on 21/02/18.
//  Copyright © 2018 Lalji. All rights reserved.
//

#import "PresentedVC.h"

@interface PresentedVC ()
@property (nonatomic, weak)IBOutlet UILabel * lblText;
@end

@implementation PresentedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lblText.text = self.numTest.stringValue;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)closeVC:(id)sender{
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
-(IBAction)presentVC:(id)sender {
    UIViewController * objVC = self.presentingViewController;
    PresentedVC * objPresentedVC =
    [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"PresentedVC_sid"];
    objPresentedVC.numTest = @(self.numTest.intValue + 1);
    objPresentedVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    [self dismissViewControllerAnimated:FALSE completion:^{
        [objVC presentViewController:objPresentedVC animated:FALSE completion:nil];
    }];
}
@end
