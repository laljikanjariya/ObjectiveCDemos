//
//  PaxDevice.m
//  PaxTestApp
//
//  Created by Siya Infotech on 05/06/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import "PaxDevice.h"
#import "PaxRequest.h"
#import "PaxResponse.h"
#import "PaxResponse+Internal.h"

// Administrative
#import "InitializeRequest.h"
#import "GetVariableRequest.h"
#import "DoSignatureRequest.h"
#import "GetSignatureRequest.h"
// Transaction
#import "DoCreditRequest.h"
#import "DoDebitRequest.h"
#import "DoEbtRequest.h"
// Batch
#import "BatchCloseRequest.h"
#import "ForceBatchCloseRequest.h"
#import "BatchClearRequest.h"
#import "HostReportRequest.h"
#import "HistoryReportRequest.h"
#import "LocalTotalReportRequest.h"
#import "WebServiceConnection.h"
#import "DoManualTransactionRequest.h"
#import "Local DetailReportRequest.h"

// Simulate Response for develpoment
//#define SIMULATE_POSITIVE_RESPONSE

#ifndef DEBUG
    #ifdef SIMULATE_POSITIVE_RESPONSE
        #undef SIMULATE_POSITIVE_RESPONSE
    #endif
#else
    #define SIMULATE_RESPONSE_CODE PDResponseDoCredit
#endif


@interface PaxDevice () <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    NSString *serverIp;
    NSString *serverPort;
    NSMutableData *data;
    NSURLConnection *paxConnection;
    NSOperationQueue *paxDeviceQueue;

    NSLock *operationLock;
}
@property (nonatomic, readwrite) BOOL busy;

@end

@implementation PaxDevice
- (instancetype)initWithIp:(NSString*)_serverIp port:(NSString*)_port {
    self = [super init];
    
    if (self) {
        _busy = NO;
        serverIp = _serverIp;
        serverPort = _port;
        
        paxDeviceQueue = [[NSOperationQueue alloc] init];
        paxDeviceQueue.name = @"Queue.PaxDevice.Rms";
        
        [self setupLock];
    }
    return self;
}

- (void)dealloc {
    [paxConnection cancel];
    paxConnection = nil;
    data = nil;
}

#pragma mark - Request Common
- (void)sendRequestWithId:(PDRequest)pdRequest parameters:(NSDictionary*)parameters {
    [self lock];
    PaxRequest *request = nil;
    switch (pdRequest) {
        case PDRequestInitialize:
            request = [[InitializeRequest alloc] init];
            break;

        case PDRequestDoCredit:
        {
            float amount = [parameters[@"Amount"] floatValue];
            NSString *invoiceNumber = parameters[@"InvoiceNumber"];
            NSString *referenceNumber = parameters[@"ReferenceNumber"];
            request = [[DoCreditRequest alloc] initCreditAmount:amount invoiceNumber:invoiceNumber referenceNumber:referenceNumber];
        }
            break;

        default:
            break;
    }

    [self sendRequest:request];
}

- (void)sendRequest:(PaxRequest*)request {
    NSString *requestBase64String = [request base64String]; // @"Base64 string from Request..."; //
   
    if (self.paxDataDictionary != nil) {
        [self.paxDataDictionary setObject:requestBase64String forKey:@"RequestBase64String"];
    }

    NSMutableString *requestUrl = [NSMutableString string];
    [requestUrl appendString:@"http://"];
    [requestUrl appendString:serverIp];
    [requestUrl appendString:@":"];
    [requestUrl appendString:serverPort];
    [requestUrl appendString:@"/?"];

    [requestUrl appendString:requestBase64String];

    NSLog(@"Request Url = %@", requestUrl);

    [_paxDeviceDelegate paxDevice:self willSendRequest:requestUrl];

    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:[NSURL URLWithString:requestUrl]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:300.0];

    data = [[NSMutableData alloc] initWithCapacity:1024];
    paxConnection = [[NSURLConnection alloc] initWithRequest:urlrequest delegate:self startImmediately:NO];
    [paxConnection setDelegateQueue:paxDeviceQueue];
    [paxConnection start];
}

#pragma mark - Connectivity
- (void)checkConnectivity {
    [self initializeDevice];
}

#pragma mark - Request Specific
#pragma mark - Initialize
- (void)initializeDevice {
    [self sendRequestWithId:PDRequestInitialize parameters:nil];
}

#pragma mark - Get Variable
- (void)getVariable:(NSString*)variableName {
    
    self.paxDataDictionary = [[NSMutableDictionary alloc] init];
    [self.paxDataDictionary setObject:@"GetVariable"  forKey:@"Action"];
    PaxRequest *request = [[GetVariableRequest alloc] initWithVariableName:variableName];
    [self sendRequest:request];
}

#pragma mark -  Signture
// Do Signature
- (void)doSignatureWithEdcType:(EdcType)edcType {
    PaxRequest *request = [[DoSignatureRequest alloc] initWithEdcType:edcType];
    [self sendRequest:request];
}

// Get Signature
- (void)getSignature {
    PaxRequest *request = [[GetSignatureRequest alloc] init];
    [self sendRequest:request];
}

