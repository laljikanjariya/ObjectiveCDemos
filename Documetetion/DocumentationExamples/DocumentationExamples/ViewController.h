//
//  ViewController.h
//  DocumentationExamples
//
//  Created by Andrew Pereira on 2/10/14.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Car.h"
/*!
 *  choose the user type
 */
typedef NS_ENUM(NSInteger, UserType){
    /*!
     *  if user is tolled
     */
    UserTypeTold,
    /*!
     *  if user is small
     */
    UserTypeSmall,
};
@interface ViewController : UIViewController
/*!
 *  ViewController class object for create new car
 */
@property (nonatomic) Car *car;
/*!
 *  ViewController class object for create car funTitle
 */
@property (nonatomic) NSString *funTitle;
/*!
 *  Change user selection type
 *
 *  @param segmentedControl UISegmentedControl for change selection
 */
- (IBAction)changeCarType:(UISegmentedControl*)segmentedControl;
@end
