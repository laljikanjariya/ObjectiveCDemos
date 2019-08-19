//
//  RapidOnSitePumpCart.m
//  
//
//  Created by Siya9 on 10/02/17.
//
//

#import "RapidOnSitePumpCart.h"

@implementation RapidOnSitePumpCart

// Insert code here to add functionality to your managed object subclass
-(void)updateRapidOnSitePumpCart:(NSDictionary *)dictFuelPump{
 
    if (dictFuelPump[@"Amount"]) {
        self.amount = dictFuelPump[@"Amount"];
    }
    if (dictFuelPump[@"Amount_Limit"]) {
        self.amountLimit = dictFuelPump[@"Amount_Limit"];
    }
 
    if (dictFuelPump[@"Cart"]) {
        self.cartId = dictFuelPump[@"Cart"];
    }
 
    if (dictFuelPump[@"State"]) {
        self.cartStatus = dictFuelPump[@"State"];
    }
 
    if (dictFuelPump[@"Fuel"]) {
        self.fuelIndex = dictFuelPump[@"Fuel"];
    }
 
    if (dictFuelPump[@"Price"]) {
        self.price = dictFuelPump[@"Price"];
    }
 
    if (dictFuelPump[@"Key"]) {
        self.pumpIndex = dictFuelPump[@"Key"];
    }
 
    if (dictFuelPump[@"Volume"]) {
        self.volume = dictFuelPump[@"Volume"];
    }
 
    if (dictFuelPump[@"Volume_Limit"]) {
        self.volumeLimit = dictFuelPump[@"Volume_Limit"];
    }
}
@end
