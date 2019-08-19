//
//  QueryManager.h
//  MySongs
//
//  Created by Siya Infotech on 25/12/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseModel.h"
@interface QueryManager : NSObject

+ (NSManagedObjectContext *)privateConextFromParentContext:(NSManagedObjectContext*)parentContext;

+ (NSManagedObject *)InsertObject:(NSString *)object withContext:(NSManagedObjectContext *)moc isSave:(BOOL)isSave;
+ (void)deleteObject:(NSManagedObject *)object withContext:(NSManagedObjectContext *)moc isSave:(BOOL)isSave;

@end
