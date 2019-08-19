//
//  LiveUpdateManager.m
//  MyChat
//
//  Created by Siya9 on 11/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "LiveUpdateManager.h"

@implementation LiveUpdateManager


+ (NSArray *)fetchEntityWithName:(NSString*)entityName key:(NSString*)key value:(id)value shouldCreate:(BOOL)shouldCreate moc:(NSManagedObjectContext*)moc
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:moc];
    fetchRequest.entity = entity;

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@",key,value];
    fetchRequest.predicate = predicate;
    NSArray * arrFinded = [LiveUpdateManager executeForContext:moc FetchRequest:fetchRequest];
    
    if (arrFinded.count == 0) {
        if (shouldCreate) {
            arrFinded = @[[NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:moc]];
        }
    }
    return arrFinded;
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

+ (NSUInteger)countForContext:(NSManagedObjectContext*)theContext FetchRequest:(NSFetchRequest*)fetchRequest {
    NSUInteger result = 0;
    NSError *error = nil;
    
    @try {
        result = [theContext countForFetchRequest:fetchRequest error:&error];
    }
    @catch (NSException *exception) {
        NSLog(@"Error while executing fetch request occured. %@", exception);
        result = 0;
    }
    @finally {
    }
    
    return result;
}
#pragma mark - Save -
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
+ (void)__save:(NSManagedObjectContext *)theContext {
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
#pragma mark - Delete -
+ (void)deleteFromContext:(NSManagedObjectContext*)theContext object:(NSManagedObject*)anObject {
    @try {
        [theContext deleteObject:anObject];
    }
    @catch (NSException *exception) {
        NSLog(@"Non recoverable error occured while deleting. %@", exception);
    }
    @finally {
        
    }
    
}
+ (void)deleteFromContext:(NSManagedObjectContext*)theContext objectId:(NSManagedObjectID*)anObjectId {
    @try {
        NSManagedObject * anObject = [theContext objectWithID:anObjectId];
        [LiveUpdateManager deleteFromContext:theContext object:anObject];
    }
    @catch (NSException *exception) {
        NSLog(@"Non recoverable error occured while deleting. %@", exception);
    }
    @finally {
        
    }
    
}
@end
