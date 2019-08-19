//
//  AppDelegate.m
//  PumpUpdateXML
//
//  Created by Siya9 on 08/02/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "AppDelegate.h"
#import "PumpDBManager.h"
#import "PumpSnycManager.h"
#import "RapidRMSLiveUpdate.h"
@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSString * request = @"http://store.dev8.rapidonsite.com:6631/AdHoc?RapidOnSite_Pump_AdHoc";
    request = @"http://store.yanks9180.rapidonsite.com:6631/Cart-2017-01-24-20-29-59,185_686_912.Branch,XML";
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"http://store.yanks9180.rapidonsite.com:6631" forKey:@"OnSiteServerURL"];
    [[NSUserDefaults standardUserDefaults] setObject:@"https://www.rapidrms.com/WcfService/Service.svc/" forKey:@"RapidRMSServerURL"];
    [[NSUserDefaults standardUserDefaults] setObject:@"RapidRMS180893" forKey:@"RapidRMSDB"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    [PumpSnycManager startSnycPump];
    [RapidRMSLiveUpdate addLiveUpdate];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[PumpDBManager sharedPumpDBManager] saveContext];
}

@end
