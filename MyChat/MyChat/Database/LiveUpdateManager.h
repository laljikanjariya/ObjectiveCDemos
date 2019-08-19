//
//  LiveUpdateManager.h
//  MyChat
//
//  Created by Siya9 on 11/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveUpdateManager : NSObject

+ (NSArray *)fetchEntityWithName:(NSString*)entityName key:(NSString*)key value:(id)value shouldCreate:(BOOL)shouldCreate moc:(NSManagedObjectContext*)moc;



+ (NSArray*)executeForContext:(NSManagedObjectContext*)theContext FetchRequest:(NSFetchRequest*)fetchRequest;
+ (void)saveContext:(NSManagedObjectContext*)theContext;
+ (void)deleteFromContext:(NSManagedObjectContext*)theContext object:(NSManagedObject*)anObject;
+ (NSUInteger)countForContext:(NSManagedObjectContext*)theContext FetchRequest:(NSFetchRequest*)fetchRequest;
+ (void)deleteFromContext:(NSManagedObjectContext*)theContext objectId:(NSManagedObjectID*)anObjectId;
@end
