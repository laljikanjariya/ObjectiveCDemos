//
//  AppDelegate.m
//  CoreDataDelete
//
//  Created by Siya Infotech on 21/10/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import "AppDelegate.h"
#define DatabaseVersion 1.2
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self databaseUpdateIfNeeded];
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
    [[DatabaseManager sharedinstanceDatabaseManager] saveContext];
}
-(void)databaseUpdateIfNeeded{
    NSString * strDbVersion = [[NSUserDefaults standardUserDefaults]valueForKey:@"dbVersion"];
    if (strDbVersion == nil || [strDbVersion isEqualToString:@""]) {
        strDbVersion = @"1.0";
    }
    if (DatabaseVersion > [strDbVersion floatValue]) {
        NSString * strDatabasePath = [NSString stringWithFormat:@"%@/Documents/CoreDataDelete.sqlite",NSHomeDirectory()];
        if ([[NSFileManager defaultManager] fileExistsAtPath:strDatabasePath]) {
            NSError * error;
            [[NSFileManager defaultManager] removeItemAtPath:strDatabasePath error:&error];
            NSLog(@"%@",error);
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",DatabaseVersion] forKey:@"dbVersion"];
//    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"0.0"] forKey:@"dbVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [DatabaseManager sharedinstanceDatabaseManager];
}
@end