#pragma mark - Credit
- (void)setupPaxDataDictionary:(float)amount invoiceNumber:(NSString *)invoiceNumber referenceNumber:(NSString *)referenceNumber requestType:(NSString *)requestType {
    self.paxDataDictionary = [[NSMutableDictionary alloc] init];
    [self.paxDataDictionary setObject:[NSString stringWithFormat:@"%f",amount]  forKey:@"Amount"];
    [self.paxDataDictionary setObject:invoiceNumber forKey:@"InvoiceNumber"];
    [self.paxDataDictionary setObject:referenceNumber forKey:@"ReferenceNumber"];
    [self.paxDataDictionary setObject:requestType forKey:@"RequestType"];
}

- (void)doCreditWithAmount:(float)amount invoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber {
    PaxRequest *request = nil;
    
    request = [[DoCreditRequest alloc] initCreditAmount:amount invoiceNumber:invoiceNumber referenceNumber:referenceNumber];
    
    NSString *requestType = @"CreditAmount";
    [self setupPaxDataDictionary:amount invoiceNumber:invoiceNumber referenceNumber:referenceNumber requestType:requestType];
    
    [self sendRequest:request];
}

- (void)doCreditWithAmount:(float)amount tipAmount:(float)tipAmount invoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber {

    PaxRequest *request = [[DoCreditRequest alloc] initCreditAmount:amount tipAmount:tipAmount invoiceNumber:invoiceNumber referenceNumber:referenceNumber];
    NSString *requestType = @"CreditAmountWithTip";
    [self setupPaxDataDictionary:amount invoiceNumber:invoiceNumber referenceNumber:referenceNumber requestType:requestType];

    [self sendRequest:request];
}

- (void)doCreditWithAmount:(float)amount tipAmount:(float)tipAmount taxAmount:(float)taxAmount invoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber {

    PaxRequest *request = [[DoCreditRequest alloc] initCreditAmount:amount tipAmount:tipAmount taxAmount:taxAmount invoiceNumber:invoiceNumber referenceNumber:referenceNumber];
    NSString *requestType = @"CreditAmountWithTipAndTax";
    [self setupPaxDataDictionary:amount invoiceNumber:invoiceNumber referenceNumber:referenceNumber requestType:requestType];
    
    [self sendRequest:request];
}

- (void)doCreditAuthWithAmount:(float)amount tipAmount:(float)tipAmount taxAmount:(float)taxAmount invoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber {
    
    PaxRequest *request = [[DoCreditRequest alloc] initCreditAuthAmount:amount tipAmount:tipAmount taxAmount:taxAmount invoiceNumber:invoiceNumber referenceNumber:referenceNumber];
    NSString *requestType = @"CreditAmountWithAuth";
    [self setupPaxDataDictionary:amount invoiceNumber:invoiceNumber referenceNumber:referenceNumber requestType:requestType];
    
    [self sendRequest:request];
}
- (void)doCreditCaptureWithAmount:(float)amount withInvoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber transactionNumber:(NSString*)transactionNumber withAuthCode:(NSString *)authCode
{
    
    PaxRequest *request = [[DoCreditRequest alloc] initCreditCaptureAmount:amount withInvoiceNumber:invoiceNumber referenceNumber:referenceNumber TransactionNumber:transactionNumber withAuthCode:authCode];
    NSString *requestType = @"CreditAmountWithCapture";
    [self setupPaxDataDictionary:amount invoiceNumber:invoiceNumber referenceNumber:referenceNumber requestType:requestType];
    
    [self sendRequest:request];
}


- (void)doCreditPostAuthAmount:(float)amount withInvoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber TransactionNumber:(NSString*)transactionNumber withAuthCode:(NSString *)authCode
{
    
    PaxRequest *request = [[DoCreditRequest alloc] initCreditPostAuthAmount:amount withInvoiceNumber:invoiceNumber referenceNumber:referenceNumber TransactionNumber:transactionNumber withAuthCode:authCode];
    NSString *requestType = @"CreditAmountWithPostAuth";
    [self setupPaxDataDictionary:amount invoiceNumber:invoiceNumber referenceNumber:referenceNumber requestType:requestType];
    
    [self sendRequest:request];
}





- (void)doCreditManualTransactionWithAmount:(float)amount tipAmount:(float)tipAmount taxAmount:(float)taxAmount invoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber ithAccountNumber:(NSString *)accountNumber withcvvNumber:(NSString *)cvvNumber withexipryDate:(NSString *)exipryDate
{
    
    NSString *requestType = @"Credit Manual";
    [self setupPaxDataDictionary:amount invoiceNumber:invoiceNumber referenceNumber:referenceNumber requestType:requestType];

    PaxRequest *request = [[DoManualTransactionRequest alloc] initWithManualTransaction:EdcTransactionTypeSaleRedeem amount:amount tipAmount:tipAmount cashBackAmount:0.00 merchantFee:0.00 taxAmount:0.00 invoiceNumber:invoiceNumber referenceNumber:referenceNumber withAccountNumber:accountNumber withcvvNumber:cvvNumber withexipryDate:exipryDate];
//    PaxRequest *request = [[DoManualTransactionRequest alloc] initWithTransaction:EdcTransactionTypeSaleRedeem amount:amount tipAmount:tipAmount cashBackAmount:0 merchantFee:0 taxAmount:taxAmount invoiceNumber:invoiceNumber referenceNumber:referenceNumber];

    [self sendRequest:request];
}


