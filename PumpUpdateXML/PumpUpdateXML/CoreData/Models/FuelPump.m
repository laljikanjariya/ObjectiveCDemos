//
//  FuelPump.m
//  
//
//  Created by Siya9 on 08/02/17.
//
//

#import "FuelPump.h"

@implementation FuelPump

// Insert code here to add functionality to your managed object subclass
-(void)updateFuelPumpFromSnyc:(NSDictionary *)dictFuelPump{
    NSString * strOldStatus = self.status;
    if (dictFuelPump[@"Amount"]) {
        self.amount = @([dictFuelPump[@"Amount"] floatValue]);
    }
    if (dictFuelPump[@"Amount_Limit"]) {
        self.amountLimit = @([dictFuelPump[@"Amount_Limit"] floatValue]);
    }
    if (dictFuelPump[@"amountUnit"]) {
        self.amountUnit = dictFuelPump[@"amountUnit"];
    }
    if (dictFuelPump[@"Cart"]) {
        self.cart = dictFuelPump[@"Cart"];
    }
    if (dictFuelPump[@"fuelIndex"]) {
        self.fuelIndex = dictFuelPump[@"fuelIndex"];
    }
    if (dictFuelPump[@"fuelPrice"]) {
        self.fuelPrice = dictFuelPump[@"fuelPrice"];
    }
    if (dictFuelPump[@"Fuel"]) {
        self.fuelType = dictFuelPump[@"Fuel"];
    }
    if (dictFuelPump[@"isDelete"]) {
        self.isDelete = dictFuelPump[@"isDelete"];
    }
    if (dictFuelPump[@"isDiaplay"]) {
        self.isDiaplay = dictFuelPump[@"isDiaplay"];
    }
    if (dictFuelPump[@"isReserved"]) {
        self.isReserved = dictFuelPump[@"isReserved"];
    }
    if (dictFuelPump[@"name"]) {
        self.name = dictFuelPump[@"name"];
    }
    if (dictFuelPump[@"Price"]) {
        self.price = @([dictFuelPump[@"Price"] floatValue]);
    }
    if (dictFuelPump[@"priceUnit"]) {
        self.priceUnit = dictFuelPump[@"priceUnit"];
    }
    if (dictFuelPump[@"Key"]) {
        self.pumpIndex = @([dictFuelPump[@"Key"] integerValue]);
    }
    if (dictFuelPump[@"pumpOrder"]) {
        self.pumpOrder = @([dictFuelPump[@"pumpOrder"] integerValue]);
    }
    if (dictFuelPump[@"reserveTime"]) {
        self.reserveTime = dictFuelPump[@"reserveTime"];
    }
    
    if (dictFuelPump[@"serviceType"]) {
        self.serviceType = dictFuelPump[@"serviceType"];
    }
    if (dictFuelPump[@"State"]) {
        self.status = dictFuelPump[@"State"];
    }
    if (dictFuelPump[@"Volume"]) {
        self.volume = @([dictFuelPump[@"Volume"] floatValue]);
    }
    if (dictFuelPump[@"Volume_Limit"]) {
        self.volumeLimit = @([dictFuelPump[@"Volume_Limit"] floatValue]);
    }
    
    if (dictFuelPump[@"volumeUnit"]) {
        self.volumeUnit = dictFuelPump[@"volumeUnit"];
    }
    if (strOldStatus != nil && ![strOldStatus isEqualToString:self.status] && self.cart) {
        [self postNotificationFuelPumpStatusChange:strOldStatus newStatus:self.status];
    }
}
-(void)postNotificationFuelPumpStatusChange:(NSString *)strOldStatus newStatus:(NSString *)strNewStatus{
    [[NSNotificationCenter defaultCenter]postNotificationName:PumpStatusChangeNotification object:nil userInfo:@{@"oldStatus":strOldStatus,@"newStatus":strNewStatus,@"PumpIndex":self.pumpIndex,@"CartId":self.cart}];
}
@end
