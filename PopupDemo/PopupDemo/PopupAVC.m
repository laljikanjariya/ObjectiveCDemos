//
//  PopupAVC.m
//  PopupDemo
//
//  Created by Lalji on 01/03/18.
//  Copyright © 2018 Lalji. All rights reserved.
//

#import "PopupAVC.h"
#import "PopupBVC.h"

@interface PopupAVC ()

@end

@implementation PopupAVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(IBAction)showPopup:(id)sender {

    PopupBVC * objPopupBVC =
    [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"PopupBVC_sid"];
    objPopupBVC.isHideArrow = TRUE;
    self.preferredContentSize = self.sizePreferredContentSize;
    [objPopupBVC presentViewControllerForviewConteroller:self sourceView:self.view ArrowDirection:UIPopoverArrowDirectionLeft InputViews:@[self.view]];
}

@end
