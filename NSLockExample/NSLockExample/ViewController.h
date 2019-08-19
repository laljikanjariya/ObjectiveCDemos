//
//  ViewController.h
//  NSLockExample
//
//  Created by Siya9 on 10/04/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) NSOperationQueue * logAOperation;
@property (nonatomic, strong) NSOperationQueue * logBOperation;
@property (nonatomic, strong) NSOperationQueue * logCOperation;
@property (nonatomic, strong) NSOperationQueue * logDOperation;
@property (nonatomic, strong) NSLock * logMessageLock;
@end

