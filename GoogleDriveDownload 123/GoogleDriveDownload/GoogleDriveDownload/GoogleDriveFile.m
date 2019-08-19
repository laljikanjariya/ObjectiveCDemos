//
//  GoogleDriveFile.m
//  GoogleDriveDownload
//
//  Created by Siya-ios5 on 9/29/17.
//  Copyright © 2017 Siya-ios5. All rights reserved.
//

#import "GoogleDriveFile.h"
#import "GTLRDrive.h"

@implementation GoogleDriveFile

-(instancetype)initWithGTLRDriveFile:(GTLRDrive_File *)file
{
    self = [super init];
    
    if (self) {
        self.fileExtension = file.fileExtension;
        self.name = file.name;
        self.identifier = file.identifier;
        self.mimeType = file.mimeType;
        self.fullFileExtension = file.fullFileExtension;
        self.status = NotDownload;
    }
    return self;
}

-(void)downloadFor:(GTLRDriveService *)service responce:(void(^)(bool isDownload))responce {
    
    GTLRQuery *query = [GTLRDriveQuery_FilesGet queryForMediaWithFileId:self.identifier];
    [service executeQuery:query completionHandler:^(GTLRServiceTicket *ticket, GTLRDataObject *file, NSError *error) {
        if (error == nil) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *pathFloder = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",self.name]];
            NSString *defaultDBPath = [documentsDirectory stringByAppendingPathComponent:pathFloder];
            
            [file.data writeToFile:defaultDBPath atomically:YES];
            self.status = Downloaded;
            responce(TRUE);
        } else {
            self.status = DownloadError;
            responce(FALSE);
            NSLog(@"An error occurred: %@", error);
        }
    }];
}
@end
