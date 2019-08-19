//
//  FuelPump.h
//  
//
//  Created by Siya9 on 08/02/17.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define PumpStatusChangeNotification @"PumpStatusChangeNotification"

NS_ASSUME_NONNULL_BEGIN

@interface FuelPump : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
-(void)updateFuelPumpFromSnyc:(NSDictionary *)dictFuelPump;
@end

NS_ASSUME_NONNULL_END

#import "FuelPump+CoreDataProperties.h"
