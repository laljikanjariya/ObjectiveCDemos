//
//  DoManualTransactionRequest.h
//  PaxControllerApp
//
//  Created by siya-IOS5 on 12/16/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import "DoCreditRequest.h"

@interface DoManualTransactionRequest : DoCreditRequest
- (instancetype)initWithManualTransaction:(EdcTransactionType)transaction amount:(float)amount tipAmount:(float)tipAmount cashBackAmount:(float)cashBackAmount merchantFee:(float)merchantFee taxAmount:(float)taxAmount invoiceNumber:(NSString *)invoiceNumber referenceNumber:(NSString *)referenceNumber withAccountNumber:(NSString *)accountNumber withcvvNumber:(NSString *)cvvNumber withexipryDate:(NSString *)exipryDate;
@end
