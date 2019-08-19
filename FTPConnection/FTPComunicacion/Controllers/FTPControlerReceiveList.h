//
//  FTPControlerReceiveList.h
//  FTPConnection
//
//  Created by Siya9 on 05/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "FTPControler.h"

@interface FTPControlerReceiveList : FTPControler

@property (nonatomic, strong, readwrite) NSMutableData *   listData;
@property (nonatomic, strong, readwrite) NSMutableArray *  listEntries;


+(instancetype)listOfDirectoryWith:(NSString *)strFTPpath userID:(NSString *)strUserId userPassword:(NSString *)strPassword forDelegate:(id)delegate;
@end
