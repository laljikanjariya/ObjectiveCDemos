//
//  DatabaseManager.m
//  MySongs
//
//  Created by Siya Infotech on 25/12/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager
#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
#define DATABASE_VERSION 1.1

static DatabaseManager *sharedInstance = nil;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DatabaseManager alloc] init];
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"DATABASE_VERSION"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
        [self removeDatabaseifNeeded];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}
+(void)removeDatabaseifNeeded {
    float dbVersion = [[[NSUserDefaults standardUserDefaults] objectForKey:@"DATABASE_VERSION"] floatValue];
    if (dbVersion<DATABASE_VERSION) {
        NSURL *storeURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"MySongs.sqlite"];

        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error = nil;
        [self MoveSongsForUpdateDatabase];
        if (![fileManager removeItemAtURL:storeURL error:&error]) {
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"DATABASE_VERSION"];
            NSLog(@"[Error] %@ (%@)", error, storeURL);
        }
        else {
            [[NSUserDefaults standardUserDefaults] setObject:@(DATABASE_VERSION) forKey:@"DATABASE_VERSION"];
        }
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
+(void)MoveSongsForUpdateDatabase {
    NSString * strApppath =  [NSString stringWithFormat:@"%@/Documents/Songs/",NSHomeDirectory()];
    NSError * error;
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSArray * arrAllFiles = [fileManager contentsOfDirectoryAtPath:strApppath error:&error];
    
    if (error == nil) {

        
        for (NSString * strFileName in arrAllFiles) {
            
            NSString * strFromPath = [NSString stringWithFormat:@"%@/Documents/Songs/%@",NSHomeDirectory(),strFileName];
            NSString * strToPath = [NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),strFileName];
            NSString *escapedUrlString = [strFromPath stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
;
            if ([[[[NSURL URLWithString:escapedUrlString] pathExtension] lowercaseString] isEqualToString:@"mp3"]) {
                [fileManager moveItemAtPath:strFromPath toPath:strToPath error:nil];
                NSError *error1 = nil;
                [fileManager removeItemAtPath:strFromPath error:&error1];
                NSLog(@"%@",error1);
            }
        }
    }
    else {
        NSLog(@"%@",error);
    }
}
- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.MySongs" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MySongs" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MySongs.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
@end
