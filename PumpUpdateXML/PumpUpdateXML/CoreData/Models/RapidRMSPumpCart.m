//
//  RapidRMSPumpCart.m
//  
//
//  Created by Siya9 on 10/02/17.
//
//

#import "RapidRMSPumpCart.h"

@implementation RapidRMSPumpCart

// Insert code here to add functionality to your managed object subclass
-(void)updateCartDictDictionaryFromLive:(NSDictionary *)cartDictionary {
    if (cartDictionary[@"CartId"]) {
        self.cartId = cartDictionary[@"CartId"];
    }
    if (cartDictionary[@"FuelId"]) {
        self.fuelIndex = cartDictionary[@"FuelId"];
    }
    if (cartDictionary[@"Amount"]) {
        self.amount = @([cartDictionary[@"Amount"] floatValue]);
    }
    if (cartDictionary[@"AmountLimit"]) {
        self.amountLimit = @([cartDictionary[@"AmountLimit"] floatValue]);
    }
    if (cartDictionary[@"AmountLimit"]) {
        self.approvedAmount = @([cartDictionary[@"AmountLimit"] floatValue]);
    }
    if (self.amountLimit &&  self.amount) {
        float balanceAmount = self.amountLimit.integerValue - self.amount.integerValue;
        self.balanceAmount = @(balanceAmount);
    }
    if (cartDictionary[@"CartStatus"]){
        self.pumpStatus = cartDictionary[@"CartStatus"];
    }
    if (cartDictionary[@"CartId"]) {
        self.cartId  = cartDictionary[@"CartId"];
    }
    if (cartDictionary[@"FuelId"]) {
        self.fuelIndex = @([cartDictionary[@"FuelId"] integerValue]);
    }
    if (cartDictionary[@"isPaid"]) {
        self.isPaid = @([cartDictionary[@"isPaid"] integerValue]);
    }
    if (cartDictionary[@"PayId"]) {
        self.paymentModeId = @([cartDictionary[@"PayId"] integerValue]);
    }
    if (cartDictionary[@"PayType"]) {
        self.paymentState = @([cartDictionary[@"PayType"] integerValue]);
    }
    if (cartDictionary[@"PricePerGallon"]) {
        self.price = @([cartDictionary[@"PricePerGallon"] floatValue]);
    }
    if (cartDictionary[@"PumpId"]) {
        self.pumpIndex = @([cartDictionary[@"PumpId"] integerValue]);
    }
    if (cartDictionary[@"RegInvNum"]) {
        self.regInvNum = cartDictionary[@"RegInvNum"];
    }
    if (cartDictionary[@"RegisterNumber"]) {
        self.registerNumber = @([cartDictionary[@"RegisterNumber"] integerValue]);
    }
    if (cartDictionary[@"UserId"]) {
        self.userId = @([cartDictionary[@"UserId"] integerValue]);
    }
    if (cartDictionary[@"Volume"]) {
        self.volume = @([cartDictionary[@"Volume"] floatValue]);
    }
    if (cartDictionary[@"VolumeLimit"]) {
        self.volumeLimit = @([cartDictionary[@"VolumeLimit"] floatValue]);
    }
    if(!self.timeStamp){
        self.timeStamp = [NSDate date];
    }
    if([[cartDictionary valueForKey:@"TransactionType"] isKindOfClass:[NSString class]]){
        self.transactionType = cartDictionary[@"TransactionType"];
    }
}
@end
