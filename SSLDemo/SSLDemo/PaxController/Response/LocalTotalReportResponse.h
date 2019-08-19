//
//  LocalTotalReportResponse.h
//  PaxControllerApp
//
//  Created by siya-IOS5 on 9/18/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaxResponse.h"
typedef NS_ENUM(NSInteger, LocalTotalReportDetailParsingIndexs) {
    LocalTotalReportCredit,
    LocalTotalReportDebit,
    LocalTotalReportEBT,
    LocalTotalReportGift,
    LocalTotalReportLOYALTY,
    LocalTotalReportCASH,
    LocalTotalReportCHECK,
};


@interface LocalTotalReportResponse : PaxResponse
@property (nonatomic,strong) NSString *edcType;
@property (nonatomic ,strong) NSMutableArray *totalLocalReportDetailArray;

@end
