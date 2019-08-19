//
//  FTPControlerReadData.h
//  FTPConnection
//
//  Created by Siya9 on 06/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "FTPControler.h"

@interface FTPControlerReadData : FTPControler
+(instancetype)downloadFileTo:(NSString *)strFTPpath filePath:(NSString *)strFile userID:(NSString *)strUserId userPassword:(NSString *)strPassword forDelegate:(id)delegate;
@end
