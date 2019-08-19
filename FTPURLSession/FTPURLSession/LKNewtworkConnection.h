//
//  LKNewtworkConnection.h
//  FTPURLSession
//
//  Created by Siya9 on 10/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKNewtworkConnection : NSObject <NSURLSessionDelegate>

@property (nonatomic, strong, readwrite) NSMutableData *   listData;
@property (nonatomic, strong, readwrite) NSMutableArray *  listEntries;

-(void)test;
-(void)test2;
@end
