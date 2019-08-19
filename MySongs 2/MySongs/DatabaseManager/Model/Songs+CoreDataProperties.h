//
//  Songs+CoreDataProperties.h
//  MySongs
//
//  Created by Siya Infotech on 30/12/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Songs.h"

NS_ASSUME_NONNULL_BEGIN

@interface Songs (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *path;
@property (nullable, nonatomic, retain) NSNumber *duration;
@property (nullable, nonatomic, retain) NSSet<PlayLists *> *palylist;

@end

@interface Songs (CoreDataGeneratedAccessors)

- (void)addPalylistObject:(PlayLists *)value;
- (void)removePalylistObject:(PlayLists *)value;
- (void)addPalylist:(NSSet<PlayLists *> *)values;
- (void)removePalylist:(NSSet<PlayLists *> *)values;

@end

NS_ASSUME_NONNULL_END
