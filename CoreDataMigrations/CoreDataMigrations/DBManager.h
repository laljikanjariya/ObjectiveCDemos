//
//  DBManager.h
//  CoreDataMigrations
//
//  Created by Lalji on 19/05/18.
//  Copyright © 2018 Lalji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DBManager : NSObject
+ (instancetype)sharedInstance;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
+ (NSManagedObjectContext *)privateConextFromParentContext:(NSManagedObjectContext*)parentContext;
+ (void)saveContext:(NSManagedObjectContext*)theContext;
//@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
@end
