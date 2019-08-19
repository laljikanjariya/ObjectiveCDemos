//
//  UpdateLogManager.h
//  DebugLog
//
//  Created by Siya9 on 19/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PumpDBManager.h"

@interface UpdatePumpManager : NSObject

+ (void)saveContext:(NSManagedObjectContext*)theContext;
+ (NSManagedObjectContext *)privateConextFromParentContext:(NSManagedObjectContext*)parentContext;
+ (void)deleteFromContext:(NSManagedObjectContext *)theContext objectId:(NSManagedObjectID*)anObjectId;

+ (NSArray <NSManagedObject *> *)fetchEntityWithName:(NSString*)entityName key:(NSString*)key value:(id)value shouldCreate:(BOOL)shouldCreate moc:(NSManagedObjectContext*)moc;
@end
