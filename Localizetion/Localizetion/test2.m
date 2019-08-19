//
//  test2.m
//  Localizetion
//
//  Created by Siya9 on 30/07/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "test2.h"

@interface test2 ()

@end

@implementation test2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)changeLangagu:(UISegmentedControl *)sender {
    [[NSUserDefaults standardUserDefaults]setObject:@(sender.selectedSegmentIndex) forKey:@"appLan"];
}
@end
