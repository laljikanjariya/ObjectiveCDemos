//
//  DoManualTransactionRequest.m
//  PaxControllerApp
//
//  Created by siya-IOS5 on 12/16/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import "DoManualTransactionRequest.h"
#import "PaxRequest+Internal.h"

@implementation DoManualTransactionRequest

/*- (instancetype)initWithTransaction:(EdcTransactionType)transaction amount:(float)amount tipAmount:(float)tipAmount cashBackAmount:(float)cashBackAmount merchantFee:(float)merchantFee taxAmount:(float)taxAmount invoiceNumber:(NSString *)invoiceNumber referenceNumber:(NSString *)referenceNumber{
    self = [super initWithTransaction:transaction amount:amount tipAmount:tipAmount cashBackAmount:cashBackAmount merchantFee:merchantFee taxAmount:taxAmount invoiceNumber:invoiceNumber referenceNumber:referenceNumber];
    
    if (self) {
        _commandType = kPaxCommandDoCredit;
        _isAmountApplicable = YES;

    }
    return self;
}*/

- (instancetype)initWithManualTransaction:(EdcTransactionType)transaction amount:(float)amount tipAmount:(float)tipAmount cashBackAmount:(float)cashBackAmount merchantFee:(float)merchantFee taxAmount:(float)taxAmount invoiceNumber:(NSString *)invoiceNumber referenceNumber:(NSString *)referenceNumber withAccountNumber:(NSString *)accountNumber withcvvNumber:(NSString *)cvvNumber withexipryDate:(NSString *)exipryDate
{
    self = [super initWithTransaction:transaction amount:amount tipAmount:tipAmount cashBackAmount:cashBackAmount merchantFee:merchantFee taxAmount:taxAmount invoiceNumber:invoiceNumber referenceNumber:referenceNumber];

    if (self) {
        _commandType = kPaxCommandDoCredit;
        _isAmountApplicable = YES;
        _accountNumber = accountNumber;
        _cvvNumber = cvvNumber;
        _expiryDate = exipryDate;
    }
    return self;
}


-(NSData *)requestAccountInformation
{
    
    NSMutableData *accountInformationData = [[NSMutableData alloc] init];
    
    //// Account Number
    // Account Number : O : n...65
    [self appendToData:accountInformationData string:_accountNumber];
    
    //// ExpiryDate number
    // ExpiryDate number : O : n4
    [self appendToData:accountInformationData byte:PaxControlCharUS];
    [self appendToData:accountInformationData string:_expiryDate];
    
    
    //// CVV Code
    // CVV Code : O : n...4
    [self appendToData:accountInformationData byte:PaxControlCharUS];
    [self appendToData:accountInformationData string:_cvvNumber];

    // EBT type
//    [self appendToData:accountInformationData byte:PaxControlCharUS];
//    
//    // Voucher number
//    [self appendToData:accountInformationData byte:PaxControlCharUS];
//    
//    
//    // Dup Override Flag
//    [self appendToData:accountInformationData byte:PaxControlCharUS];


    return accountInformationData;
}

@end
