//
//  QueryManager.m
//  MySongs
//
//  Created by Siya Infotech on 25/12/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import "QueryManager.h"
#import "DatabaseManager.h"

@implementation QueryManager

+ (NSManagedObject *)InsertObject:(NSString *)object withContext:(NSManagedObjectContext *)moc isSave:(BOOL)isSave {
    NSManagedObject * newobject = [NSEntityDescription insertNewObjectForEntityForName:object inManagedObjectContext:moc];
    if (isSave) {
        [moc save:nil];
    }
    return newobject;
}
+ (void)deleteObject:(NSManagedObject *)object withContext:(NSManagedObjectContext *)moc isSave:(BOOL)isSave{
    [moc deleteObject:object];
    if (isSave) {
        [moc save:nil];
    }
}
+ (NSManagedObjectContext *)privateConextFromParentContext:(NSManagedObjectContext*)parentContext {
    // Create Provate context for this queue
    NSManagedObjectContext *privateManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [privateManagedObjectContext setParentContext:parentContext];
    [privateManagedObjectContext setUndoManager:nil];
    return privateManagedObjectContext;
}
@end