- (void)adjustCreditTipAmount:(float)tipAmount invoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber transactionNumber:(NSString*)transactionNumber {
    
    NSString *requestType = @"AdjustTipAmount";
    [self setupPaxDataDictionary:tipAmount invoiceNumber:invoiceNumber referenceNumber:referenceNumber requestType:requestType];

    PaxRequest *request = [[DoCreditRequest alloc] initWithTipAdjustment:transactionNumber referenceNumber:referenceNumber tipAmount:tipAmount];

    
    [self sendRequest:request];
}

- (void)refundCreditAmount:(float)refundAmount transactionNumber:(NSString*)transactionNumber referenceNumber:(NSString*)referenceNumber withAuthCode:(NSString *)authCode {
    
    NSString *requestType = @"RefundCreditAmount";
    [self setupPaxDataDictionary:refundAmount invoiceNumber:transactionNumber referenceNumber:referenceNumber requestType:requestType];
    

    PaxRequest *request = [[DoCreditRequest alloc] initRefund:transactionNumber referenceNumber:referenceNumber amount:refundAmount withAuthCode:authCode];
    [self sendRequest:request];
}

- (void)voidCreditTransactionNumber:(NSString*)transactionNumber invoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber {
    
    NSString *requestType = @"VoidCredit";
    [self setupPaxDataDictionary:[transactionNumber floatValue] invoiceNumber:transactionNumber referenceNumber:referenceNumber requestType:requestType];

    
    PaxRequest *request = nil;
    request = [[DoCreditRequest alloc] initVoidTransactionNumber:transactionNumber invoiceNumber:invoiceNumber referenceNumber:referenceNumber];
    [self sendRequest:request];
}

#pragma mark - Debit
- (void)doDebitWithAmount:(float)amount invoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber {
    
    NSString *requestType = @"DebitAmount";
    [self setupPaxDataDictionary:amount invoiceNumber:invoiceNumber referenceNumber:referenceNumber requestType:requestType];

    
    PaxRequest *request = nil;
    
    
    request = [[DoDebitRequest alloc] initCreditAmount:amount invoiceNumber:invoiceNumber referenceNumber:referenceNumber];
    
    [self sendRequest:request];
}

- (void)doDebitWithAmount:(float)amount tipAmount:(float)tipAmount invoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber {
    
    NSString *requestType = @"DebitAmountWithTip";
    [self setupPaxDataDictionary:amount invoiceNumber:invoiceNumber referenceNumber:referenceNumber requestType:requestType];

    
    PaxRequest *request = [[DoDebitRequest alloc] initCreditAmount:amount tipAmount:tipAmount invoiceNumber:invoiceNumber referenceNumber:referenceNumber];
    
    [self sendRequest:request];
}

- (void)doDebitWithAmount:(float)amount tipAmount:(float)tipAmount taxAmount:(float)taxAmount invoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber {

    NSString *requestType = @"DebitAmountWithTipTax";
    [self setupPaxDataDictionary:amount invoiceNumber:invoiceNumber referenceNumber:referenceNumber requestType:requestType];

    
    PaxRequest *request = [[DoDebitRequest alloc] initCreditAmount:amount tipAmount:tipAmount taxAmount:taxAmount invoiceNumber:invoiceNumber referenceNumber:referenceNumber];
    
    [self sendRequest:request];
}

- (void)adjustDebitTipAmount:(float)tipAmount invoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber  transactionNumber:(NSString*)transactionNumber {
    NSLog(@"IMPLEMENT");
    NSString *requestType = @"AdjustDebitAmount";
    [self setupPaxDataDictionary:tipAmount invoiceNumber:invoiceNumber referenceNumber:referenceNumber requestType:requestType];

    
    PaxRequest *request = [[DoDebitRequest alloc] initWithTipAdjustment:transactionNumber referenceNumber:referenceNumber tipAmount:tipAmount];
    [self sendRequest:request];
}

- (void)refundDebitAmount:(float)refundAmount transactionNumber:(NSString*)transactionNumber referenceNumber:(NSString*)referenceNumber {
    
    NSString *requestType = @"RefundDebitAmount";
    [self setupPaxDataDictionary:refundAmount invoiceNumber:transactionNumber referenceNumber:referenceNumber requestType:requestType];

    
//    PaxRequest *request = [[DoDebitRequest alloc] initRefund:transactionNumber referenceNumber:referenceNumber amount:refundAmount];
//    [self sendRequest:request];
}

- (void)voidDebitTransactionNumber:(NSString*)transactionNumber invoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber {
    
    NSString *requestType = @"VoidDebitAmount";
    [self setupPaxDataDictionary:0.00 invoiceNumber:invoiceNumber referenceNumber:referenceNumber requestType:requestType];

    PaxRequest *request = nil;
    request = [[DoDebitRequest alloc] initVoidTransactionNumber:transactionNumber invoiceNumber:invoiceNumber referenceNumber:referenceNumber];
    [self sendRequest:request];
}

