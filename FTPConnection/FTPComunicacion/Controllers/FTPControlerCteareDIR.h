//
//  FTPControlerCteareDIR.h
//  FTPConnection
//
//  Created by Siya9 on 05/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "FTPControler.h"

@interface FTPControlerCteareDIR : FTPControler

+(instancetype)createDirectoryWith:(NSString *)strFTPpath directoryName:(NSString *)strDir userID:(NSString *)strUserId userPassword:(NSString *)strPassword forDelegate:(id)delegate;

@end
