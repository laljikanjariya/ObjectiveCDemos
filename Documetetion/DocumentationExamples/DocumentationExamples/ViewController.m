//
//  ViewController.m
//  DocumentationExamples
//
//  Created by Andrew Pereira on 2/10/14.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import "ViewController.h"
#import "MathAPI.h"

@interface ViewController ()
/*!
 *  User First name
 */
@property (weak, nonatomic) IBOutlet UITextField *firstNumberField;
/*!
 *  User second Number Field
 */
@property (weak, nonatomic) IBOutlet UITextField *secondNumberField;
/*!
 *  User sum Label
 */
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
/*!
 *  User fun Title Label
 */
@property (weak, nonatomic) IBOutlet UILabel *funTitleLabel;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.funTitle = @"Documentation!";
    self.funTitleLabel.text = self.funTitle;
    self.car = [[Car alloc] init];
    self.car.exteriorColor = [UIColor brownColor];
    self.car.nickname = @"Ralph"; // Another nickname, perhaps?
    self.car.carType = CarTypeHatchback;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*!
 *  Change user selection type
 *
 *  @param segmentedControl for change selection
 */
- (IBAction)changeCarType:(UISegmentedControl*)segmentedControl {
    self.car.carType = segmentedControl.selectedSegmentIndex;
    [self.car driveCarWithCompletion:^(CGFloat distance) {
        NSLog(@"Car has driven %f miles", distance);
    }];
}
/**
 *  add all numbers
 *
 *  @param sender adding button
 */
- (IBAction)addAllTheNumbers:(id)sender {
    NSInteger numberOne = [self.firstNumberField.text integerValue];
    NSInteger numberTwo = [self.secondNumberField.text integerValue];
    NSInteger sum = [MathAPI addNumber:numberOne toNumber:numberTwo];
    self.sumLabel.text = [NSString stringWithFormat:@"%li", (long)sum];
}
/*!
 *  when print log in consol then call this
 *
 *  @param strLog log sting
 */
-(void)setNonLog:(NSString *)strLog{
    NSLog(@"%@",strLog);
}
@end
