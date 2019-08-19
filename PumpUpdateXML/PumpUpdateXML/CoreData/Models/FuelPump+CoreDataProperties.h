//
//  FuelPump+CoreDataProperties.h
//  
//
//  Created by Siya9 on 08/02/17.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FuelPump.h"

NS_ASSUME_NONNULL_BEGIN

@interface FuelPump (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *amount;
@property (nullable, nonatomic, retain) NSNumber *amountLimit;
@property (nullable, nonatomic, retain) NSString *amountUnit;
@property (nullable, nonatomic, retain) NSString *cart;
@property (nullable, nonatomic, retain) NSNumber *fuelIndex;
@property (nullable, nonatomic, retain) NSNumber *fuelPrice;
@property (nullable, nonatomic, retain) NSString *fuelType;
@property (nullable, nonatomic, retain) NSNumber *isDelete;
@property (nullable, nonatomic, retain) NSNumber *isDiaplay;
@property (nullable, nonatomic, retain) NSNumber *isReserved;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSString *priceUnit;
@property (nullable, nonatomic, retain) NSNumber *pumpIndex;
@property (nullable, nonatomic, retain) NSNumber *pumpOrder;
@property (nullable, nonatomic, retain) NSDate *reserveTime;
@property (nullable, nonatomic, retain) NSString *serviceType;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSNumber *volume;
@property (nullable, nonatomic, retain) NSNumber *volumeLimit;
@property (nullable, nonatomic, retain) NSString *volumeUnit;

@end

NS_ASSUME_NONNULL_END
