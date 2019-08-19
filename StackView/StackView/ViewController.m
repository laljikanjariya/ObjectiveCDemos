//
//  ViewController.m
//  StackView
//
//  Created by Siya9 on 11/05/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    IBOutlet UIStackView * staView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    staView.spacing = 50.0f;
    

    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated {
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor blueColor];
    [view1.heightAnchor constraintEqualToConstant:100].active = true;
    [view1.widthAnchor constraintEqualToConstant:120].active = true;
    
    
    //View 2
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor greenColor];
    [view2.heightAnchor constraintEqualToConstant:100].active = true;
    [view2.widthAnchor constraintEqualToConstant:70].active = true;
    
    //View 3
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor magentaColor];
    [view3.heightAnchor constraintEqualToConstant:100].active = true;
    [view3.widthAnchor constraintEqualToConstant:180].active = true;
    
    //View 4
    UIView *view4 = [[UIView alloc] init];
    view4.backgroundColor = [UIColor lightGrayColor];
    [view4.heightAnchor constraintEqualToConstant:100].active = true;
    [view4.widthAnchor constraintEqualToConstant:180].active = true;

    //View 5
    UIView *view5 = [[UIView alloc] init];
    view5.backgroundColor = [UIColor orangeColor];
    [view5.heightAnchor constraintEqualToConstant:100].active = true;
    [view5.widthAnchor constraintEqualToConstant:180].active = true;
    
    //View 6
    UIView *view6 = [[UIView alloc] init];
    view6.backgroundColor = [UIColor colorWithRed:0.000 green:0.500 blue:0.000 alpha:1.000];
    [view6.heightAnchor constraintEqualToConstant:100].active = true;
    [view6.widthAnchor constraintEqualToConstant:180].active = true;


    
//    //Stack View
//    UIStackView *stackView = [[UIStackView alloc] init];
//    
//    stackView.axis = UILayoutConstraintAxisVertical;
//    stackView.distribution = UIStackViewDistributionEqualSpacing;
//    stackView.alignment = UIStackViewAlignmentCenter;
//    stackView.spacing = 30;
    
    
    [staView addArrangedSubview:view1];
    [staView addArrangedSubview:view2];
    [staView addArrangedSubview:view3];
    [staView addArrangedSubview:view4];
    [staView addArrangedSubview:view5];
    [staView addArrangedSubview:view6];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}

@end
