//
//  RapidOnSitePumpCart.h
//  
//
//  Created by Siya9 on 10/02/17.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface RapidOnSitePumpCart : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
-(void)updateRapidOnSitePumpCart:(NSDictionary *)dictFuelPump;
@end

NS_ASSUME_NONNULL_END

#import "RapidOnSitePumpCart+CoreDataProperties.h"
