//
//  GetSignatureResponse.h
//  PaxControllerApp
//
//  Created by siya info on 28/07/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import "PaxResponse.h"

@class UIImage;

@interface SignaturePoint : NSObject
@property (nonatomic, readonly) float x;
@property (nonatomic, readonly) float y;

- (instancetype)initWithX:(float)x y:(float)y;
- (instancetype)initWithString:(NSString*)xCommaY;
- (instancetype)initWithXValue:(NSString*)x yValue:(NSString*)y;
@end

@interface GetSignatureResponse : PaxResponse
@property (nonatomic, readonly) NSInteger totalLength;
@property (nonatomic, readonly) NSInteger responseLength;
@property (nonatomic, strong, readonly) NSArray *signaturePoints;

- (UIImage*)signatureImage;
@end
