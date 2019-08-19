//
//  Surname.h
//  CoreDataDelete
//
//  Created by Siya Infotech on 21/10/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Students;

@interface Surname : NSManagedObject

@property (nonatomic, retain) NSString * surname;
@property (nonatomic, retain) NSSet *surid;
@end

@interface Surname (CoreDataGeneratedAccessors)

- (void)addSuridObject:(Students *)value;
- (void)removeSuridObject:(Students *)value;
- (void)addSurid:(NSSet *)values;
- (void)removeSurid:(NSSet *)values;

@end
