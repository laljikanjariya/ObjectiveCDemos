//
//  AppDelegate.h
//  MyChat
//
//  Created by Siya9 on 11/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, copy) void(^backgroundTransferCompletionHandler)();
@end

