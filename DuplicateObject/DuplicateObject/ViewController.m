//
//  ViewController.m
//  DuplicateObject
//
//  Created by Siya Infotech on 26/11/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import "ViewController.h"
#import "DuplicateObject.h"
#import <Contacts/Contacts.h>

@interface ViewController (){
    IBOutlet UIView * objView;
}

@end

@implementation ViewController
-(IBAction)check:(id)sender{
    NSLog(@"\nx=%f \ny=%f \nW=%f \nH=%f \n",objView.frame.origin.x,objView.frame.origin.y,objView.frame.size.width,objView.frame.size.height);
}
- (void)viewDidLoad {
    [super viewDidLoad];

     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
