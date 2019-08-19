//
//  AppDelegate.m
//  FTPConnection
//
//  Created by Siya9 on 05/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "AppDelegate.h"
#import "FTPComunicacion.h"
@interface AppDelegate () {
//    FTPControlerDeleteFile * obj;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    obj = [FTPControlerDeleteFile deleteDirectoryWith:@"ftp://192.168.0.249/1.png" userID:@"Siya9" userPassword:@"l" forDelegate:self];
//    obj = [FTPControlerReadData uploadFileTo:@"ftp://192.168.0.249/1.png" filePath:[NSString stringWithFormat:@"%@/Documents/1.png",NSHomeDirectory()] userID:@"Siya9" userPassword:@"l" forDelegate:nil];
    
//    obj = [FTPControlerWriteData uploadFileToFTPPath:@"ftp://192.168.0.249/1.png" fileLocalPath:[NSString stringWithFormat:@"%@/tmp/1.png",NSHomeDirectory()] userID:@"Siya9" userPassword:@"l" forDelegate:nil];
    return YES;
}

-(void)updateStatus:(FTPControler *)objFTPController WithError:(NSString *)error {
    NSLog(@"%@",error);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