#define EBT_IMPLEMENTED
#ifdef EBT_IMPLEMENTED
#pragma mark - Ebt
- (void)doEbtWithAmount:(float)amount invoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber {
    
    
    NSString *requestType = @"DoEbtWithAmount";
    [self setupPaxDataDictionary:amount invoiceNumber:invoiceNumber referenceNumber:referenceNumber requestType:requestType];
    
    PaxRequest *request = nil;

    request = [[DoEbtRequest alloc] initCreditAmount:amount invoiceNumber:invoiceNumber referenceNumber:referenceNumber];

    [self sendRequest:request];
}

- (void)doEbtWithAmount:(float)amount tipAmount:(float)tipAmount invoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber {

    
    NSString *requestType = @"DoEbtWithTipAmount";
    [self setupPaxDataDictionary:amount invoiceNumber:invoiceNumber referenceNumber:referenceNumber requestType:requestType];

    
    PaxRequest *request = [[DoEbtRequest alloc] initCreditAmount:amount tipAmount:tipAmount invoiceNumber:invoiceNumber referenceNumber:referenceNumber];

    [self sendRequest:request];
}

- (void)doEbtWithAmount:(float)amount tipAmount:(float)tipAmount taxAmount:(float)taxAmount invoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber {

    
    NSString *requestType = @"DoEbtWithTipAmountAndTax";
    [self setupPaxDataDictionary:amount invoiceNumber:invoiceNumber referenceNumber:referenceNumber requestType:requestType];

    
    PaxRequest *request = [[DoEbtRequest alloc] initCreditAmount:amount tipAmount:tipAmount taxAmount:taxAmount invoiceNumber:invoiceNumber referenceNumber:referenceNumber];

    [self sendRequest:request];
}

- (void)adjustEbtTipAmount:(float)tipAmount invoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber {
    NSLog(@"IMPLEMENT");
}

- (void)refundEbtAmount:(float)refundAmount transactionNumber:(NSString*)transactionNumber referenceNumber:(NSString*)referenceNumber {
    
    NSString *requestType = @"RefundEBT";
    [self setupPaxDataDictionary:refundAmount invoiceNumber:transactionNumber referenceNumber:referenceNumber requestType:requestType];

    
//    PaxRequest *request = [[DoEbtRequest alloc] initRefund:transactionNumber referenceNumber:referenceNumber amount:refundAmount];
//    [self sendRequest:request];
}


- (void)voidEbtTransactionNumber:(NSString*)transactionNumber invoiceNumber:(NSString*)invoiceNumber referenceNumber:(NSString*)referenceNumber {
    
    NSString *requestType = @"VoidEBT";
    [self setupPaxDataDictionary:0.00 invoiceNumber:transactionNumber referenceNumber:referenceNumber requestType:requestType];

    PaxRequest *request = nil;
    request = [[DoEbtRequest alloc] initVoidTransactionNumber:transactionNumber invoiceNumber:invoiceNumber referenceNumber:referenceNumber];
    [self sendRequest:request];
}


-(void)configurePaxDataDictionaryWithAmount:(NSString *)amount withInvoiceNo:(NSString *)invoiceNo withReferenceNo:(NSString *)referenceNo withRequestType:(NSString *)requestType
{
    self.paxDataDictionary = [[NSMutableDictionary alloc] init];
    [self.paxDataDictionary setObject:amount  forKey:@"Amount"];
    [self.paxDataDictionary setObject:invoiceNo forKey:@"InvoiceNumber"];
    [self.paxDataDictionary setObject:referenceNo forKey:@"ReferenceNumber"];
    [self.paxDataDictionary setObject:requestType forKey:@"RequestType"];
}

#endif


#pragma mark - Host Report
-(void)hostReport
{
    self.paxDataDictionary = [[NSMutableDictionary alloc] init];
    [self.paxDataDictionary setObject:@"0.00"  forKey:@"Amount"];
    [self.paxDataDictionary setObject:@"1111" forKey:@"InvoiceNumber"];
    [self.paxDataDictionary setObject:@"1111" forKey:@"ReferenceNumber"];
    [self.paxDataDictionary setObject:@"hostReport" forKey:@"RequestType"];
    PaxRequest *request = [[HostReportRequest alloc] init];
    [self sendRequest:request];
}
- (void)historyReport
{
    self.paxDataDictionary = [[NSMutableDictionary alloc] init];
    [self.paxDataDictionary setObject:@"0.00"  forKey:@"Amount"];
    [self.paxDataDictionary setObject:@"1111" forKey:@"InvoiceNumber"];
    [self.paxDataDictionary setObject:@"1111" forKey:@"ReferenceNumber"];
    [self.paxDataDictionary setObject:@"historyReport" forKey:@"RequestType"];
    PaxRequest *request = [[HistoryReportRequest alloc] init];
    [self sendRequest:request];
}
- (void)localTotalReport
{
    self.paxDataDictionary = [[NSMutableDictionary alloc] init];
    [self.paxDataDictionary setObject:@"0.00"  forKey:@"Amount"];
    [self.paxDataDictionary setObject:@"1111" forKey:@"InvoiceNumber"];
    [self.paxDataDictionary setObject:@"1111" forKey:@"ReferenceNumber"];
    [self.paxDataDictionary setObject:@"localTotalReport" forKey:@"RequestType"];
    PaxRequest *request = [[LocalTotalReportRequest alloc] init];
    [self sendRequest:request];
}



