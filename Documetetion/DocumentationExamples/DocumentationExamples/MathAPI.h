//
//  MathAPI.h
//  DocumentationExamples
//
//  Created by Andrew Pereira on 2/10/14.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MathAPI : NSObject

/*!
*  A really simple way to calculate the sum of two numbers.
*
*  @param firstNumber  An NSInteger to be used in the summation of two numbers
*  @param secondNumber The second half of the equation.
*  @warning Please make note that this method is only good for adding non-negative numbers.
*
*  @return The sum of the two numbers passed in.
*/
+ (NSInteger)addNumber:(NSInteger)firstNumber toNumber:(NSInteger)secondNumber;
@end
