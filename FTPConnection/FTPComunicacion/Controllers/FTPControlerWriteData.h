//
//  FTPControlerWriteData.h
//  FTPConnection
//
//  Created by Siya9 on 06/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "FTPControler.h"

@interface FTPControlerWriteData : FTPControler

+(instancetype)uploadFileToFTPPath:(NSString *)strFTPpath fileLocalPath:(NSString *)strFile userID:(NSString *)strUserId userPassword:(NSString *)strPassword forDelegate:(id)delegate;

@end
