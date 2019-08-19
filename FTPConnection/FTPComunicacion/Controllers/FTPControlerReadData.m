//
//  FTPControlerReadData.m
//  FTPConnection
//
//  Created by Siya9 on 06/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "FTPControlerReadData.h"

@implementation FTPControlerReadData

+(instancetype)downloadFileTo:(NSString *)strFTPpath filePath:(NSString *)strFile userID:(NSString *)strUserId userPassword:(NSString *)strPassword forDelegate:(id)delegate {
    FTPControlerReadData * ovjCreate = [[FTPControlerReadData alloc]init];
    ovjCreate.ftpPath = strFTPpath;
    ovjCreate.fileOrDir= strFile;
    
    ovjCreate.userName= strUserId;
    ovjCreate.password= strPassword;
    ovjCreate.delegate = delegate;
    [ovjCreate openReadData];
    return ovjCreate;

}
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
// An NSStream delegate callback that's called when events happen on our
// network stream.
{
#pragma unused(aStream)
    assert(aStream == self.objInputStream);
    
    switch (eventCode) {
        case NSStreamEventOpenCompleted: {
            [self sendErrorMessage:@"Opened connection"];
        } break;
        case NSStreamEventHasBytesAvailable: {
            NSInteger       bytesRead;
            uint8_t         buffer[32768];

            bytesRead = [self.objInputStream read:buffer maxLength:sizeof(buffer)];
            if (bytesRead == -1) {
                [self sendErrorMessage:@"Network read error"];
            } else if (bytesRead == 0) {
                [self moveTempFile];
                [self.delegate downloadFileTo:self.fileOrDir];
                [self stopStream];
            } else {
                NSInteger   bytesWritten;
                NSInteger   bytesWrittenSoFar;
                
                bytesWrittenSoFar = 0;
                do {
                    bytesWritten = [self.objOutputStream write:&buffer[bytesWrittenSoFar] maxLength:(NSUInteger) (bytesRead - bytesWrittenSoFar)];
                    assert(bytesWritten != 0);
                    if (bytesWritten == -1) {
                        [self sendErrorMessage:@"File write error"];
                        break;
                    } else {
                        bytesWrittenSoFar += bytesWritten;
                    }
                } while (bytesWrittenSoFar != bytesRead);
            }
        } break;
        case NSStreamEventHasSpaceAvailable: {
            assert(NO);     // should never happen for the output stream
        } break;
        case NSStreamEventErrorOccurred: {
            [self sendErrorMessage:@"Stream open error"];
        } break;
        case NSStreamEventEndEncountered: {
            // ignore
        } break;
        default: {
            assert(NO);
        } break;
    }
}

-(void)moveTempFile{
    [[NSFileManager defaultManager] moveItemAtPath:self.fileTempPath toPath:self.fileOrDir error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:self.fileTempPath error:nil];
}
-(void)sendErrorMessage:(NSString *)message{
    [self.delegate updateStatus:self WithError:message];
    [self stopStream];
}
-(void)stopStream{
    [self.objInputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    self.objInputStream.delegate = nil;
    [self.objInputStream close];
    self.objInputStream = nil;
}
@end
