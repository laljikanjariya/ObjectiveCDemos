//
//  Books.h
//  CoreDataDelete
//
//  Created by Siya Infotech on 21/10/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Students;

@interface Books : NSManagedObject

@property (nonatomic, retain) NSString * bname;
@property (nonatomic, retain) NSSet *bid;
@end

@interface Books (CoreDataGeneratedAccessors)

- (void)addBidObject:(Students *)value;
- (void)removeBidObject:(Students *)value;
- (void)addBid:(NSSet *)values;
- (void)removeBid:(NSSet *)values;

@end
