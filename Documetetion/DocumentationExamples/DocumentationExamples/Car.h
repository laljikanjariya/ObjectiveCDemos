//
//  Car.h
//  DocumentationExamples
//
//  Created by Andrew Pereira on 2/10/14.
//  Copyright (c) 2014 Andrew Pereira. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * @typedef OldCarType
 * @brief A list of older car types.
 * @constant OldCarTypeModelT A cool old car.
 * @constant OldCarTypeModelA A sophisticated old car.
 */

typedef enum {
    OldCarTypeModelT,
    OldCarTypeModelA
} OldCarType;

/*!
 * @typedef CarType
 * @brief A list of newer car types.
 * @constant CarTypeHatchback Hatchbacks are fun, but small.
 * @constant CarTypeSedan Sedans should have enough room to put your kids, and your golf clubs
 * @constant CarTypeEstate Estate cars should hold your kids, groceries, sport equipment, etc.
 * @constant CarTypeSport Sport cars should be fast, fun, and hard on the back.
 */
typedef NS_ENUM(NSInteger, CarType){
    CarTypeHatchback,
    CarTypeSedan,
    CarTypeEstate,
    CarTypeSport
};

/*!
 * @brief A block that makes the car drive.
 * @param distance The distance is equal to a distance driven when the block is ready to execute. It could be miles, or kilometers, but not both. Just pick one and stick with it.
 */

typedef void(^driveCompletion)(CGFloat distance);
/*!
 *  Create a new car instance
 */
@interface Car : NSObject
/*!
 *  set the car exterior Color
 */
@property (nonatomic) UIColor *exteriorColor;
/*!
 *  set the car nickname
 */
@property (nonatomic) NSString *nickname;
/*!
 *  Indicates the kind of car as enumerated in the "CarType" NS_ENUM
 */
@property (nonatomic, assign) CarType carType;
/*!
 * @brief The car will drive, and then execute the drive block
 * @param completion A driveCompletion block
 * @code [car driveCarWithCompletion:^(CGFloat distance){
 NSLog(@"Distance driven %f", distance);
 }];
 */
- (void)driveCarWithCompletion:(driveCompletion)completion;

@end
