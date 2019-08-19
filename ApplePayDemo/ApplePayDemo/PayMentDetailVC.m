//
//  PayMentDetailVC.m
//  ApplePayDemo
//
//  Created by Siya Infotech on 02/12/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import "PayMentDetailVC.h"

@interface PayMentDetailVC (){
    IBOutlet UILabel * lblPaymentID;
}

@end

@implementation PayMentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    lblPaymentID.text = self.strID;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
