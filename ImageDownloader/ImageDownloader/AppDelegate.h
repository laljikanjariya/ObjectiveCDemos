//
//  AppDelegate.h
//  ImageDownloader
//
//  Created by Siya9 on 17/11/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>
#define Prifix @"/1000x1000bb-85.png"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, copy) void(^backgroundTransferCompletionHandler)();
@end

