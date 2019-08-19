//
//  PlayLists+CoreDataProperties.h
//  MySongs
//
//  Created by Siya Infotech on 11/02/16.
//  Copyright © 2016 Siya Infotech. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PlayLists.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayLists (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *pname;
@property (nullable, nonatomic, retain) NSSet<Songs *> *songs;

@end

@interface PlayLists (CoreDataGeneratedAccessors)

- (void)addSongsObject:(Songs *)value;
- (void)removeSongsObject:(Songs *)value;
- (void)addSongs:(NSSet<Songs *> *)values;
- (void)removeSongs:(NSSet<Songs *> *)values;

@end

NS_ASSUME_NONNULL_END
