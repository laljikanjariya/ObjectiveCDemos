//
//  UpdateLogManager.m
//  DebugLog
//
//  Created by Siya9 on 19/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "UpdatePumpManager.h"

@implementation UpdatePumpManager

#pragma mark - CoreData Wrappers -

+ (NSManagedObjectContext *)privateConextFromParentContext:(NSManagedObjectContext*)parentContext {
    // Create Provate context for this queue
    NSManagedObjectContext *privateManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    privateManagedObjectContext.parentContext = parentContext;
    [privateManagedObjectContext setUndoManager:nil];
    return privateManagedObjectContext;
}

#pragma mark - Fetch methods
+ (NSArray <NSManagedObject *> *)fetchEntityWithName:(NSString*)entityName key:(NSString*)key value:(id)value shouldCreate:(BOOL)shouldCreate moc:(NSManagedObjectContext*)moc
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:moc];
    fetchRequest.entity = entity;

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@",key,value];
    fetchRequest.predicate = predicate;
    NSArray *arryTemp = [UpdatePumpManager executeForContext:moc FetchRequest:fetchRequest];
    
    if (arryTemp.count == 0) {
        if (shouldCreate) {
            return @[[NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:moc]];
        }
    }
    return arryTemp;
}

+ (NSArray*)executeForContext:(NSManagedObjectContext*)theContext FetchRequest:(NSFetchRequest*)fetchRequest {
    NSArray *result = nil;
    NSError *error = nil;
    @try
    {
        result = [theContext executeFetchRequest:fetchRequest error:&error];
    }
    @catch (NSException *exception)
    {
        NSLog(@"Error while executing fetch request occured. %@", exception);
        result = nil;
    }
    @finally {
    }
    
    return result;
}

+ (void)deleteFromContext:(NSManagedObjectContext *)theContext object:(NSManagedObject*)anObject {
    @try {
        [theContext deleteObject:anObject];
    }
    @catch (NSException *exception) {
        NSLog(@"Non recoverable error occured while deleting. %@", exception);
    }
    @finally {
        
    }
    
}
+ (void)deleteFromContext:(NSManagedObjectContext *)theContext objectId:(NSManagedObjectID*)anObjectId {
    @try {
        NSManagedObject * anObject = [theContext objectWithID:anObjectId];
        [UpdatePumpManager deleteFromContext:theContext object:anObject];
    }
    @catch (NSException *exception) {
        NSLog(@"Non recoverable error occured while deleting. %@", exception);
    }
    @finally {
        
    }
    
}

+ (void)__save:(NSManagedObjectContext *)theContext {
    // Save context
    @try {
        NSError *error = nil;
        if (![theContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", error.localizedDescription);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Save: Non recoverable error occured. %@", exception);
    }
    @finally {
        
    }
    [self saveContext:theContext.parentContext];
}

+ (void)saveContext:(NSManagedObjectContext*)theContext {

    if (theContext == nil) {
        return;
    }
    
    if (theContext.parentContext == nil) {
        [theContext performBlock:^{
            [self __save:theContext];
        }];
    } else {
        [theContext performBlockAndWait:^{
            [self __save:theContext];
        }];
    }
}
@end
