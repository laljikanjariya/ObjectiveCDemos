//
//  AppDelegate.h
//  GoogleDriveDownload
//
//  Created by Siya-ios5 on 9/28/17.
//  Copyright © 2017 Siya-ios5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Google/SignIn.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

