//
//  ViewController.m
//  UIButton
//
//  Created by Siya9 on 28/10/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Customized.h"
@interface ViewController ()
@property(nonatomic, weak)IBOutlet UIButton * btnTest;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_btnTest setTextLeftImageRightWithMargin:@(15)];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
