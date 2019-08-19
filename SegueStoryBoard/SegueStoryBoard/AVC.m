//
//  AVC.m
//  SegueStoryBoard
//
//  Created by Siya9 on 06/07/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "AVC.h"

@interface AVC ()

@end

@implementation AVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)exitToAVC:(UIStoryboardSegue *)segue {

}
- (IBAction)exitToA1:(id)segue {
    NSLog(@"A1");
}
- (IBAction)exitToA2:(id)segue {
    NSLog(@"A2");
}
@end
