//
//  RapidGoogleDriveOperation.m
//  GoogleDriveDownload
//
//  Created by Siya-ios5 on 9/29/17.
//  Copyright © 2017 Siya-ios5. All rights reserved.
//

#import "RapidGoogleDriveOperation.h"

@interface RapidGoogleDriveOperation()
@property (nonatomic, strong) GoogleDriveFilesRespoce googleDriveFilesRespoce;

@end


@implementation RapidGoogleDriveOperation

-(instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}


- (void)googleDriveFiles:(GoogleDriveFilesRespoce)responce {
    self.googleDriveFilesRespoce = responce;
    GTLRDriveQuery_FilesList *query = [GTLRDriveQuery_FilesList query];
    query.fields = @"nextPageToken, files(id, name, mimeType,fileExtension)";
    query.q = @"mimeType = 'application/octet-stream'";
    self.service.shouldFetchNextPages = YES;
    [self.service executeQuery:query delegate:self didFinishSelector:@selector(displayResultWithTicket:finishedWithObject:error:)];
}

// Process the response and display output
- (void)displayResultWithTicket:(GTLRServiceTicket *)ticket finishedWithObject:(GTLRDrive_FileList *)result error:(NSError *)error {
    NSMutableArray *driveFiles = [[NSMutableArray alloc] init];
    if (error == nil) {
        if (result.files.count > 0) {
            for (GTLRDrive_File *file in result.files) {
                GoogleDriveFile *googleDriveFile = [[GoogleDriveFile alloc]initWithGTLRDriveFile:file];
                [driveFiles addObject:googleDriveFile];
            }
            self.googleDriveFilesRespoce(error, driveFiles);
        }
        else {
            self.googleDriveFilesRespoce(error, driveFiles);
        }
    } else {
        self.googleDriveFilesRespoce(error, driveFiles);
    }
}
@end
