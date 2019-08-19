//
//  GoogleDriveFile.h
//  GoogleDriveDownload
//
//  Created by Siya-ios5 on 9/29/17.
//  Copyright © 2017 Siya-ios5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GTLRDrive.h>
#import <Google/SignIn.h>
#import "GTMSessionFetcher.h"

typedef NS_ENUM(NSInteger, DownloadStatus)
{
    NotDownload = 0,
    Downloading,
    Downloaded,
    DownloadError
};

@interface GoogleDriveFile : NSObject
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *identifier;
@property(nonatomic, strong) NSString *mimeType;
@property(nonatomic, strong) NSString *fileExtension;
@property(nonatomic, strong) NSString *fullFileExtension;
@property(nonatomic, strong) NSString *downloadURLPath;
@property(assign) DownloadStatus status;

-(instancetype)initWithGTLRDriveFile:(GTLRDrive_File *)file;

-(void)downloadFor:(GTLRDriveService *)service responce:(void(^)(bool isDownload))responce;
@end
