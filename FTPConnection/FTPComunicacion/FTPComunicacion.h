//
//  FTPComunicacion.h
//  FTPComunicacion
//
//  Created by Siya9 on 05/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTPControler.h"
#import "FTPControlerCteareDIR.h"
//#import "FTPControlerDeleteFile.h"
#import "FTPControlerReceiveList.h"
#import "FTPControlerWriteData.h"
#import "FTPControlerReadData.h"
#import "FTPComunicacionDelegate.h"
#import "FTPStatus.h"


typedef NS_OPTIONS(NSUInteger, FTPErrorMessage) {
    FTPErrorMessagea,
};

//! Project version number for FTPComunicacion.
FOUNDATION_EXPORT double FTPComunicacionVersionNumber;

//! Project version string for FTPComunicacion.
FOUNDATION_EXPORT const unsigned char FTPComunicacionVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <FTPComunicacion/PublicHeader.h>


