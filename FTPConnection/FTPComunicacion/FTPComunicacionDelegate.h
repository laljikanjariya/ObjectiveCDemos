//
//  FTPComunicacionDelegate.h
//  FTPConnection
//
//  Created by Siya9 on 05/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FTPControler;

@protocol FTPComunicacionDelegate <NSObject>
@required
-(void)updateStatus:(FTPControler *)objFTPController WithError:(NSString *)error;
@optional
-(void)receiveList:(NSArray *)arrDirectory;
-(void)createDirectory:(BOOL)isCreated;
-(void)downloadFileTo:(NSString *)strPath;
-(void)uploadFileTo:(NSString *)strPath;

@end