#pragma mark - Batch
- (void)closeBatch {
    self.paxDataDictionary = [[NSMutableDictionary alloc] init];
    [self.paxDataDictionary setObject:@"0.00"  forKey:@"Amount"];
    [self.paxDataDictionary setObject:@"1111" forKey:@"InvoiceNumber"];
    [self.paxDataDictionary setObject:@"1111" forKey:@"ReferenceNumber"];
    [self.paxDataDictionary setObject:@"closeBatch" forKey:@"RequestType"];
    

    PaxRequest *request = [[BatchCloseRequest alloc] init];
    [self sendRequest:request];
}


- (void)getLocalDetailReportForRecordNumber:(NSInteger)recordNumber {
    self.paxDataDictionary = [[NSMutableDictionary alloc] init];
    [self.paxDataDictionary setObject:@"0.00"  forKey:@"Amount"];
    [self.paxDataDictionary setObject:@"1111" forKey:@"InvoiceNumber"];
    [self.paxDataDictionary setObject:@"1111" forKey:@"ReferenceNumber"];
    [self.paxDataDictionary setObject:@"getLocalDetailReport" forKey:@"RequestType"];

    PaxRequest *request = [[Local_DetailReportRequest alloc] initWithRecordNumber:recordNumber];
    [self sendRequest:request];
}

- (void)forceCloseBatch {
    PaxRequest *request = [[ForceBatchCloseRequest alloc] init];
    [self sendRequest:request];
}

- (void)clearBatch:(EdcType)edcType {
    PaxRequest *request = [[BatchClearRequest alloc] initWithEdcType:edcType];
    [self sendRequest:request];
}


#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    [data setLength:0];
    data = [NSMutableData data];

    NSHTTPURLResponse *r = (NSHTTPURLResponse*) response;
    NSDictionary *headers = [r allHeaderFields];

    NSLog(@"Code = %d\nheaders = %@\n", r.statusCode, headers);

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)incrementalData {
    [data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
    NSLog(@"Success");
    paxConnection = nil;
    PaxResponse *response = [PaxResponse responseFromData:data];
  

    if (self.paxDataDictionary != nil) {
        NSString *base64String = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [self.paxDataDictionary setObject:base64String forKey:@"ResponseData"];
        
        if (response.responseCode.integerValue == 0) {
            [_paxDeviceDelegate paxDevice:self response:response];
            [self.paxDataDictionary setObject:@"Success" forKey:@"ResponseStatus"];
        }
        else
        {
            [_paxDeviceDelegate paxDevice:self failed:nil response:response];
            [self.paxDataDictionary setObject:@"FailureWithResponseCode" forKey:@"ResponseStatus"];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableDictionary *paxDataDictionary = [[NSMutableDictionary alloc] init];
            NSError * err;
            NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:self.paxDataDictionary options:0 error:&err];
            NSString * myString = [[NSString alloc] initWithData:jsonData  encoding:NSUTF8StringEncoding];
            [paxDataDictionary setObject:myString forKey:@"PaxData"];
            
            WebServiceConnection *webserviceConnection = [[WebServiceConnection alloc] init];
            webserviceConnection = [webserviceConnection initWithJSONKey:nil JSONValues:paxDataDictionary actionName:@"InsertPax" URL:@"http://rapidrmswebsite.trafficmanager.net/WcfService/Service.svc/" NotificationName:@"RecallInvoiceListResult"];
        });
        

    }
    
      data = nil;
    [self unlock];
}

- (void)connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)error {
#ifdef SIMULATE_POSITIVE_RESPONSE
    [self simulatePositiveResponse];
    return;
#else
    NSLog(@"Failure");
    [_paxDeviceDelegate paxDevice:self failed:error response:nil];
#endif
    
    paxConnection = nil;
    [self unlock];
    
    if (self.paxDataDictionary != nil) {

        NSString *base64String = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [self.paxDataDictionary setObject:base64String forKey:@"ResponseData"];
        [self.paxDataDictionary setObject:@"Failure" forKey:@"ResponseStatus"];
        NSMutableDictionary *paxDataDictionary = [[NSMutableDictionary alloc] init];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:self.paxDataDictionary options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData  encoding:NSUTF8StringEncoding];
        [paxDataDictionary setObject:myString forKey:@"PaxData"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            WebServiceConnection *webserviceConnection = [[WebServiceConnection alloc] init];
            webserviceConnection = [webserviceConnection initWithJSONKey:nil JSONValues:paxDataDictionary actionName:@"InsertPax" URL:@"http://rapidrmswebsite.trafficmanager.net/WcfService/Service.svc/" NotificationName:@"RecallInvoiceListResult"];
        });

    }

    data = nil;

}

- (void)setupLock {
    // TODO: Different threads are using operationLock for locking and unlocking it.
    // Need to address this. Till then we will not create NSLock object.
//    operationLock = [[NSLock alloc] init];
}

- (void)lock {
    [operationLock lock];
}

- (void)unlock {
    [operationLock unlock];
}

