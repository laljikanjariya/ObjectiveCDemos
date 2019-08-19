//
//  RapidOnSitePumpCart+CoreDataProperties.h
//  
//
//  Created by Siya9 on 10/02/17.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RapidOnSitePumpCart.h"

NS_ASSUME_NONNULL_BEGIN

@interface RapidOnSitePumpCart (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *amount;
@property (nullable, nonatomic, retain) NSNumber *amountLimit;
@property (nullable, nonatomic, retain) NSString *cartId;
@property (nullable, nonatomic, retain) NSString *cartStatus;
@property (nullable, nonatomic, retain) NSNumber *fuelIndex;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSNumber *pumpIndex;
@property (nullable, nonatomic, retain) NSNumber *volume;
@property (nullable, nonatomic, retain) NSNumber *volumeLimit;
@property (nullable, nonatomic, retain) NSDate *timeStamp;

@end

NS_ASSUME_NONNULL_END
