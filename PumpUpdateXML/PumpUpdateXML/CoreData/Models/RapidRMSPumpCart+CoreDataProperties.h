//
//  RapidRMSPumpCart+CoreDataProperties.h
//  
//
//  Created by Siya9 on 10/02/17.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RapidRMSPumpCart.h"

NS_ASSUME_NONNULL_BEGIN

@interface RapidRMSPumpCart (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *amount;
@property (nullable, nonatomic, retain) NSNumber *amountLimit;
@property (nullable, nonatomic, retain) NSNumber *approvedAmount;
@property (nullable, nonatomic, retain) NSNumber *balanceAmount;
@property (nullable, nonatomic, retain) NSNumber *caculatedFuelPrice;
@property (nullable, nonatomic, retain) NSString *cartId;
@property (nullable, nonatomic, retain) NSString *cartStatus;
@property (nullable, nonatomic, retain) NSNumber *fuelIndex;
@property (nullable, nonatomic, retain) NSNumber *isPaid;
@property (nullable, nonatomic, retain) NSNumber *paymentModeId;
@property (nullable, nonatomic, retain) NSNumber *paymentState;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSNumber *pumpIndex;
@property (nullable, nonatomic, retain) NSString *pumpStatus;
@property (nullable, nonatomic, retain) NSString *regInvNum;
@property (nullable, nonatomic, retain) NSNumber *registerNumber;
@property (nullable, nonatomic, retain) NSString *serviceType;
@property (nullable, nonatomic, retain) NSDate *timeStamp;
@property (nullable, nonatomic, retain) NSString *transactionType;
@property (nullable, nonatomic, retain) NSNumber *userId;
@property (nullable, nonatomic, retain) NSNumber *volume;
@property (nullable, nonatomic, retain) NSNumber *volumeLimit;

@end

NS_ASSUME_NONNULL_END