#ifdef SIMULATE_POSITIVE_RESPONSE
- (NSData *)dataFromSimulatedResponseString:(NSString *)responseString {
    NSMutableData *simulatedResponseData = [NSMutableData data];
    
    responseString = [responseString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSInteger count = responseString.length;
    
    for (NSInteger index = 0; index < count; index += 2) {
        NSRange range;
        range.location = index;
        range.length = 2;
        NSString *subString = [responseString substringWithRange:range];
        
        char cString[3];
        strcpy(cString, [subString cStringUsingEncoding:NSASCIIStringEncoding]);
        unsigned char byte = (unsigned char) strtol(cString, NULL, 16);
        [PaxResponse appendByte:byte toData:simulatedResponseData];
    }
    
    return simulatedResponseData;
}

- (void)simulatePositiveResponse {
    NSData *simulatedResponseData;
    
    switch (self.pdResponse) {
        case PDResponseDoCredit:
        {
            
         //   NSString *responseString = @"02301c41 30311c31 2e33321c 30303030 30301c30 313233 313235 303731";
       /*     NSString *responseString = @"02301c54 30311c31 2e33321c 30303030 30301c4f 4b1c3030 1f415050 524f5641 4c1f3331 33333335 1f353139 32313336 34333237 371f1f31 1c30311c 3130301f 301f301f 301f301f 301f1f1c 34313131 1f321f31 3232351f 1f1f1f30 321f1f1f 1f301c34 1f311f32 30313530 37313130 39353031 381c1f1c 1c1c5349 474e5354 41545553 3d341f54 433d3045 35323846 31453731 42423845 41361f54 56523d30 34303030 30383030 301f4149 443d4130 30303030 30303034 31303130 1f415443 3d303030 411f4150 504c4142 3d4d4153 54455243 4152441f 41505050 4e3d4d61 73746572 43617264 43726564 69740310";*/

//     NSString *responseString = @"02301c54 30311c31 2e33321c 30303030 30301c4f 4b1c3030 1f415050 524f5641 4c1f3331 33333337 1f353139 32313336 34333231 351f1f31 1c30311c 3130301f 301f301f 301f301f 301f1f1c 34313131 1f341f31 3232351f 1f1f1f30 321f4449 20546573 742f4361 72642030 361f1f1f 301c351f 311f3230 31353037 31313039 35333134 1c1f1c1c 1c534947 4e535441 5455533d 341f5443 3d323730 41323135 41413241 35414534 351f5456 523d3038 30303030 38303030 1f414944 3d413030 30303030 30303431 3031301f 5453493d 45383030 1f415443 3d303030 421f4150 504c4142 3d4d4153 54455243 4152441f 41505050 4e3d4d61 73746572 43617264 43726564 69740353";
            
//            NSString *responseString = @"02301c54 30311c31 2e33331c 30303030 30301c4f 4b1c3030 1f415050 524f5641 4c1f3639 32303630 1f353239 39313637 35353838 341f1f31 351c3031 1c363030 1f301f30 1f301f30 1f301f1f 1c343131 311f341f 31323235 1f1f1f1f 30321f44 49205465 73742f43 61726420 30361f1f 1f301c32 1f2d311f 32303135 31303236 32303433 32371c1f 1c1c1c53 49474e53 54415455 533d4e1f 54433d35 42423131 33304433 44303042 3237301f 5456523d 30383030 30303830 30301f41 49443d41 30303030 30303030 34313031 301f5453 493d4538 30301f41 54433d30 3030351f 4150504c 41423d4d 41535445 52434152 441f4150 50504e3d 4d617374 65724361 72644372 65646974 1f43564d 3d310373";
            
            
//            NSString *responseString = @"02301c54 30311c31 2e33331c 30303030 30301c4f 4b1c3030 1f415050 524f5641 4c1f3539 38383530 1f353331 30313730 35313337 361f1f31 371c3031 1c343030 1f301f30 1f301f30 1f301f1f 1c343131 311f341f 31323235 1f1f1f1f 30321f44 49205465 73742f43 61726420 30361f1f 1f301c31 1f2d311f 32303135 31313036 32323130 35341c1f 1c1c1c53 49474e53 54415455 533d4e1f 54433d35 30334144 32454536 30463041 3537371f 5456523d 30383030 30303830 30301f41 49443d41 30303030 30303030 34313031 301f5453 493d4538 30301f41 54433d30 3031341f 4150504c 41423d4d 41535445 52434152 441f4150 50504e3d 4d617374 65724361 72644372 65646974 1f43564d 3d310302";
//  NSString *responseString =  @"02301c54 30311c31 2e33331c 30303030 30301c4f 4b1c3030 1f415050 524f5641 4c1f3031 31343031 1f353331 30313730 35313637 341f1f31 371c3031 1c353031 1f301f30 1f301f30 1f301f1f 1c303231 361f311f 31323137 1f1f1f1f 30341f43 4152442f 494d4147 45203136 20202020 20202020 20202020 201f1f1f 301c331f 2d311f32 30313531 31303632 32313431 381c1f1c 1c1c0322";
            
            
//           NSString *responseString =   @"02301c54 30311c31 2e33331c 30303030 30301c4f 4b1c3030 1f415050 524f5641 4c1f3230 35363833 1f353331 30313730 35313339 301f1f31 371c3031 1c353031 1f301f30 1f301f30 1f301f1f 1c303231 361f341f 31323137 1f1f1f1f 30341f43 4152442f 494d4147 45203136 1f1f1f30 1c341f2d 311f3230 31353131 30363232 31343439 1c1f1c1c 1c534947 4e535441 5455533d 4e1f5443 3d454231 37343643 36363544 30394134 331f5456 523d3432 30303034 38303030 1f414944 3d413030 30303030 31353233 3031301f 5453493d 45383030 1f415443 3d303030 391f4150 504c4142 3d444953 434f5645 521f4356 4d3d3203 43";
//          NSString *responseString =   @"02301c54 30311c31 2e33331c 30303030 30301c4f 4b1c3030 1f415050 524f5641 4c1f3630 30333641 1f353334 34313738 33313736 391f1f32 341c3137 1c353335 1f301f30 1f301f30 1f301f1f 1c303131 391f301f 31323232 1f1f1f1f 30311f1f 1f1f311c 32311f41 43313231 30313530 32333234 301f3230 31353132 31303033 34323137 1c1f1c1c 1c54433d 37373838 45333644 45453241 45344436 1f545652 3d303830 30303038 3030301f 4149443d 41303030 30303030 30333130 31301f54 53493d46 3830301f 4154433d 30303143 1f415050 4c41423d 56697361 20437265 6469741f 41505050 4e3d5669 73612043 72656469 741f4356 4d3d3603 3e";
            
            
            NSString *responseString  = @"02301c54 30311c31 2e33331c 30303030 30301c4f 4b1c3030 1f415050 524f5641 4c1f3038 38353241 1f363231 39313238 35393233 361f1f39 361c3031 1c313839 391f301f 301f301f 301f301f 1f1c3031 31391f32 1f313232 321f1f1f 1f30311f 1f1f1f30 1c34321f 53523331 39343832 361f3230 31363038 30363039 33313139 1c1f1c1c 1c54433d 42334643 41393341 30384330 34394632 1f545652 3d303030 30303030 3030301f 4149443d 41303030 30303030 30333130 31301f54 53493d30 3030301f 4154433d 30314533 1f415050 4c41423d 56697361 20437265 6469741f 43564d3d 360316";
            
            
            
            
//            responseString = @"02301c54 30331c31 2e33331c 31303030 30331c54 4158204e 4f542041 4c4c4f57 45440339";
//        responseString   = @"02301c54 30331c31 2e33331c 31303030 30341c55 4e535550 504f5254 20545241 4e530350";
//             NSString *responseString =  @"02301c54 30311c31 2e33331c 30303030 30301c4f 4b1c3030 1f415050 524f5641 4c1f3539 38383537 1f353331 30313730 35313636 301f1f31 371c3031 1c363030 1f301f30 1f301f30 1f301f1f 1c343131 311f341f 31323235 1f1f1f1f 30321f44 49205465 73742f43 61726420 30361f1f 1f301c32 1f2d311f 32303135 31313036 32323132 33391c1f 1c1c1c53 49474e53 54415455 533d4e1f 54433d30 31384143 38413136 34434644 3530361f 5456523d 30383030 30303830 30301f41 49443d41 30303030 30303030 34313031 301f5453 493d4538 30301f41 54433d30 3031351f 4150504c 41423d4d 41535445 52434152 441f4150 50504e3d 4d617374 65724361 72644372 65646974 1f43564d 3d310308";
            
//           NSString *responseString =   @"02301c42 30311c31 2e33331c 30303030 30301c4f 4b1c301f 5f414343 45505445 441f1f1f 1f31351c 383d303d 303d303d 303d303d 301c3132 3930313d 303d303d 303d303d 303d301c 32303135 31303236 32303530 33341c35 38323734 38351c37 37373730 30383839 37363503 22";
            
            
            
//            NSString *responseString = @"02301c54 30311c31 2e33321c 30303030 30301c4f 4b1c3030 1f415050 524f5641 4c1f3334 38393838 1f353230 31313338 32333430 331f1f31 1c30311c 38333930 1f301f30 1f301f30 1f301f1f 1c343131 311f341f 31323235 1f1f1f1f 30321f44 49205465 73742f43 61726420 30361f1f 1f301c31 301f311f 32303135 30373230 30393235 31361c1f 1c1c1c53 49474e53 54415455 533d341f 54433d38 44433931 44363642 33314446 3343451f 5456523d 30383030 30303830 30301f41 49443d41 30303030 30303030 34313031 301f5453 493d4538 30301f41 54433d30 3030351f 4150504c 41423d4d 41535445 52434152 441f4150 50504e3d 4d617374 65724361 72644372 65646974 0327";
            
//            NSString *responseString = @"02301c54 30311c31 2e33321c 30303030 30301c4f 4b1c3030 1f415050 524f5641 4c1f3334 38393838 1f353230 31313338 32333430 331f1f31 1c30311c 38333930 1f301f30 1f301f30 1f301f1f 1c343131 311f341f 31323235 1f1f1f1f 30321f44 49205465 73742f43 61726420 30361f1f 1f301c31 301f311f 32303135 30373230 30393235 31361c1f 1c1c1c53 49474e53 54415455 533d341f 54433d38 44433931 44363642 33314446 3343451f 5456523d 30383030 30303830 30301f41 49443d41 30303030 30303030 34313031 301f5453 493d4538 30301f41 54433d30 3030351f 4150504c 41423d4d 41535445 52434152 441f4150 50504e3d 4d617374 65724361 72644372 65646974 0327";

            // Get Signature
//            NSString *responseString = @"02301c41 30391c31 2e33321c 30303030 30301c4f 4b1c313233 1c313233 1c  31302C3130305E32302C35305E35302C36305E37302C3130305E302C36353533355E32302C32305E3130302C3130305E3131302C3130305E3132302C35305E3133302C305E3134302C37357E  03 45";


//            NSString *responseString = @"02301c54 30311c31 2e33321c 31303030 30321c41 424f5254 45440330";
            
//            NSString *responseString = @"02301c54 30311c31 2e33321c 31303030 30321c41 424f5254 45440330";

            // GetVariableResponse
//            NSString *responseString = @"02301c4130331c313032351c3030303030301c4f4f1c4E0330";

            simulatedResponseData = [self dataFromSimulatedResponseString:responseString];
        }
            break;
            case PDResponseHostReport:
        {
            NSString *responseString = @"02301c52 3037 1c31 2e33321c 30303030 30301c4f 4b1c 361c 4372 6564 6974 5f53 616c 655f 416d 6f75 6e74 3d31 3931 3038 332e 3030 1c 4375 7272 656e 7420 4261 7463 681c 3230 3131 3037 3233 3138 3236 3434";
            
           responseString = @"02301c52 30371c31 2e33321c 30303030 30301c4f 4b1c 361c 4372 6564 6974 5f53 616c 655f 416d 6f75 6e74 3d31 3931 3038 332e 3030 1f 4372 6564 6974 5f52 6574 7572 6e5f 416d 6f75 6e74 3d31 3033 302e 3936 1f 4372 6564 6974 5f53 616c 655f 436f 756e 743d 3731 351f 4372 6564 6974 5f52 6574 7572 6e5f 436f 756e 743d 3832 1c 4375 7272 656e 7420 4261 7463 681c 3230 3131 3037 3233 3138 3236 3434";
            simulatedResponseData = [self dataFromSimulatedResponseString:responseString];
        }
            break;
        case PDResponseLocalDetailReport:
        {
//            NSString *responseString = @"02301c5230 331c312e 32361c30 30303030 301c4f4b 1c311c30 1c303139 37323135 31303938 38373030 30303030 1f1c3031 1c30311c 1c343030 1c353435 34303132 31323939 311f1c31 31323031 31303732 33313735 3735341f 1c1c1c1c 1c";
//            NSString *responseString = @"02301c52 30331c31 2e33331c 31303030 32331c4e 4f542046 4f554e44 035e";
            
//            NSString *responseString = @"02301c52 30331c31 2e33331c 30303030 30301c4f 4b1c321c 301c3030 1f415050 524f5641 4c1f3037 37373341 1f363031 31313834 37353332 341f1f32 1c30311c 30311c1c 32343630 1f301f30 1f301f30 1f301f1f 1c303131 391f321f 31323232 1f1f1f1f 30311f20 2f1f1f1f 301c311f 41413031 31313136 32333135 32331f32 30313630 31313132 33313835 331c1f1c 1c1c5443 3d463830 44334131 41433235 32424536 381f5456 523d3030 30303030 30303030 1f414944 3d413030 30303030 30303331 3031301f 5453493d 30303030 1f415443 3d303032 321f4150 504c4142 3d566973 61204372 65646974 031c";
            
            
            NSString *responseString = @"02301c52 30331c31 2e33331c 30303030 30301c4f 4b1c331c 301c3030 1f415050 524f5641 4c1f3038 32303041 1f363031 31313834 37373835 361f1f33 1c30311c 30311c1c 3831301f 301f301f 301f301f 301f1f1c 30313139 1f321f31 3232321f 1f1f1f30 311f1f1f 1f301c31 1f414130 31313231 36303035 3430391f 32303136 30313132 30303537 33381c1f 1c1c1c54 433d4130 41313843 39424445 45303342 38311f54 56523d30 30303030 30303030 301f4149 443d4130 30303030 30303033 31303130 1f545349 3d303030 301f4154 433d3030 32341f41 50504c41 423d5669 73612043 72656469 74035f";

            
            simulatedResponseData = [self dataFromSimulatedResponseString:responseString];
        }
            break;
        case PDResponseHistoryReport:
        {
            NSString * responseString = @"02301c5230 39 1c31 2e33321c 30303030 30301c4f 4b 1c 313d 303d 303d 303d 303d 303d 301c 3430 303d 303d 303d 303d 303d 303d 301c 3230 3131 3037 3137 3537 3534 1c 5041 5875 7374 6573 741c";
            simulatedResponseData = [self dataFromSimulatedResponseString:responseString];
        }
            break;
        default:
            break;
    }
    
    data = [simulatedResponseData mutableCopy];
    if (simulatedResponseData) {
        [self connectionDidFinishLoading:nil];
    } else {
        NSLog(@"No simulation available for response code = %d", SIMULATE_RESPONSE_CODE);
       // [_paxDeviceDelegate paxDevice:self failed:nil];
    }
}
#endif
@end
