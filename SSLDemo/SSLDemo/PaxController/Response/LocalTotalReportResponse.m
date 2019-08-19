//
//  LocalTotalReportResponse.m
//  PaxControllerApp
//
//  Created by siya-IOS5 on 9/18/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import "LocalTotalReportResponse.h"
#import "PaxResponse+Internal.h"

@implementation LocalTotalReportResponse
- (void)setupMessageFormat {
    responseMessageFields = @[
                              @(FieldIndexMultiPacket),
                              @(FieldIndexCommandType),
                              @(FieldIndexVersion),
                              @(FieldIndexResponseCode),
                              @(FieldIndexResponseMessage),
                              @(FieldIndexLocalTotalReportEDCType),
                              @(FieldIndexLocalTotalReportTotalData),
                              ];
}

- (void)parseFieldData:(NSData *)fieldData forFieldId:(FieldIndex)fieldId {
    switch (fieldId) {
        case FieldIndexLocalTotalReportEDCType:
            [self parseEDCType:fieldData];
            break;
        case FieldIndexLocalTotalReportTotalData:
            [self parseLocalTotalReportTotalData:fieldData];
            break;
              default:
            [super parseFieldData:fieldData forFieldId:fieldId];
            break;
    }
}
-(void)parseEDCType:(NSData *)data
{
    NSInteger length = 2;
     self.edcType = [PaxResponse ansStringFrom:0 maxLength:length data:data];
}
- (NSArray *)fieldDetailAtIndex:(LocalTotalReportDetailParsingIndexs)localTotalReportDetailParsingIndex
{
    NSArray *fieldsArray;
    
    switch (localTotalReportDetailParsingIndex) {
        case LocalTotalReportCredit:
            fieldsArray = [self creditFieldArray];
            break;
        case LocalTotalReportDebit:
            fieldsArray = [self debitFieldArray];
            break;
        case LocalTotalReportEBT:
             fieldsArray = [self ebtFieldArray];
            break;
        case LocalTotalReportGift:
             fieldsArray = [self giftFieldArray];
            break;
        case LocalTotalReportLOYALTY:
             fieldsArray = [self loyaltyFieldArray];
            break;
        case LocalTotalReportCASH:
              fieldsArray = [self cashFieldArray];
            break;
        case LocalTotalReportCHECK:
              fieldsArray = [self checkFieldArray];
            break;
            
        default:
            break;
    }
    return fieldsArray;
}

-(void)parseLocalTotalReportTotalData:(NSData *)data
{
    NSString *totalLocalReportDetail = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    NSArray *totalLocalReportDetails = [totalLocalReportDetail componentsSeparatedByString:@"&"];
    
    LocalTotalReportDetailParsingIndexs localTotalReportDetailParsingIndexs = LocalTotalReportCredit;
    
    self.totalLocalReportDetailArray = [[NSMutableArray alloc] init];
    
    for (NSString *totalLocalReportDetailString in totalLocalReportDetails) {
        NSArray *fieldsArray = [self fieldDetailAtIndex:localTotalReportDetailParsingIndexs];
        NSArray *totalLocalReportDetailArray = [totalLocalReportDetailString componentsSeparatedByString:@"="];
        NSMutableDictionary *localReportDictionary = [[NSMutableDictionary alloc] init];
        for (int i =0 ; i < [totalLocalReportDetailArray count]; i++) {
            [localReportDictionary setObject:totalLocalReportDetailArray[i] forKey:fieldsArray[i]];
        }
        [self.totalLocalReportDetailArray addObject:localReportDictionary];
        localTotalReportDetailParsingIndexs++;
    }
    
}
-(NSArray *)creditFieldArray
{
    return  [NSArray arrayWithObjects:@"saleCount",
             @"SaleAmount",
             @"forcedCount",
             @"forcedAmount",
             @"returnCount",
             @"returnAmount",
             @"authCount",
             @"authAmount",
             @"postauthCount",
             @"postauthAmount",
             nil];
}
-(NSArray *)debitFieldArray
{
    return  [NSArray arrayWithObjects:@"saleCount",
             @"SaleAmount",
             @"returnCount",
             @"returnAmount",
             nil];
}
-(NSArray *)ebtFieldArray
{
    return  [NSArray arrayWithObjects:@"saleCount",
             @"SaleAmount",
             @"returnCount",
             @"returnAmount",
             @"withdrawalCount",
             @"withdrawalAmount",
             nil];
}
-(NSArray *)cashFieldArray
{
    return  [NSArray arrayWithObjects:@"saleCount",
             @"SaleAmount",
             @"returnCount",
             @"returnAmount",
             nil];
}
-(NSArray *)checkFieldArray
{
    return  [NSArray arrayWithObjects:@"saleCount",
             @"SaleAmount",
             @"AdjustCount",
             @"AdjustAmount",
             nil];
}
-(NSArray *)giftFieldArray
{
    return  [NSArray arrayWithObjects:@"saleCount",
             @"SaleAmount",
             @"authCount",
             @"authAmount",
             @"postauthCount",
             @"postauthAmount",
             @"activateCount",
             @"activateAmount",
             @"issueCount",
             @"issueAmount",
             @"addCount",
             @"addAmount",
             @"returnCount",
             @"returnAmount",
             @"forcedCount",
             @"forcedAmount",
             @"cashoutCount",
             @"cashoutAmount",
             @"deactivateCount",
             @"deactivateAmount",
             @"adjustCount",
             @"adjustAmount",
             nil];

}
-(NSArray *)loyaltyFieldArray
{
    return  [NSArray arrayWithObjects:
             @"redeemCount",
             @"redeemAmount",
             @"issueCount",
             @"issueAmount",
             @"addCount",
             @"addAmount",
             @"returnCount",
             @"returnAmount",
             @"forcedCount",
             @"forcedAmount",
             @"activateCount",
             @"activateAmount",
             @"deactivateCount",
             @"deactivateAmount",
             nil];
}

@end
