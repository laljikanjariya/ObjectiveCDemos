//
//  FTPControler.h
//  FTPConnection
//
//  Created by Siya9 on 05/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CFNetwork/CFNetwork.h>
#import "FTPComunicacionDelegate.h"

@interface FTPControler : NSObject

@property (nonatomic, weak) id <FTPComunicacionDelegate> delegate;

@property (nonatomic, strong, readwrite) NSInputStream *   objInputStream;
@property (nonatomic, strong, readwrite) NSOutputStream *  objOutputStream;


@property (nonatomic, strong) NSString * ftpPath;
@property (nonatomic, strong) NSString * fileOrDir;
@property (nonatomic, strong) NSString * fileTempPath;

@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * password;

-(void)openForCreateDIRStream;
-(void)openReceiveList;
-(void)openWriteData;
-(void)openReadData;

-(void)stopOpretion;
@end
