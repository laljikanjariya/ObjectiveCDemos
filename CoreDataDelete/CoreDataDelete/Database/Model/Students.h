//
//  Students.h
//  CoreDataDelete
//
//  Created by Siya Infotech on 21/10/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Books, Surname;

@interface Students : NSManagedObject

@property (nonatomic, retain) NSString * sname;
@property (nonatomic, retain) NSNumber * sid;
@property (nonatomic, retain) NSSet *books;
@property (nonatomic, retain) Surname *surnameid;
@end

@interface Students (CoreDataGeneratedAccessors)

- (void)addBooksObject:(Books *)value;
- (void)removeBooksObject:(Books *)value;
- (void)addBooks:(NSSet *)values;
- (void)removeBooks:(NSSet *)values;

@end
