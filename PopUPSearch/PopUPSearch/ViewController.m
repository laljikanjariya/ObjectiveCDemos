//
//  ViewController.m
//  PopUPSearch
//
//  Created by Siya9 on 07/07/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "ViewController.h"
#import "POSelectUserOptionVC.h"

@interface ViewController (){
    NSArray * arrOption;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    arrOption = @[@"Hitu",@"Hiren",@"Milan",@"Rajni",@"Lalji",@"Sonali",@"Vishal",@"Parash"];
    
    NSMutableArray * arr = [NSMutableArray array];
    [arr addObject:@{@"Dev":@"Hitu",@"id":@1}];
    [arr addObject:@{@"Dev":@"Hiren",@"id":@2}];
    [arr addObject:@{@"Dev":@"Milan",@"id":@3}];
    [arr addObject:@{@"Dev":@"Rajni",@"id":@4}];
    [arr addObject:@{@"Dev":@"Lalji",@"id":@5}];
    [arr addObject:@{@"Dev":@"Sonali",@"id":@6}];
    [arr addObject:@{@"Dev":@"Vishal",@"id":@7}];
    [arr addObject:@{@"Dev":@"Parash",@"id":@8}];
    [arr addObject:@{@"Dev":@"Shivu",@"id":@9}];
    arrOption = arr.copy;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)displayDown:(id)sender {
    POSelectUserOptionVC * op = [POSelectUserOptionVC setSelectionViewitem:arrOption SelectionComplete:^(NSArray *arrSelection) {
        
    } SelectionColse:^(UIViewController *popUpVC) {
        [((POSelectUserOptionVC *) popUpVC) popoverPresentationControllerShouldDismissPopover];
    }];
    op.strkey = @"Dev";
    [op presentViewControllerForviewConteroller:self sourceView:sender ArrowDirection:UIPopoverArrowDirectionUp];
    
}

-(IBAction)display:(id)sender {
    POSelectUserOptionVC * op = [POSelectUserOptionVC setSelectionViewitem:arrOption SelectionComplete:^(NSArray *arrSelection) {
        
    } SelectionColse:^(UIViewController *popUpVC) {
        [((POSelectUserOptionVC *) popUpVC) popoverPresentationControllerShouldDismissPopover];
    }];
    op.strkey = @"Dev";
    [op presentViewControllerForviewConteroller:self sourceView:sender ArrowDirection:UIPopoverArrowDirectionDown];

}
@end
